import { Schema, model } from "mongoose";
import { User } from "../entities/user";
const userSchema = new Schema<User>({
  _id: { type: String, required: true, index: true },
  email: { type: String, required: true, index: true },
  userName: { type: String },
  name: { type: String },
});
export const UserModel = model<User>("User", userSchema);
