import { Body, Controller, Get, Param, Post, Put, SetMetadata, UseGuards } from "@nestjs/common";
import { Administrator } from "src/entities/administrator.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";

@Controller('api/administrator')
export class AdministratorController {
    constructor(
        private administratorService: AdministratorService
    ) {}

    // GET http://localhost.3000/api/administrator/
    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getAll(): Promise<Administrator[]>{
      return this.administratorService.getAll();
    }
    
    // GET http://localhost.3000/api/administrator/4/
    @Get(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getById(@Param('id') administratorId: number): Promise<Administrator | ApiResponse>{
      return this.administratorService.getById(administratorId);
    }

    // PUT http://localhost.3000/api/administrator/
    @Put()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    add(@Body() data: AddAdministratorDto): Promise<Administrator | ApiResponse>{
        return this.administratorService.add(data);
    }

    // POST http://localhost.3000/api/administrator/4/
    @Post(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') administratorId: number, @Body() data: EditAdministratorDto): Promise<Administrator | ApiResponse>{
        return this.administratorService.editById(administratorId, data);
    }
}