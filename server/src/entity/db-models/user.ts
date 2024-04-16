import { Schema, model } from "mongoose";
import { User } from "../entities/user";
const userSchema = new Schema<User>({
  id: { type: String, required: true },
  name: { type: String, required: true },
  getUpAt: { type: String, required: false },
});
export const UserModel = model<User>("User", userSchema);
