import { NestFactory } from "@nestjs/core";
import { DocumentBuilder, SwaggerModule } from "@nestjs/swagger";
import { AppModule } from "src/app.module";
import { safeDump } from "js-yaml";
import { join } from "path";
import { writeFileSync } from "fs";

const exportOpenapiDocument = async () => {
  const app = await NestFactory.create(AppModule);
  const documentConfig = new DocumentBuilder()
    .setTitle("Hi Document")
    .setDescription("The Hi API description")
    .setVersion("1.0")
    .build();

  const document = SwaggerModule.createDocument(app, documentConfig);
  const yamlDocument = safeDump(document, {
    skipInvalid: true,
    noRefs: true,
  });
  const path = join(__dirname, "../../openapi/openapi.yaml");
  writeFileSync(path, yamlDocument, "utf8");
};

exportOpenapiDocument().catch((e) => {
  console.error(e);
});
