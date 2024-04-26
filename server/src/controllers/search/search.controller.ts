import {
  BadRequestException,
  Controller,
  Get,
  Param,
  Query,
} from "@nestjs/common";
import { UsersService } from "src/services/users/users.service";
// @UseGuards(AuthGuard("jwt"))
@Controller("search")
export class SearchController {
  constructor(private usersService: UsersService) {}

  @Get("users")
  async searchUsers(@Query() query) {
    const text = query.text;
    if (!text) {
      throw new BadRequestException("query parameter 'text' is required.");
    }
    return await this.usersService.search(text);
  }
}
