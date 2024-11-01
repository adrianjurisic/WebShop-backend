import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'entities/administrator.entity';
import { identity } from 'rxjs';
import { Repository } from 'typeorm';

@Injectable()
export class AdministratorService {
    constructor (
        @InjectRepository(Administrator) 
        private readonly administrator: Repository<Administrator>,
    ){}

    getAll(): Promise<Administrator[]>{
        return this.administrator.find();
    }

    getById(id: number): Promise<Administrator> {
        return this.administrator.findOne({ where: {} });
    }


}
