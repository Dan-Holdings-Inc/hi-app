import { ApiProperty } from "@nestjs/swagger";

export class HiHistory {
  constructor(init: Partial<HiHistory>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  senderUserId: string;
  @ApiProperty()
  receiverUserId: string;
  @ApiProperty()
  date: Date;
}
