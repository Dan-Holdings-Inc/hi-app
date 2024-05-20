import { ApiProperty } from "@nestjs/swagger";

export class User {
  constructor(init: Partial<User>) {
    Object.assign(this, init);
  }
  /**
   * システム上の識別子
   */
  @ApiProperty()
  _id: string;
  /**
   * メールアドレス
   */
  @ApiProperty()
  email: string;
  /**
   * ユーザー固有の名前
   */
  @ApiProperty()
  userName: string;
  /**
   * 表示名
   */
  @ApiProperty()
  name: string;
}

export class UserWithRelatedData extends User {
  constructor(init: Partial<UserWithRelatedData>) {
    super(init);
    Object.assign(this, init);
  }
  followings: User[];
  followers: User[];
  getUpAt: string;
  daysToAlarm: boolean[];
}

export class UserRegistrationDto extends User {
  constructor(init: Partial<UserRegistrationDto>) {
    super(init);
    Object.assign(this, init);
  }
  getUpAt: string;
  daysToAlarm: boolean[];
  deviceToken: string;
}
