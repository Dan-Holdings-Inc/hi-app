import { Injectable } from "@nestjs/common";
import * as mongoose from "mongoose";
import { AlarmModel } from "src/entity/db-models/alarm";
import { AlarmSessionModel } from "src/entity/db-models/alarm-session";
import { DeviceTokenModel } from "src/entity/db-models/device-token";
import { HiHistoryModel } from "src/entity/db-models/hi-history";
import { PenaltyHistoryModel } from "src/entity/db-models/penalty-history";
import { RelationshipModel } from "src/entity/db-models/relationship";
import { UserModel } from "src/entity/db-models/user";
@Injectable()
export class DbService {
  constructor() {
    this.connect();
  }

  get users() {
    return UserModel;
  }

  get relationships() {
    return RelationshipModel;
  }

  get alarms() {
    return AlarmModel;
  }

  get alarmSessions() {
    return AlarmSessionModel;
  }

  get deviceTokens() {
    return DeviceTokenModel;
  }

  get hiHistories() {
    return HiHistoryModel;
  }

  get penaltyHistories() {
    return PenaltyHistoryModel;
  }

  private async connect() {
    try {
      await mongoose.connect("mongodb://127.0.0.1:27017/hi");
    } catch (error) {
      console.error(error);
    }
  }
}
