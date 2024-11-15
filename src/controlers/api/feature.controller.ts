import { Body, Controller, Get, Param, Patch, Post, Put, UseGuards } from "@nestjs/common";
import { AddFeatureDto } from "src/dtos/feature/add.feature.dto";
import { EditFeatureDto } from "src/dtos/feature/edit.feature.dto";
import { Feature } from "src/entities/feature.entity";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { FeatureService } from "src/services/feature/feature.service";



@Controller('api/feature')
export class FeatureController{
    constructor(
        private featureService: FeatureService
    ) {}

    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getAll(): Promise<Feature[]>{
        return this.featureService.getAll();
    }

    @Get(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getById(@Param('id') featureId: number): Promise <Feature | ApiResponse>{
        return this.featureService.getById(featureId);
    }

    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    add(@Body() data: AddFeatureDto): Promise<Feature | ApiResponse>{
        return this.featureService.add(data);
    }

    @Patch(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') featureId: number, @Body() data: EditFeatureDto): Promise<Feature | ApiResponse>{
        return this.featureService.editById(featureId, data);
    }
}
