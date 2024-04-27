import { Injectable } from "@nestjs/common";
import { Alarm } from "../../entity/entities/alarm";
import * as dayjs from "dayjs";
import { TIMEZONE } from "../../utils";
import * as timezone from "dayjs/plugin/timezone";
import * as utc from "dayjs/plugin/utc";
import { DbService } from "../../infrastructure/db/db.service";
import { HiService } from "../hi/hi.service";
import * as cron from "node-cron";
import { AlarmSession } from "src/entity/entities/alarm-session";
import { randomUUID } from "crypto";
import { PenaltyHistory } from "src/entity/entities/penalty-history";
dayjs.extend(utc);
dayjs.extend(timezone);
@Injectable()
export class AlarmService {
  constructor(
    private dbService: DbService,
    private hiService: HiService
  ) {
    this.setUpAlarms();
    // cron.schedule("0 29 16 * * *", () => {
    //   this.setUpAlarms();
    // });
  }

  async setUpAlarms() {
    //TODO: 今日に設定されているアラームのみスケジューリングするようにする
    await this.dbService.alarmSessions.deleteMany({});
    const cursor = this.dbService.alarms.find({}).lean().cursor();
    const now = dayjs();
    for (
      let alarm = await cursor.next();
      alarm != null;
      alarm = await cursor.next()
    ) {
      const date = this.calculateAlarmDate(now, alarm);
      const cronExpression = this.createCronExpression(date);
      const alarmSession: AlarmSession = {
        _id: randomUUID(),
        userId: alarm.userId,
        round: 1,
        startDate: date.toDate(),
      };
      await this.dbService.alarmSessions.create(alarmSession);
      cron.schedule(cronExpression, async () => {
        await this.cronCallback(alarm.userId);
      });
    }
  }

  private cronCallback = async (userId: string) => {
    const alarmSession = await this.dbService.alarmSessions
      .findOne({ userId })
      .exec();
    const user = await this.dbService.users
      .findOne({
        _id: userId,
      })
      .lean()
      .exec();
    let message = "";
    if (alarmSession.round === 1) {
      message = "起床時間です。";
    } else {
      message = "二度寝していませんか？";
    }

    try {
      await this.hiService.sendHi("system", user, message);
    } catch (error) {
      console.error(error);
    }

    alarmSession.round += 1;
    alarmSession.isNew = false;

    if (alarmSession.round > 3) {
      await alarmSession.deleteOne().exec();
    } else {
      await alarmSession.save();
      const dateToNotifyNextTime = dayjs
        .tz(alarmSession.startDate, TIMEZONE)
        .add(alarmSession.round - 1, "hour");
      const cronExpressionForNextRound =
        this.createCronExpression(dateToNotifyNextTime);
      cron.schedule(cronExpressionForNextRound, () => {
        this.cronCallback(alarmSession.userId);
      });
      const detectionWithinMinute = 1;
      const dateToDetectPenalty = dayjs()
        .tz(TIMEZONE)
        .add(detectionWithinMinute, "minute");
      const cronExpressionForPenaltyDetection =
        this.createCronExpression(dateToDetectPenalty);
      cron.schedule(cronExpressionForPenaltyDetection, () => {
        this.detectPenalty(userId, detectionWithinMinute);
      });
    }
  };

  /**
   * 次のアラームを設定する日時を計算します。
   */
  private calculateAlarmDate(now: dayjs.Dayjs, alarm: Alarm) {
    const timeRegex = /(\d\d?):(\d\d?)/;
    const getUpTime = alarm.getUpAt.match(timeRegex);
    const hour = Number(getUpTime[1]);
    const minute = Number(getUpTime[2]);
    //次回のアラーム曜日
    let howManyDaysAfter = 0;
    let index = 0;
    if (alarm.daysToAlarm[now.day()]) {
      const expectedDate = now
        .set("hour", hour)
        .set("minute", minute)
        .set("second", 0);
      const passedAlready = now.unix() - expectedDate.unix() > 0;
      howManyDaysAfter = passedAlready ? 1 : 0;
      index = passedAlready ? (now.day() + 1) % 7 : now.day();
    } else {
      howManyDaysAfter = 1;
      index = (now.day() + 1) % 7;
    }
    while (!alarm.daysToAlarm[index]) {
      howManyDaysAfter += 1;
      index = (index + 1) % 7;
    }
    const date = now
      .add(howManyDaysAfter, "day")
      .set("hour", hour)
      .set("minute", minute)
      .set("second", 0)
      .tz(TIMEZONE);

    return date;
  }

  private detectPenalty = async (userId: string, withinMinute: number = 5) => {
    const end = dayjs().tz(TIMEZONE);
    const start = end.subtract(withinMinute, "minute");
    const hasPenalty = !(await this.hasSentHiWithinPeriod(userId, start, end));
    if (hasPenalty) {
      const penaltyHisotry: PenaltyHistory = {
        _id: randomUUID(),
        userId,
        date: dayjs().tz(TIMEZONE).toDate(),
      };
      await this.dbService.penaltyHistories.create(penaltyHisotry);
      return penaltyHisotry;
    }
    return null;
  };

  private async hasSentHiWithinPeriod(
    userId: string,
    start: dayjs.Dayjs,
    end: dayjs.Dayjs
  ) {
    const his = await this.dbService.hiHistories
      .find({
        senderUserId: userId,
        date: {
          $gte: start.tz(TIMEZONE).toDate(),
          $lte: end.tz(TIMEZONE).toDate(),
        },
      })
      .lean()
      .exec();
    return his.length > 0;
  }

  /**
   * Cron書式の文字列を生成します
   * @param date
   */
  private createCronExpression(date: dayjs.Dayjs) {
    const second = date.second();
    const minute = date.minute();
    const hour = date.hour();
    const dateOfMonth = date.date();
    const month = date.month() + 1; //month indexは0-11なので一つ足す。
    const week = date.day();
    const year = date.year();
    return `${second} ${minute} ${hour} ${dateOfMonth} ${month} ${week} ${year}`;
  }
}
