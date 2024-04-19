export interface Relationship {
  id: string;
  userId: string;
  followsId: string;
}

export interface RelationshipDto {
  followsId: string;
}
