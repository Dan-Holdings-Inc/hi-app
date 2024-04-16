export interface User {
  /**
   * システム上の識別子
   */
  id: string;
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
  /**
   * HH:mm
   */
  getUpAt: string;
}

export interface UserWithRelationship extends User {
  followings: User[];
  followers: User[];
}
