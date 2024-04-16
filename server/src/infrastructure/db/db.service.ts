import { Injectable } from "@nestjs/common";
import * as mongoose from "mongoose";
import { UserModel } from "src/entity/db-models/user";
@Injectable()
export class DbService {
  constructor() {
    this.connect();
  }

  get users() {
    return UserModel;
  }

  private async connect() {
    try {
      await mongoose.connect("mongodb://127.0.0.1:27017/hi");
    } catch (error) {
      console.error(error);
    }
  }
}
