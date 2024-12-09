import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Category } from "src/entities/category.entity";
import { resolve } from "path";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { AddCategoryDto } from "src/dtos/category/add.category.dto";
import { EditCategoryDto } from "src/dtos/category/edit.category.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class CategoryService{
    constructor ( 
        @InjectRepository(Category)
        private readonly category: Repository<Category> // !!! navesti u app.module.ts
    ){}

    async getAll(query: any): Promise<Category[]> {
        const queryBuilder = this.category.createQueryBuilder('category');
        if (query.filter) {
            try {
                const parsedFilter = JSON.parse(query.filter);
    
                if (parsedFilter.parentCategoryId === '$isnull') {
                    queryBuilder.where('category.parent__category_id IS NULL');
                }
            } catch (error) {
                console.error('Failed to parse filter:', error);
            }
        }
        return queryBuilder.getMany();
    }
    
    

    async getById(categoryId: number): Promise<Category | ApiResponse>{
        let category: Category = await this.category.findOne({where: {categoryId}});

        if(category === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002));
            });
        }
        return this.category.findOne({
            where: {categoryId},
            relations: {parentCategory: true},
        });
    }

    add(data: AddCategoryDto): Promise<Category | ApiResponse>{
        let newCategory: Category = new Category();
        newCategory.name = data.name;
        newCategory.imagePath = data.imagePath;
        newCategory.parentCategoryId = data.parentCategory;

        return new Promise((resolve)=>{
            this.category.save(newCategory)
            .then(data => resolve(data))
            .catch(error => {
                const response: ApiResponse = new ApiResponse ("error", -1002);
                resolve(response);
            })
        })
    }

    async editById(categoryId: number, data: EditCategoryDto): Promise <Category | ApiResponse> {
        let category: Category = await this.category.findOne({where: {categoryId}});

        if (category === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002))
            });
        }

        category.name = data.name;
        category.imagePath = data.imagePath;
        category.parentCategoryId = data.parentCategory;
        return this.category.save(category);
    }


}