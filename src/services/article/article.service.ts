import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ArticleFeature } from "src/entities/article-features.entity";
import { ArticlePrice } from "src/entities/article-price.entity";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class ArticleService{
    constructor ( 
        @InjectRepository(Article)
        private readonly article: Repository<Article>, // !!! navesti u app.module.ts

        @InjectRepository(Article)
        private readonly articlePrice: Repository<ArticlePrice>,

        @InjectRepository(Article)
        private readonly articleFeature: Repository<ArticleFeature>
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
            where: {articleId},
            relations: {category: true, photos: true, articlePrices: true, articleFeatures: true, features: true}
        });
    }

    async createFullArticle(data: AddArticleDto): Promise<Article | ApiResponse> {
        let newArticle: Article = new Article();
        newArticle.name = data.name;
        newArticle.categoryId = data.categoryId;
        newArticle.excerpt = data.excerpt;
        newArticle.description = data.description;

        let savedArticle = await this.article.save(newArticle);

        let newArticlePrice: ArticlePrice = new ArticlePrice();
        newArticlePrice.articleId = savedArticle.articleId;
        newArticlePrice.price = data.price;
        await this.articlePrice.save(newArticlePrice);

        for(let feature of data.features){
            let newArticleFeature: ArticleFeature = new ArticleFeature;
            newArticleFeature.articleId = savedArticle.articleId;
            newArticleFeature.featureId = feature.featureId;
            newArticleFeature.value = feature.value;

            await this.articleFeature.save(newArticleFeature);
        }

        let id = savedArticle.articleId;
        return savedArticle;

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