import { Schema, model } from "mongoose";
import { Relationship } from "../entities/relationship";
const relationshipSchema = new Schema<Relationship>({
  id: { type: String, required: true },
  userId: { type: String, required: true },
  followsId: { type: String, required: true },
});
export const RelationshipModel = model<Relationship>(
  "Relationship",
  relationshipSchema
);
