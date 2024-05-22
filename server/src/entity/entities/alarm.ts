import { ApiProperty } from "@nestjs/swagger";

export class Alarm {
  constructor(init: Partial<Alarm>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  _id: string;
  @ApiProperty()
  userId: string;
  @ApiProperty()
  getUpAt: string;
  @ApiProperty()
  daysToAlarm: boolean[];
}

export class AlarmDto implements Omit<Alarm, "_id"> {
  constructor(init: Partial<AlarmDto>) {
    Object.assign(this, init);
  }
  @ApiProperty()
  userId: string;
  @ApiProperty()
  getUpAt: string;
  @ApiProperty()
  daysToAlarm: boolean[];
}
