import {
  BadRequestException,
  Controller,
  Param,
  Post,
  Req,
  UseGuards,
} from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { ApiResponse, ApiTags } from "@nestjs/swagger";
import { DbService } from "../../infrastructure/db/db.service";
import { HiService } from "../../services/hi/hi.service";

@UseGuards(AuthGuard("jwt"))
@Controller("hi")
@ApiTags("hi")
export class HiController {
  constructor(
    private dbService: DbService,
    private hiService: HiService
  ) {}

  @Post(":receiverUserId")
  @ApiResponse({
    status: 204,
    description: "Hi sent.",
  })
  @ApiResponse({
    status: 400,
  })
  async sendHi(
    @Param("receiverUserId") receiverUserId: string,
    @Req() request
  ) {
    const email = request.user.name as string;
    const sender = await this.dbService.users
      .findOne({
        email,
      })
      .lean()
      .exec();
    if (!sender) {
      //たぶんありえないが一応。
      throw new BadRequestException("sender not found");
    }
    const receiver = await this.dbService.users.findOne({
      _id: receiverUserId,
    });
    if (!receiver) {
      throw new BadRequestException("receiver not found.");
    }
    await this.hiService.sendHi(sender, receiver);
  }
}
