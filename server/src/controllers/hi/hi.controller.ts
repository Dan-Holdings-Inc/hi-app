import { Controller, Post } from "@nestjs/common";

// @UseGuards(AuthGuard("jwt"))
@Controller("hi")
export class HiController {
  @Post()
  async sendHi() {}
}
