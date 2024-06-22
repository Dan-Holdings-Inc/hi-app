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
import { ApiResponse, ApiTags } from "@nestjs/swagger";
import { Alarm, AlarmDto } from "../../entity/entities/alarm";
import { PenaltyHistory } from "../../entity/entities/penalty-history";
import {
  Relationship,
  RelationshipDto,
} from "../../entity/entities/relationship";
import {
  User,
  UserRegistrationDto,
  UserWithRelatedData,
} from "../../entity/entities/user";
import { UserNotFoundError } from "../../errors";
import { AlarmService } from "../../services/alarm/alarm.service";
import { UsersService } from "../../services/users/users.service";

// @UseGuards(AuthGuard("jwt"))
@Controller("users")
@ApiTags("users")
export class UsersController {
  constructor(
    private usersService: UsersService,
    private alarmService: AlarmService
  ) {}

  @Get("greeting")
  async greet(): Promise<string> {
    return "hello!";
  }

  @Get(":idOrEmail")
  @ApiResponse({
    status: 200,
    type: UserWithRelatedData,
  })
  @ApiResponse({
    status: 404,
    description: "user not registered yet.",
  })
  async getUser(@Param("idOrEmail") id: string): Promise<User> {
    const user = await this.usersService.getUser(id);
    if (user) return user;
    throw new NotFoundException("user not registered yet.");
  }

  @Get(":id/penalties")
  @ApiResponse({
    status: 200,
    type: [PenaltyHistory],
  })
  async getPenalties(@Param("id") userId: string): Promise<PenaltyHistory[]> {
    return await this.usersService.getPenalties(userId);
  }

  /**
   * ユーザー初回登録
   * @param req
   * @returns
   */
  @Post()
  @ApiResponse({
    status: 201,
    type: User,
  })
  async register(@Request() req): Promise<User> {
    const registration: UserRegistrationDto = req.body;
    return await this.usersService.register(registration);
  }

  @Post(":id/followings")
  @ApiResponse({
    status: 201,
    type: [UserWithRelatedData],
  })
  @ApiResponse({
    status: 400,
  })
  async follow(
    @Param("id") userId: string,
    @Body() body
  ): Promise<UserWithRelatedData[]> {
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
  @ApiResponse({
    status: 200,
    type: [UserWithRelatedData],
  })
  @ApiResponse({
    status: 400,
  })
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
  @ApiResponse({
    status: 200,
    type: User,
  })
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
  @ApiResponse({
    status: 200,
    type: Alarm,
  })
  async updateAlarm(@Param("id") userId: string, @Body() alarm: AlarmDto) {
    if (userId !== alarm.userId) {
      throw new BadRequestException(
        ":id and Alarm.userId should be same value."
      );
    }
    return await this.usersService.updateAlarm(alarm);
  }

  @Delete(":id")
  @ApiResponse({
    status: 200,
  })
  async delete(@Param("id") userId) {
    await this.usersService.delete(userId);
  }
}
