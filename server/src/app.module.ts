import { Module } from "@nestjs/common";
import { AuthModule } from "./auth/auth.module";
import { InfrastructureModule } from "./infrastructure/infrastructure.module";
import { DbService } from "./infrastructure/db/db.service";
import { UsersController } from "./controllers/user/user.controller";
import { UsersService } from "./services/users/users.service";
import { HiController } from './controllers/hi/hi.controller';
import { HiService } from './services/hi/hi.service';

@Module({
  imports: [AuthModule, InfrastructureModule],
  controllers: [UsersController, HiController],
  providers: [DbService, UsersService, HiService],
})
export class AppModule {}
