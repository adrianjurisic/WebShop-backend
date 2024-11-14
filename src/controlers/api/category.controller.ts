import { Body, Controller, Get, Param, Post, Put } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Category } from "src/entities/category.entity";
import { AddCategoryDto } from "src/dtos/category/add.category.dto";
import { EditCategoryDto } from "src/dtos/category/edit.category.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { CategoryService } from "src/services/category/category.service";

@Controller('api/category')
export class CategoryController{
    constructor(
        private categoryService: CategoryService
    ) {}

    @Get()
    getAll(): Promise<Category[]>{
        return this.categoryService.getAll();
    }

    @Get(':id')
    getById(@Param('id') categoryId: number): Promise <Category | ApiResponse>{
        return this.categoryService.getById(categoryId);
    }

    @Put()
    add(@Body() data: AddCategoryDto): Promise<Category | ApiResponse>{
        return this.categoryService.add(data);
    }

    @Post(':id')
    edit(@Param('id') categoryId: number, @Body() data: EditCategoryDto): Promise<Category | ApiResponse>{
        return this.categoryService.editById(categoryId, data);
    }

    // TODO: Kreirati RoleCheckedGuard za odredjene funkcije
    //       na mjestima gdje treba da se nalaze
}