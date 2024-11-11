import { Body, Controller, Get, Param, Post, Put } from "@nestjs/common";
import { AddFeatureDto } from "src/dtos/feature/add.feature.dto";
import { EditFeatureDto } from "src/dtos/feature/edit.feature.dto";
import { Feature } from "src/entities/feature.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { FeatureService } from "src/services/feature/feature.service";



@Controller('api/feature')
export class FeatureController{
    constructor(
        private featureService: FeatureService
    ) {}

    @Get()
    getAll(): Promise<Feature[]>{
        return this.featureService.getAll();
    }

    @Get(':id')
    getById(@Param('id') featureId: number): Promise <Feature | ApiResponse>{
        return this.featureService.getById(featureId);
    }

    @Put()
    add(@Body() data: AddFeatureDto): Promise<Feature | ApiResponse>{
        return this.featureService.add(data);
    }

    @Post(':id')
    edit(@Param('id') featureId: number, @Body() data: EditFeatureDto): Promise<Feature | ApiResponse>{
        return this.featureService.editById(featureId, data);
    }
}