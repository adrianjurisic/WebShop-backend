import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ArticleFeature } from "src/entities/article-features.entity";
import { ArticlePrice } from "src/entities/article-price.entity";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { Any, In, Repository } from "typeorm";
import { ArticleSearchDto } from "src/dtos/article/article.search.dto";

@Injectable()
export class ArticleService{
    constructor ( 
        @InjectRepository(Article)
        private readonly article: Repository<Article>, // !!! navesti u app.module.ts

        @InjectRepository(ArticlePrice)
        private readonly articlePrice: Repository<ArticlePrice>,

        @InjectRepository(ArticleFeature)
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



    async editFullArticle(articleId: number, data: EditArticleDto): Promise<Article | ApiResponse>{
        const existingArticle: Article = await this.article.findOne({where: {articleId}, relations:['articlePrices', 'articleFeatures']});
        if (!existingArticle){
            return new ApiResponse('error', -5001, 'Article does not exist!');
        }

        existingArticle.name = data.name;
        existingArticle.categoryId = data.categoryId;
        existingArticle.excerpt = data.excerpt;
        existingArticle.description = data.description;
        existingArticle.status = data.status;
        existingArticle.isPromoted = data.isPromoted;

        const savedArticle = await this.article.save(existingArticle);
        if(!savedArticle){
            return new ApiResponse('error', -5002, 'Could not save the article data!');
        }

        const newPriceString: string = Number(data.price).toFixed(2);
        const newArticlePrice = new ArticlePrice();
        newArticlePrice.articleId = articleId;              
        newArticlePrice.price = data.price;
        if(existingArticle.articlePrices.length !== 0){
            const lastPrice = existingArticle.articlePrices[existingArticle.articlePrices.length - 1].price;
            const lastPriceString: string = Number(lastPrice).toFixed(2);
            if(newPriceString !== lastPriceString){
                const savedArticlePrice = await this.articlePrice.save(newArticlePrice);
                if(!savedArticlePrice){ 
                    return new ApiResponse('error', -5002, 'Could not save new article price!');
                }
            }
        }else{
            const savedArticlePrice = await this.articlePrice.save(newArticlePrice);
            if(!savedArticlePrice){
                return new ApiResponse('error', -5002, 'Could not save new article price!');
            }
        }

        if(data.features !== null){
            await this.articleFeature.remove(existingArticle.articleFeatures);
            for(let feature of data.features){
                let newArticleFeature: ArticleFeature = new ArticleFeature;
                newArticleFeature.articleId = articleId;
                newArticleFeature.featureId = feature.featureId;
                newArticleFeature.value = feature.value;
                await this.articleFeature.save(newArticleFeature);
            }
        }
        return await this.article.findOne({
            where: {articleId},
            relations: [
                "category", 
                "articleFeatures", 
                "features", 
                "articlePrices",
                "photos"
            ]
        });
    }

    async pretraga (data: ArticleSearchDto): Promise<Article[] | ApiResponse>{
        const builder = await this.article.createQueryBuilder("article");
        builder.innerJoinAndSelect(
            "article.articlePrices", 
            "ap", 
            "ap.createdAt = (SELECT MAX(ap.created_at) from article_price AS ap WHERE ap.article_id = article.article_id)");
        builder.leftJoinAndSelect("article.articleFeatures", "af");
        builder.leftJoinAndSelect("article.features", "features");
        builder.leftJoinAndSelect("article.photos", "photos");

        builder.where('article.categoryId = :categoryId', {categoryId: data.categoryId});
        
        if(data.keywords){
            if(data.keywords.length > 0){
                builder.andWhere('(article.name LIKE :kw OR article.excerpt LIKE :kw OR article.description LIKE :kw)', {kw: '%' + data.keywords.trim() + '%'});
            }
        }

        if(data.priceMin && typeof data.priceMin === 'number'){
            builder.andWhere('ap.price >= :min', {min: data.priceMin});
        }

        if(data.priceMax && typeof data.priceMax === 'number'){
            builder.andWhere('ap.price <= :max', {max: data.priceMax});
        }

        if(data.features && data.features.length > 0){
            for (const feature of data.features){
                builder.andWhere('af.featureId = :fId AND af.value IN (:fVals)', 
                {
                    fId: feature.featureId,
                    fVals: feature.values
                });
            }
        }

        let orderBy = 'article.name';
        let orderDirection: 'ASC' | 'DESC' = 'ASC';

        if(data.orderBy && (data.orderBy === 'name' || data.orderBy === 'price')){
            orderBy = data.orderBy;
            if(orderBy === 'price'){
                orderBy = 'ap.price'
            }
            if(orderBy === 'name'){
                orderBy = 'article.name'
            }
        }

        if(data.orderDirection && data.orderDirection){
            orderDirection = data.orderDirection;
        }

        builder.orderBy(orderBy, orderDirection);

        let page = 0;
        if(data.page && typeof data.page === 'number'){
            page = data.page;
        }

        let perPage: 5 | 10 | 25 | 50 | 75 = 25;
        if (data.itemsPerPage && typeof data.itemsPerPage === 'number'){
            perPage = data.itemsPerPage;
        }
        builder.skip(page * perPage);
        builder.take(perPage);

        let articles = await builder.getMany();

        if(articles.length === 0){
            return new ApiResponse("ok", 0, "No articles found!")
        }

        return articles;
        
    }

}