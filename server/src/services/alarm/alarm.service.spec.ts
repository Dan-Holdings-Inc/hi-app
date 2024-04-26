import { Test, TestingModule } from "@nestjs/testing";
import { AlarmService } from "./alarm.service";
import { DbService } from "src/infrastructure/db/db.service";
import { HiService } from "../hi/hi.service";
import { Alarm } from "src/entity/entities/alarm";
import { User } from "src/entity/entities/user";

describe("AlarmService", () => {
  let service: AlarmService;
  const alarm: Alarm = {
    _id: "euiahfoweh9120e93",
    userId: "ioqweuwoeur9",
    getUpAt: "10:00",
    daysToAlarm: [true, false, false, true, true, false, true],
  };

  const user: User = {
    _id: "ioqweuwoeur9",
    email: "fujidan8464@gmail.com",
    userName: "fujidan8464",
    name: "Dan",
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AlarmService, DbService, HiService],
    }).compile();

    service = module.get<AlarmService>(AlarmService);
  });

  it("should be defined", () => {
    expect(service).toBeDefined();
  });

  describe("calculateAlarmDate", () => {
    it("calculate ", () => {
      expect(AlarmService.calculateAlarmDate(alarm).toISOString()).toBe("");
    });
  });
});
