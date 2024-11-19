import {Column,Entity,Index,JoinColumn,ManyToOne,PrimaryGeneratedColumn} from "typeorm";
import { Article } from "./article.entity";
import { Feature } from "./feature.entity";
import * as Validator from 'class-validator';

@Index("article_feature_article_id_IDX", ["articleId", "featureId"], {unique: true})
@Index("article_feature_feature_FK", ["featureId"], {})
@Entity("article_feature")
export class ArticleFeature {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "article_feature_id",
    unsigned: true,
  })
  articleFeatureId: number;

  @Column({ 
    type: "int",
    name: "article_id", 
    unsigned: true })
  articleId: number;

  @Column({ 
    type: "int",
    name: "feature_id", 
    unsigned: true })
  featureId: number;

  @Column({ 
    type: "varchar",
    length: 255 
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(0, 255)
  value: string;

  @ManyToOne(
    () => Article, 
    (article) => article.articleFeatures, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(
    () => Feature, 
    (feature) => feature.articleFeatures, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "feature_id", referencedColumnName: "featureId" }])
  feature: Feature;
}
