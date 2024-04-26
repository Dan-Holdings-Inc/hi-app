import { Injectable } from "@nestjs/common";
import { Alarm } from "../../entity/entities/alarm";
import { DbService } from "src/infrastructure/db/db.service";
import { HiService } from "../hi/hi.service";
import dayjs, { Dayjs } from "dayjs";
import { TIMEZONE } from "src/utils";

@Injectable()
export class AlarmService {
  constructor(
    private dbService: DbService,
    private hiService: HiService
  ) {}

  init() {}

  /**
   * 次のアラームを設定する日時を計算します。
   */
  static calculateAlarmDate(alarm: Alarm) {
    const today: Dayjs = dayjs().tz(TIMEZONE);
    const timeRegex = /(\d\d?):(\d\d?)/;
    const time = alarm.getUpAt.match(timeRegex);
    const hour = Number(time[1]);
    const minute = Number(time[2]);
    //次回のアラーム曜日
    let howManyDaysAfter = 0;
    let index = 0;
    if (alarm.daysToAlarm[today.day()]) {
      const expectedDate = today.set("hour", hour).set("minute", minute);
      const passedAlready = today.unix() - expectedDate.unix() > 0;
      howManyDaysAfter = passedAlready ? 1 : 0;
      index = passedAlready ? (today.day() + 1) % 7 : today.day();
    } else {
      howManyDaysAfter = 1;
      index = (today.day() + 1) % 7;
    }
    while (!alarm.daysToAlarm[index]) {
      howManyDaysAfter += 1;
      index = (index + 1) % 7;
    }
    const date = today.add(howManyDaysAfter, "day");
    return date;
  }
}

class AlarmStore {
  private store = new Map<string, Alarm>();

  add(alarm: Alarm) {}

  remove(key: string) {}

  static buildKey(day: Dayjs) {
    return day.format("YYYY/MM/DD HH:mm:ss");
  }
}
