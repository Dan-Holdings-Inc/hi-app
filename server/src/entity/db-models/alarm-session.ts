import { Schema, model } from "mongoose";
import { AlarmSession } from "../entities/alarm-session";
const alarmSessionSchema = new Schema<AlarmSession>({
  _id: { type: String, required: true },
  userId: { type: String, required: true, index: true },
  round: { type: Number, required: true },
  startDate: { type: Date, required: true },
});
export const AlarmSessionModel = model<AlarmSession>(
  "AlarmSession",
  alarmSessionSchema
);
