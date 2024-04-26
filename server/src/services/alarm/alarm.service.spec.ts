import { Test, TestingModule } from "@nestjs/testing";
import { AlarmService } from "./alarm.service";

import { Alarm } from "src/entity/entities/alarm";
import { User } from "src/entity/entities/user";
import * as dayjs from "dayjs";
const TIMEZONE = "Asia/Tokyo";
import * as timezone from "dayjs/plugin/timezone";
import * as utc from "dayjs/plugin/utc";
dayjs.extend(utc);
dayjs.extend(timezone);

describe("AlarmService", () => {
  let service: AlarmService;
  const alarm: Alarm = {
    _id: "euiahfoweh9120e93",
    userId: "ioqweuwoeur9",
    getUpAt: "10:00",
    daysToAlarm: [false, true, false, true, true, false, false],
  };

  const user: User = {
    _id: "ioqweuwoeur9",
    email: "fujidan8464@gmail.com",
    userName: "fujidan8464",
    name: "Dan",
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AlarmService],
    }).compile();

    service = module.get<AlarmService>(AlarmService);
  });

  it("should be defined", () => {
    expect(service).toBeDefined();
  });

  describe("calculateAlarmDate", () => {
    it("should be on 2024-04-01T01:00:00.000Z", () => {
      const now = dayjs.tz("2024-04-01T09:00:00", TIMEZONE);
      expect(AlarmService.calculateAlarmDate(now, alarm).toISOString()).toBe(
        buildIsoStringWithTimezone("2024-04-01T10:00:00")
      );
    });

    it("should be at 2024-04-03T01:00:00.000Z", () => {
      const now = dayjs.tz("2024-04-01T10:00:01", TIMEZONE);
      expect(AlarmService.calculateAlarmDate(now, alarm).toISOString()).toBe(
        buildIsoStringWithTimezone("2024-04-03T10:00:00")
      );
    });

    it("should be at 2024-04-03T01:00:00.000Z", () => {
      const now = dayjs.tz("2024-04-02T10:00:00", TIMEZONE);
      expect(AlarmService.calculateAlarmDate(now, alarm).toISOString()).toBe(
        buildIsoStringWithTimezone("2024-04-03T10:00:00")
      );
    });

    it("should be at next monday", () => {
      const now = dayjs.tz("2024-04-05T08:00:00", TIMEZONE);
      expect(AlarmService.calculateAlarmDate(now, alarm).toISOString()).toBe(
        buildIsoStringWithTimezone("2024-04-08T10:00:00")
      );
    });
  });
});

const buildIsoStringWithTimezone = (iso: string) => {
  return dayjs.tz(iso, TIMEZONE).toISOString();
};
