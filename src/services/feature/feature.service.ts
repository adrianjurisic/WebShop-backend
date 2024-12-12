import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { AddFeatureDto } from "src/dtos/feature/add.feature.dto";
import DistinctFeatureValuesDto from "src/dtos/feature/distinct.feature.values.dto";
import { EditFeatureDto } from "src/dtos/feature/edit.feature.dto";
import { ArticleFeature } from "src/entities/article-features.entity";
import { Feature } from "src/entities/feature.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";


@Injectable()
export class FeatureService{
    constructor ( 
        @InjectRepository(Feature)
        private readonly feature: Repository<Feature>,
        
        @InjectRepository(ArticleFeature)
        private readonly articleFeature: Repository<ArticleFeature>, 
    ){}

    getAll(): Promise<Feature[]>{
        return this.feature.find({relations: {category: true}});
    }

    async getById(featureId: number): Promise<Feature | ApiResponse>{
        let feature: Feature = await this.feature.findOne({where: {featureId}, relations: {category: true}});

        if(feature === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002));
            });
        }
        return this.feature.findOne({where: {featureId}});
    }

    add(data: AddFeatureDto): Promise<Feature | ApiResponse>{
        let newFeature: Feature = new Feature();
        newFeature.name = data.name;
        newFeature.categoryId = data.categoryId;

        return new Promise((resolve)=>{
            this.feature.save(newFeature)
            .then(data => resolve(data))
            .catch(error => {
                const response: ApiResponse = new ApiResponse ("error", -1002);
                resolve(response);
            })
        })
    }

    async editById(featureId: number, data: EditFeatureDto): Promise <Feature | ApiResponse> {
        let feature: Feature = await this.feature.findOne({where: {featureId}});

        if (feature === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002))
            });
        }

        feature.name = data.name;
        if(data.categoryId != null){
            feature.categoryId = data.categoryId;
        }
        return this.feature.save(feature);
    }

    async getDistinctValuesByCategoryId(categoryId: number): Promise <DistinctFeatureValuesDto>{
        const features = await this.feature.find({where: {
            categoryId: categoryId,
        }});

        const result: DistinctFeatureValuesDto = {
            features: [],
        };

        if(!features || features.length === 0){
            return result;
        }

        result.features = await Promise.all(features.map(async feature => {
            const values: string[] = 
                (
                    await this.articleFeature.createQueryBuilder("af")
                    .select("DISTINCT af.value", 'value')
                    .where('af.featureId = :featureId', {featureId: feature.featureId})
                    .orderBy('af.value', 'ASC')
                    .getRawMany()
                ).map(item => item.value);
            return{
                featureId: feature.featureId,
                name: feature.name,
                values: values,
            };
        }));

        return result;

    }


}