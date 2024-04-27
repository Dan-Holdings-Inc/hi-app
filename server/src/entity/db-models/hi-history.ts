import { Schema, model } from "mongoose";
import { HiHistory } from "../entities/hi-history";
const hiHistorySchema = new Schema<HiHistory>({
  _id: { type: String, required: true },
  senderUserId: { type: String, required: true, index: true },
  receiverUserId: { type: String, required: true, index: true },
  date: { type: Date, required: true },
});
export const HiHistoryModel = model<HiHistory>("HiHistory", hiHistorySchema);
