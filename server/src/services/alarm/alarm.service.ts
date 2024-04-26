import { Injectable } from "@nestjs/common";
import { Alarm } from "../../entity/entities/alarm";
import * as dayjs from "dayjs";
import { TIMEZONE } from "../../utils";
import * as timezone from "dayjs/plugin/timezone";
import * as utc from "dayjs/plugin/utc";
import { DbService } from "../../infrastructure/db/db.service";
dayjs.extend(utc);
dayjs.extend(timezone);
@Injectable()
export class AlarmService {
  constructor(private dbService: DbService) {}

  async init() {
    const cursor = this.dbService.alarms.find({}).lean().cursor();
    const now = dayjs();
    for (
      let alarm = await cursor.next();
      alarm != null;
      alarm = await cursor.next()
    ) {
      const date = this.calculateAlarmDate(now, alarm);
    }
  }

  /**
   * 次のアラームを設定する日時を計算します。
   */
  calculateAlarmDate(now: dayjs.Dayjs, alarm: Alarm) {
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

  /**
   * Cron書式の文字列を生成します
   * @param date
   */
  createCronSyntaxString(date: dayjs.Dayjs) {
    const second = date.second();
    const minute = date.minute();
    const hour = date.hour();
    const day = date.date();
    const month = date.month() + 1; //month indexは0-11なので一つ足す。
    const year = date.year();
    return `${second} ${minute} ${hour} ${day} ${month} ${year}`;
  }
}

class AlarmStore {
  private store = new Map<string, Alarm>();

  add(alarm: Alarm) {}

  remove(key: string) {}

  static buildKey(day: dayjs.Dayjs) {
    return day.format("YYYY/MM/DD HH:mm:ss");
  }
}
