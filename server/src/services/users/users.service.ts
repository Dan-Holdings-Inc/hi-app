import { Injectable } from "@nestjs/common";
import { randomUUID } from "crypto";
import { Alarm, AlarmDto } from "src/entity/entities/alarm";
import { DeviceToken } from "src/entity/entities/device-token";
import { Relationship } from "src/entity/entities/relationship";
import {
  User,
  UserRegistrationDto,
  UserWithRelatedData,
} from "src/entity/entities/user";
import {
  AlreadyFollowingError,
  UserAlreadyExistError,
  UserNotFoundError,
} from "src/errors";
import { DbService } from "src/infrastructure/db/db.service";

@Injectable()
export class UsersService {
  private emailReg =
    /^[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/;
  constructor(private dbService: DbService) {}

  async isExist(email: string) {
    return await this.dbService.users.exists({
      email,
    });
  }

  /**
   * 初回登録処理
   * @param dto
   * @returns
   */
  async register(dto: UserRegistrationDto) {
    const existingUser = await this.dbService.users
      .findOne({ _id: dto._id })
      .lean()
      .exec();
    if (existingUser) {
      throw new UserAlreadyExistError();
    }
    const user: User = {
      _id: dto._id,
      email: dto.email,
      userName: dto.userName,
      name: dto.name,
    };
    await this.dbService.users.create(user);

    const alarm: Alarm = {
      _id: randomUUID(),
      userId: dto._id,
      getUpAt: dto.getUpAt,
      daysToAlarm: dto.daysToAlarm,
    };
    await this.dbService.alarms.create(alarm);
    const userWithRelationship: UserWithRelatedData = {
      ...user,
      followers: [],
      followings: [],
      getUpAt: dto.getUpAt,
      daysToAlarm: dto.daysToAlarm,
    };
    const deviceToken: DeviceToken = {
      _id: randomUUID(),
      userId: dto._id,
      token: dto.deviceToken,
    };
    await this.dbService.deviceTokens.create(deviceToken);
    return userWithRelationship;
  }

  async getUsers() {
    return await this.dbService.users.find().lean().exec();
  }

  async getUser(idOrEmail: string) {
    let query: Partial<{ _id: string; email: string }> = {};
    if (this.emailReg.test(idOrEmail)) {
      query.email = idOrEmail;
    } else {
      query._id = idOrEmail;
    }
    const user = await this.dbService.users.findOne(query).lean().exec();
    return user && this.buildUserWithRelationship(user);
  }

  /**
   * ユーザー情報更新。
   * follow/unfollowの場合は
   * @param user
   * @returns
   */
  async update(user: User) {
    await this.dbService.users.updateOne({ _id: user._id }, user);
    return user;
  }

  async delete(userId: string) {
    await this.dbService.users.deleteOne({ _id: userId });
    await this.dbService.relationships.deleteMany({
      $or: [
        {
          userId: userId,
        },
        {
          followsId: userId,
        },
      ],
    });
    await this.dbService.alarms.deleteMany({
      userId,
    });
    await this.dbService.deviceTokens.deleteMany({
      userId,
    });
  }

  async follow(userId: string, followsId: string) {
    const users = await this.dbService.users
      .find({ _id: { $in: [userId, followsId] } })
      .lean()
      .exec();
    if (users.length < 2) {
      throw new UserNotFoundError(
        "Faild to follow user. Either of userId or followsId is invalid"
      );
    }
    //ハッカソンのための実装の簡略化のため、フォローしようとしたら強制的に相互フォロー状態
    const existingRelationship = await this.dbService.relationships
      .findOne({
        userId,
        followsId,
      })
      .lean()
      .exec();
    if (existingRelationship) {
      throw new AlreadyFollowingError(
        `user(${userId}) has followed (${followsId}) already `
      );
    }

    const relationship1: Relationship = {
      _id: randomUUID(),
      userId,
      followsId,
    };
    const relationship2: Relationship = {
      _id: randomUUID(),
      userId: followsId,
      followsId: userId,
    };
    await this.dbService.relationships.insertMany([
      relationship1,
      relationship2,
    ]);
    return await Promise.all(
      users.map((u) => this.buildUserWithRelationship(u))
    );
  }

  async unfollow(userId: string, unfollowsId: string) {
    const users = await this.dbService.users
      .find({ _id: { $in: [userId, unfollowsId] } })
      .lean()
      .exec();
    if (users.length < 2) {
      throw new UserNotFoundError(
        "Faild to follow user. Either of userId or unfollowsId is invalid"
      );
    }
    //ハッカソンのための実装の簡略化のため、フォロー外そうとしたらお互いにフォロー解除状態
    await this.dbService.relationships
      .deleteMany({
        $or: [
          {
            userId: userId,
            followsId: unfollowsId,
          },
          {
            userId: unfollowsId,
            followsId: userId,
          },
        ],
      })
      .exec();
    return await Promise.all(
      users.map((u) => this.buildUserWithRelationship(u))
    );
  }

  async updateAlarm(alarm: AlarmDto) {
    await this.dbService.alarms
      .updateOne(
        {
          userId: alarm.userId,
        },
        alarm
      )
      .lean()
      .exec();
    return this.dbService.alarms.findOne({ userId: alarm.userId });
  }

  /**
   * UserオブジェクトからUserWithRelationを作る
   * @param user
   */
  private async buildUserWithRelationship(arg: User) {
    //TODO: 複数のユーザーのUserWithRelationshipの実装に対応する。今のままだとパフォーマンスが悪い。
    //できるだけ少ない問い合わせで必要なものを取得したい。(followやunfollowでの実装)
    const user = arg;
    const followingIds = (
      await this.dbService.relationships
        .find({ userId: user._id })
        .lean()
        .exec()
    ).map((r) => r.followsId);
    const followerIds = (
      await this.dbService.relationships
        .find({ followsId: user._id })
        .lean()
        .exec()
    ).map((r) => r.userId);
    const alarm = await this.dbService.alarms
      .findOne({
        userId: user._id,
      })
      .lean()
      .exec();

    const realtedUsers = await this.dbService.users.find({
      _id: {
        $in: followingIds.concat(followerIds),
      },
    });
    const userMap = new Map<string, User>();
    for (const u of realtedUsers) {
      userMap.set(u._id, u);
    }

    const followingUsers = followingIds.map((id) => userMap.get(id)!);
    const followerUsers = followerIds.map((id) => userMap.get(id)!);

    const userWithRelationship: UserWithRelatedData = {
      ...user,
      followings: followingUsers,
      followers: followerUsers,
      getUpAt: alarm.getUpAt,
      daysToAlarm: alarm.daysToAlarm,
    };
    return userWithRelationship;
  }
}
