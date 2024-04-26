import { Injectable } from "@nestjs/common";
import { Alarm } from "../../entity/entities/alarm";
import * as dayjs from "dayjs";
import { TIMEZONE } from "../../utils";
import * as timezone from "dayjs/plugin/timezone";
import * as utc from "dayjs/plugin/utc";
dayjs.extend(utc);
dayjs.extend(timezone);
@Injectable()
export class AlarmService {
  constructor() {}

  init() {}

  /**
   * 次のアラームを設定する日時を計算します。
   */
  static calculateAlarmDate(now: dayjs.Dayjs, alarm: Alarm) {
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
}

class AlarmStore {
  private store = new Map<string, Alarm>();

  add(alarm: Alarm) {}

  remove(key: string) {}

  static buildKey(day: dayjs.Dayjs) {
    return day.format("YYYY/MM/DD HH:mm:ss");
  }
}
