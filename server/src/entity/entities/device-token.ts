import { ApiProperty } from "@nestjs/swagger";

export class DeviceToken {
  constructor(init: Partial<DeviceToken>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  userId: string;
  @ApiProperty()
  token: string;
}
