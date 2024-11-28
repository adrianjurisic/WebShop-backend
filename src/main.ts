import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfig } from 'config/storage.config';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.useStaticAssets(StorageConfig.photo.destination, {
    prefix: StorageConfig.photo.urlPrefix,
    maxAge: 1000 * 60 * 60 * 24 * 7, // 7 days
    index: false,
  });

  app.useGlobalPipes(new ValidationPipe());

  app.enableCors();

  await app.listen(3000);
}
bootstrap();
