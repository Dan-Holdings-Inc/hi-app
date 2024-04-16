import { Module } from "@nestjs/common";
import { AuthModule } from "./auth/auth.module";
import { InfrastructureModule } from "./infrastructure/infrastructure.module";
import { DbService } from "./infrastructure/db/db.service";

@Module({
  imports: [AuthModule, InfrastructureModule],
  controllers: [],
  providers: [DbService],
})
export class AppModule {}
