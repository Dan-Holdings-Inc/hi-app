import { Schema, model } from "mongoose";
import { Alarm } from "../entities/alarm";
const alarmSchema = new Schema<Alarm>({
  _id: { type: String, required: true },
  userId: { type: String, required: true, index: true },
  getUpAt: { type: String, required: true },
  daysToAlarm: [{ type: Boolean, required: true }],
});
export const AlarmModel = model<Alarm>("Alarm", alarmSchema);
