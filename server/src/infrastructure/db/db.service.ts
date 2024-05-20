import { Injectable } from "@nestjs/common";
import * as mongoose from "mongoose";
import { AlarmModel } from "../../entity/db-models/alarm";
import { AlarmSessionModel } from "../../entity/db-models/alarm-session";
import { DeviceTokenModel } from "../../entity/db-models/device-token";
import { HiHistoryModel } from "../../entity/db-models/hi-history";
import { PenaltyHistoryModel } from "../../entity/db-models/penalty-history";
import { RelationshipModel } from "../../entity/db-models/relationship";
import { UserModel } from "../../entity/db-models/user";
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
