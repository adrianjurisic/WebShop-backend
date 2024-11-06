import { Body, Controller, Get, Param, Post, Put } from "@nestjs/common";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleService } from "src/services/article/article.service";


@Controller('api/article')
export class ArticleController{
    constructor(
        private articleService: ArticleService
    ) {}

    @Get()
    getAll(): Promise<Article[]>{
        return this.articleService.getAll();
    }

    @Get(':id')
    getById(@Param('id') articleId: number): Promise <Article | ApiResponse>{
        return this.articleService.getById(articleId);
    }

    @Post('createFull')
    createFullArticle(@Body() data: AddArticleDto): Promise<Article | ApiResponse>{
        return this.articleService.createFullArticle(data);
    }

    @Post(':id')
    edit(@Param('id') articleId: number, @Body() data: EditArticleDto): Promise<Article | ApiResponse>{
        return this.articleService.editById(articleId, data);
    }
}