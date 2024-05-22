import {
  BadRequestException,
  Controller,
  Get,
  Param,
  Query,
} from "@nestjs/common";
import { ApiResponse, ApiTags } from "@nestjs/swagger";
import { User } from "../../entity/entities/user";
import { UsersService } from "../../services/users/users.service";
// @UseGuards(AuthGuard("jwt"))
@Controller("search")
@ApiTags("search")
export class SearchController {
  constructor(private usersService: UsersService) {}

  @Get("users")
  @ApiResponse({
    status: 200,
    type: [User],
  })
  @ApiResponse({
    status: 400,
  })
  async searchUsers(@Query() query) {
    const text = query.text;
    if (!text) {
      throw new BadRequestException("query parameter 'text' is required.");
    }
    return await this.usersService.search(text);
  }
}
