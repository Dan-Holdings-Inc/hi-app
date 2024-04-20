import { Schema, model } from "mongoose";
import { Alarm } from "../entities/alarm";
const alarmSchema = new Schema<Alarm>({
  _id: { type: String, required: true },
  userId: { type: String },
});
export const AlarmModel = model<Alarm>("Alarm", alarmSchema);
