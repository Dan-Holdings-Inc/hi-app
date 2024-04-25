import { Injectable } from "@nestjs/common";
import { Alarm } from "../../entity/entities/alarm";
import { DbService } from "src/infrastructure/db/db.service";
import { HiService } from "../hi/hi.service";
import dayjs, { Dayjs } from "dayjs";

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
  private calculateAlarmDate(alarm: Alarm) {
    const today = dayjs();
    //現在の曜日
    const currentDay = today.day();
    let nextDateToAlarm = today.add(Math.abs(7 - currentDay), "day");
    //次回のアラーム曜日
    for (let i = currentDay + 1; i < 7; i++) {}
    const howManyDaysNext = Math.abs(today.day() - nextDay);
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
