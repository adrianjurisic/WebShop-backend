import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Photo } from "entities/photo.entity";
import { Repository } from "typeorm";

@Injectable()
export class PhotoService{
    constructor ( 
        @InjectRepository(Photo)
        private readonly photo: Repository<Photo> // !!! navesti u app.module.ts
    ){}

    add(newPhoto: Photo): Promise<Photo>{
        return this.photo.save(newPhoto);
    }

}