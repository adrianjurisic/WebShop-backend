import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article";
import { EditArticleDto } from "src/dtos/article/edit.article";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class ArticleService{
    constructor ( 
        @InjectRepository(Article)
        private readonly article: Repository<Article> // !!! navesti u app.module.ts
    ){}

    getAll(): Promise<Article[]>{
        return this.article.find({relations: {category: true, photos: true, articlePrices: true, articleFeatures: true, features: true}});
    }

    async getById(articleId: number): Promise<Article | ApiResponse>{
        let category: Article = await this.article.findOne({
            where: {articleId},
            relations: {category: true, photos: true, articlePrices: true, articleFeatures: true, features: true}
        });

        if(category === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002));
            });
        }
        return this.article.findOne({
            where: {articleId}
        });
    }

    add(data: AddArticleDto): Promise<Article | ApiResponse>{
        let newArticle: Article = new Article();
        
        newArticle.name = data.name;
        newArticle.categoryId = data.categoryId;
        newArticle.excerpt = data.excerpt;
        newArticle.description = data.excerpt;
        newArticle.status = data.status;
        newArticle.isPromoted = data.isPromoted;


        return new Promise((resolve)=>{
            this.article.save(newArticle)
            .then(data => resolve(data))
            .catch(error => {
                const response: ApiResponse = new ApiResponse ("error", -1002);
                resolve(response);
            })
        })
    }

    async editById(articleId: number, data: EditArticleDto): Promise <Article | ApiResponse> {
        let article: Article = await this.article.findOne({where: {articleId}});

        if (article === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002))
            });
        }

        article.name = data.name;
        article.categoryId = data.categoryId;
        article.excerpt = data.excerpt;
        article.description = data.excerpt;
        article.status = data.status;
        article.isPromoted = data.isPromoted;
        return this.article.save(article);
    }

}