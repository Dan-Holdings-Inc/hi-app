import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  InternalServerErrorException,
  NotFoundException,
  Param,
  Post,
  Put,
  Req,
  Request,
  UseGuards,
} from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { Alarm, AlarmDto } from "src/entity/entities/alarm";
import {
  Relationship,
  RelationshipDto,
} from "src/entity/entities/relationship";
import { User, UserRegistrationDto } from "src/entity/entities/user";
import { UserNotFoundError } from "src/errors";
import { DbService } from "src/infrastructure/db/db.service";
import { UsersService } from "src/services/users/users.service";

// @UseGuards(AuthGuard("jwt"))
@Controller("users")
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Get(":idOrEmail")
  async getUser(@Param("idOrEmail") id: string) {
    const user = await this.usersService.getUser(id);
    if (user) return user;
    throw new NotFoundException();
  }

  /**
   * ユーザー初回登録
   * @param req
   * @returns
   */
  @Post()
  async register(@Request() req) {
    const registration: UserRegistrationDto = req.body;
    return await this.usersService.register(registration);
  }

  @Post(":id/followings")
  async follow(@Param("id") userId: string, @Body() body) {
    //TODO: tokenを元に（nameとかから）アクセス元ユーザーがuserIdのユーザーなのか検証
    const { followsId } = body as RelationshipDto;
    if (userId === followsId) {
      throw new BadRequestException("you can't follow yourself.");
    }
    try {
      return await this.usersService.follow(userId, followsId);
    } catch (error) {
      if (error instanceof UserNotFoundError) {
        throw new BadRequestException(error.message);
      } else {
        throw new BadRequestException(error.message);
      }
    }
  }

  @Delete(":id/followings")
  async unfollow(@Param("id") userId: string, @Body() body) {
    const { followsId } = body as RelationshipDto;
    if (userId === followsId) {
      throw new BadRequestException("you can't unfollow yourself.");
    }
    try {
      return await this.usersService.unfollow(userId, followsId);
    } catch (error) {
      if (error instanceof UserNotFoundError) {
        throw new BadRequestException(error.message);
      } else {
        throw new InternalServerErrorException(error);
      }
    }
  }

  @Put(":id")
  async update(@Request() req) {
    const body = req.body;
    //UserWithRelationshipが渡されることを考慮
    const user: User = {
      _id: body._id,
      email: body.email,
      userName: body.userName,
      name: body.name,
    };
    return await this.usersService.update(user);
  }

  @Put(":id/alarm")
  async updateAlarm(@Param("id") userId: string, @Body() alarm: AlarmDto) {
    if (userId !== alarm.userId) {
      throw new BadRequestException(
        ":id and Alarm.userId should be same value."
      );
    }
    return await this.usersService.updateAlarm(alarm);
  }

  @Delete(":id")
  async delete(@Param() params) {
    const id = params.id;
    await this.usersService.delete(params);
  }
}
