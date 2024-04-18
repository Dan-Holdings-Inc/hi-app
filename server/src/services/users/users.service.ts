import { Injectable } from "@nestjs/common";
import { randomUUID } from "crypto";
import {
  User,
  UserRegistration,
  UserWithRelationship,
} from "src/entity/entities/user";
import { UserAlreadyExistError } from "src/errors";
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
   * @param ur
   * @returns
   */
  async register(ur: UserRegistration) {
    const existingUser = await this.dbService.users
      .findOne({ id: ur.id })
      .lean()
      .exec();
    if (existingUser) {
      throw new UserAlreadyExistError();
    }
    const user: User = {
      id: ur.id,
      email: ur.email,
      userName: ur.userName,
      name: ur.name,
    };
    await this.dbService.users.create(user);
    const userWithRelationship: UserWithRelationship = {
      ...user,
      followers: [],
      followings: [],
    };
    return userWithRelationship;
  }

  async getUsers() {
    return await this.dbService.users.find().lean().exec();
  }

  async getUser(idOrEmail: string) {
    let query: Partial<{ id: string; email: string }> = {};
    if (this.emailReg.test(idOrEmail)) {
      query.email = idOrEmail;
    } else {
      query.id = idOrEmail;
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
    await this.dbService.users.updateOne({ id: user.id }, user);
    return user;
  }

  async delete(user: User) {
    await this.dbService.users.deleteOne({ id: user.id });
    await this.dbService.relationships.deleteMany({
      $or: [
        {
          userId: user.id,
        },
        {
          followsId: user.id,
        },
      ],
    });
  }

  /**
   * UserオブジェクトからUserWithRelationを作る
   * @param user
   */
  private async buildUserWithRelationship(arg: User) {
    const user = arg;
    const followingIds = (
      await this.dbService.relationships.find({ userId: user.id }).lean().exec()
    ).map((r) => r.followsId);
    const followerIds = (
      await this.dbService.relationships
        .find({ followsId: user.id })
        .lean()
        .exec()
    ).map((r) => r.userId);

    const realtedUsers = await this.dbService.users.find({
      id: {
        $in: followingIds.concat(followerIds),
      },
    });
    const userMap = new Map<string, User>();
    for (const u of realtedUsers) {
      userMap.set(u.id, u);
    }

    const followingUsers = followingIds.map((id) => userMap.get(id)!);
    const followerUsers = followerIds.map((id) => userMap.get(id)!);

    const userWithRelationship: UserWithRelationship = {
      ...user,
      followings: followingUsers,
      followers: followerUsers,
    };
    return userWithRelationship;
  }
}
