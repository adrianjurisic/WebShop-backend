import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AdministratorService } from './services/administrator/administrator.service';


@Module({
  imports: [],
  controllers: [AppController],
  providers: [AdministratorService],
})
export class AppModule {}
