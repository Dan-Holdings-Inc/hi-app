import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { AuthModule } from "./auth/auth.module";
import { InfrastructureModule } from "./infrastructure/infrastructure.module";
import { DbService } from "./infrastructure/db/db.service";

@Module({
  imports: [AuthModule, InfrastructureModule],
  controllers: [AppController],
  providers: [AppService, DbService],
})
export class AppModule {}
