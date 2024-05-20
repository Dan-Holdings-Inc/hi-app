import { ApiProperty } from "@nestjs/swagger";

export class PenaltyHistory {
  constructor(init: Partial<PenaltyHistory>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  userId: string;
  @ApiProperty()
  date: Date;
}
