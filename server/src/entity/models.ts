export interface User {
  /**
   * システム上の識別子
   */
  id: string;
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
