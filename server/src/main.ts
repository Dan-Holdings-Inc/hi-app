import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { RemovePropertyInterceptor } from "./interceptors/remove-property/remove-property.interceptor";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: "*",
    allowedHeaders:
      "Origin, X-Requested-With, Content-Type, Accept, Authorization",
  });
  app.useGlobalInterceptors(new RemovePropertyInterceptor());
  await app.listen(3000);
}
bootstrap();
