import { Controller, Post } from "@nestjs/common";
import { SNS } from "aws-sdk";

// @UseGuards(AuthGuard("jwt"))
@Controller("hi")
export class HiController {
  @Post()
  async sendHi() {
    // SNS()
  }
}
