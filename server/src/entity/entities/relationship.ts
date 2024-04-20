export interface Relationship {
  _id: string;
  userId: string;
  followsId: string;
}

export interface RelationshipDto {
  followsId: string;
}
