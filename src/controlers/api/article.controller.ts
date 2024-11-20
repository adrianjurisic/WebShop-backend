import { Body, Controller, Delete, Get, Param, Patch, Post, Put, Req, UploadedFile, UseGuards, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleService } from "src/services/article/article.service";
import { diskStorage } from 'multer';
import { StorageConfig } from "config/storage.config";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import * as fileType from 'file-type';
import * as fs from 'fs';
import * as sharp from 'sharp';
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ArticleSearchDto } from "src/dtos/article/article.search.dto";


@Controller('api/article')
export class ArticleController{
    constructor(
        private articleService: ArticleService,
        public photoService: PhotoService
    ) {}

    // GET http://localhost.3000/api/article/
    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getAll(): Promise<Article[]>{
        return this.articleService.getAll();
    }

    // GET http://localhost.3000/api/article/4/
    @Get(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    getById(@Param('id') articleId: number): Promise <Article | ApiResponse>{
        return this.articleService.getById(articleId);
    }

    // POST http://localhost.3000/api/article/4/
    @Post('createFull')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    createFullArticle(@Body() data: AddArticleDto): Promise<Article | ApiResponse>{
        return this.articleService.createFullArticle(data);
    }

    // PATCH http://localhost.3000/api/article/4/
    @Patch(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    editFullArticle(@Param('id') articleId: number, @Body() data: EditArticleDto){
        return this.articleService.editFullArticle(articleId, data);
    }

    // POST http://localhost.3000/api/article/4/
    @Post(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') articleId: number, @Body() data: EditArticleDto): Promise<Article | ApiResponse>{
        return this.articleService.editById(articleId, data);
    }

    // POST http://localhost:3000/api/article/:id/uploadPhoto/
    @Post(':id/uploadPhoto/') 
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
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
                    req.fileFilterError = 'Bad file extension!'
                    callback(null, false);
                    return;
                }
                if(!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))){
                    req.fileFilterError = 'Bad file content!'
                    callback(null, false);
                    return;
                }
                callback(null, true);
            },
            limits:{
                files: 1,
                fileSize: StorageConfig.photo.maxSize,
            },
        })
    )

    async uploadPhoto(@Param('id') articleId: number, @UploadedFile() photo, @Req() req): Promise <Photo | ApiResponse>{
        if(req.fileFilterError){
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if(!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        const fileTypeResult = await fileType.fromFile(photo.path);
        if(!fileTypeResult){
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Can not detect file type!');
        }

        const realMimeType = fileTypeResult.mime;
        if(!(realMimeType.includes('jpeg') || realMimeType.includes('png'))){
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Bad file content type!');
        }

        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);
        
        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if(!savedPhoto){
            return new ApiResponse("error", -4001);
        }

        return savedPhoto;
    }

    async createResizedImage(photo, resizeSettings){
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath = StorageConfig.photo.destination + resizeSettings.directory + fileName;
        await sharp(originalFilePath)
            .resize({
                fit: 'cover',
                width: resizeSettings.width,
                height: resizeSettings.height,
                background: {
                    r:255, g:255, b:255, alpha: 0.0
                }
            })
            .toFile(destinationFilePath)
    }

    // http://localhost:3000/api/article/1/deletePhoto/11/
    @Delete(':articleId/deletePhoto/:photoId') 
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    public async deletePhoto(
        @Param('articleId') articleId: number,
        @Param('photoId') photoId: number,
    ){
        const photo = await this.photoService.findOne({where: {photoId}});
        
        if(photo.articleId != articleId ||  !photo){
            return new ApiResponse('error', -4004, 'Photo does not exist!');
        } 
        try{
        fs.unlinkSync(StorageConfig.photo.destination + photo.imagePath);
        fs.unlinkSync(StorageConfig.photo.destination + 
                      StorageConfig.photo.resize.thumb.directory +
                      photo.imagePath);
        fs.unlinkSync(StorageConfig.photo.destination + 
                      StorageConfig.photo.resize.small.directory +
                      photo.imagePath);
        }catch (e) { };

        const deleteResult = await this.photoService.deleteById(photoId);

        if(deleteResult.affected === 0){
            return new ApiResponse('error', -4004, 'Photo does not exist!'); 
        }

        return new ApiResponse('ok', 200, 'One photo deleted!');
    }

    @Post('search')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    async search (@Body() data: ArticleSearchDto): Promise<Article[]>{
        return await this.articleService.search(data);
    }

}