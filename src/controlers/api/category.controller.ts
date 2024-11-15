import { Body, Controller, Get, Param, Patch, Post, Put, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Category } from "src/entities/category.entity";
import { AddCategoryDto } from "src/dtos/category/add.category.dto";
import { EditCategoryDto } from "src/dtos/category/edit.category.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { CategoryService } from "src/services/category/category.service";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";

@Controller('api/category')
export class CategoryController{
    constructor(
        private categoryService: CategoryService
    ) {}

    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getAll(): Promise<Category[]>{
        return this.categoryService.getAll();
    }

    @Get(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getById(@Param('id') categoryId: number): Promise <Category | ApiResponse>{
        return this.categoryService.getById(categoryId);
    }

    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    add(@Body() data: AddCategoryDto): Promise<Category | ApiResponse>{
        return this.categoryService.add(data);
    }

    @Patch(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') categoryId: number, @Body() data: EditCategoryDto): Promise<Category | ApiResponse>{
        return this.categoryService.editById(categoryId, data);
    }

}