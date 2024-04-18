import {
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Req,
  Request,
  UseGuards,
} from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { Relationship } from "src/entity/entities/relationship";
import { User, UserRegistration } from "src/entity/entities/user";
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
    const registration: UserRegistration = req.body;
    return await this.usersService.register(registration);
  }

  @Post(":id/followings")
  async follow(@Param(":id") id: string, @Request() req) {
    //TODO: tokenを元に（nameとかから）アクセス元ユーザーがuserIdのユーザーなのか検証
    const userId = id;
    const relationship = req.body as Relationship;
  }

  @Put(":id")
  async update(@Request() req) {
    const body = req.body;
    //UserWithRelationshipが渡されることを考慮
    const user: User = {
      id: body.id,
      email: body.email,
      userName: body.userName,
      name: body.name,
    };
    return await this.usersService.update(user);
  }

  @Delete(":id")
  async delete(@Param() params) {
    const id = params.id;
    await this.usersService.delete(params);
  }
}
