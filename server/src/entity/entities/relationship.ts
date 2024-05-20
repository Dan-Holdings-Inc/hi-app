import { ApiProperty } from "@nestjs/swagger";
export class Relationship {
  constructor(init: Partial<Relationship>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  userId: string;
  @ApiProperty()
  followsId: string;
}

export class RelationshipDto {
  constructor(init: Partial<RelationshipDto>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  followsId: string;
}
