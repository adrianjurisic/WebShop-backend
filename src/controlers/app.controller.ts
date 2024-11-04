import { Controller, Get } from '@nestjs/common';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from 'src/services/administrator/administrator.service';



@Controller()
export class AppController {
  constructor(
    private administratorService: AdministratorService
  ){}

  @Get()
  getHello(): string {
    return 'Hello World!';
  }

}
