export interface Alarm {
  _id: string;
  userId: string;
  getUpAt: string;
  daysToAlarm: boolean[];
}

export type AlarmDto = Omit<Alarm, "_id">;
