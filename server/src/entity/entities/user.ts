export interface User {
  /**
   * システム上の識別子
   */
  _id: string;
  /**
   * メールアドレス
   */
  email: string;
  /**
   * ユーザー固有の名前
   */
  userName: string;
  /**
   * 表示名
   */
  name: string;
}

export interface UserWithRelationship extends User {
  followings: User[];
  followers: User[];
}

export interface UserRegistrationDto extends User {
  getUpAt: string;
  daysToAlarm: boolean[];
  deviceToken: string;
}
