import { Controller, Get, UseGuards, Request } from "@nestjs/common";
import { AppService } from "./app.service";
import { AuthGuard } from "@nestjs/passport";
import { DbService } from "./infrastructure/db/db.service";

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly dbService: DbService
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
  @UseGuards(AuthGuard("jwt"))
  @Get("/private")
  getHelloPrivate(@Request() req) {
    return { message: "private api", sub: req.user.sub };
  }
}
