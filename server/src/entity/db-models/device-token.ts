import { Schema, model } from "mongoose";
import { DeviceToken } from "../entities/device-token";
const deviceTokenSchema = new Schema<DeviceToken>({
  _id: { type: String, required: true },
  userId: { type: String, required: true },
  token: { type: String, required: true },
});
export const DeviceTokenModel = model<DeviceToken>(
  "DeviceToken",
  deviceTokenSchema
);
