import { Injectable } from "@nestjs/common";
import * as mongoose from "mongoose";
import { AlarmModel } from "src/entity/db-models/alarm";
import { DeviceTokenModel } from "src/entity/db-models/device-token";
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

  get deviceTokens() {
    return DeviceTokenModel;
  }

  private async connect() {
    try {
      await mongoose.connect("mongodb://127.0.0.1:27017/hi");
    } catch (error) {
      console.error(error);
    }
  }
}
