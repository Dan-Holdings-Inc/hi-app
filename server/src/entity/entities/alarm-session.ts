import { ApiProperty } from "@nestjs/swagger";

export class AlarmSession {
  constructor(init: Partial<AlarmSession>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  userId: string;
  @ApiProperty()
  round: number;
  @ApiProperty()
  startDate: Date;
}
