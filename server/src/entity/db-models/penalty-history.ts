import { Schema, model } from "mongoose";
import { PenaltyHistory } from "../entities/penalty-history";
const penaltyHistorySchema = new Schema<PenaltyHistory>({
  _id: { type: String, required: true },
  userId: { type: String, required: true },
  date: { type: Date, required: true },
});
export const PenaltyHistoryModel = model<PenaltyHistory>(
  "PenaltyHistory",
  penaltyHistorySchema
);
