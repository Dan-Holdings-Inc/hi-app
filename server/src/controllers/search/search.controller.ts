import { Controller, Get, Param } from "@nestjs/common";
import { UsersService } from "src/services/users/users.service";
// @UseGuards(AuthGuard("jwt"))
@Controller("search")
export class SearchController {
  constructor(private usersService: UsersService) {}

  @Get("users/:identifier")
  async searchUsers(@Param("identifier") identifier: string) {
    return await this.usersService.search(identifier);
  }
}
