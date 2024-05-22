import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { RemovePropertyInterceptor } from "./interceptors/remove-property/remove-property.interceptor";
import { Credentials, config } from "aws-sdk";
import * as dotenv from "dotenv";
import * as dayjs from "dayjs";
import * as timezone from "dayjs/plugin/timezone";
import * as utc from "dayjs/plugin/utc";
import { DocumentBuilder, SwaggerModule } from "@nestjs/swagger";
dayjs.extend(utc);
dayjs.extend(timezone);
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  dotenv.config();
  app.enableCors({
    origin: "*",
    allowedHeaders:
      "Origin, X-Requested-With, Content-Type, Accept, Authorization",
  });
  app.useGlobalInterceptors(new RemovePropertyInterceptor());
  config.update({
    region: "ap-northeast-1",
    credentials: new Credentials({
      accessKeyId: process.env.aws_access_key_id,
      secretAccessKey: process.env.aws_secret_access_key,
    }),
  });
  const documentConfig = new DocumentBuilder()
    .setTitle("Hi Document")
    .setDescription("The Hi API description")
    .setVersion("1.0")
    .build();
  const document = SwaggerModule.createDocument(app, documentConfig);
  SwaggerModule.setup("api", app, document);
  await app.listen(3000);
}
bootstrap();
