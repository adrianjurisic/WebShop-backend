import { Body, Controller, Get, Param, Post, Put, UploadedFile, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleService } from "src/services/article/article.service";
import { diskStorage } from 'multer';
import { StorageConfig } from "config/storage.config";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "entities/photo.entity";


@Controller('api/article')
export class ArticleController{
    constructor(
        private articleService: ArticleService,
        public photoService: PhotoService
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

    @Post(':id/uploadPhoto/') // POST http://localhost:3000/api/article/:id/uploadPhoto/
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photosDestination,
                filename: (req, file, callback) => {
                    let original: string = file.originalname;
                    let normalized = original.replace(/\s+/g, '-'); 
                    normalized = normalized.replace(/[^A-z0-9\.\-]/g, '')
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string = new Array(10)
                        .fill(0)
                        .map(e => (Math.random() * 9).toFixed(0).toString())
                        .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalized;
                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);
                }
            }),
            fileFilter: (req, file, callback) => {
                if(!file.originalname.toLowerCase().match(/\.(jpg|png)$/)){
                    callback(new Error('Bad file extensions!'), false);
                    return;
                }
                if(!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))){
                    callback(new Error('Bad file content!'), false);
                    return;
                }
                callback(null, true);
            },
            limits:{
                files: 1,
                fieldSize: StorageConfig.photoMaxFileSize,
            },
        })
    )

    async uploadPhoto(@Param('id') articleId: number, @UploadedFile() photo): Promise <Photo | ApiResponse>{
        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if(!savedPhoto){
            return new ApiResponse("error", -4001);
        }

        return savedPhoto;
    }
}