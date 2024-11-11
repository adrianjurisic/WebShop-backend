import {Column,Entity,Index,JoinColumn,JoinTable,ManyToMany,ManyToOne,OneToMany,PrimaryGeneratedColumn} from "typeorm";
import { ArticleFeature } from "./article-features.entity";
import { Category } from "./category.entity";
import { Article } from "./article.entity";

@Index("feature_category_FK", ["categoryId"], {})
@Index("feature_name_IDX", ["name", "categoryId"], { unique: true })
@Entity("feature")
export class Feature {
  @PrimaryGeneratedColumn({
    type: "int", 
    name: "feature_id", 
    unsigned: true })
  featureId: number;

  @Column({
    type: "varchar",
    length: 32 })
  name: string;

  @Column({
    type: "int",
    name: "category_id", 
    unsigned: true })
  categoryId: number;

  @OneToMany(
    () => ArticleFeature, 
    (articleFeature) => articleFeature.feature
  )
  articleFeatures: ArticleFeature[];

  @ManyToMany(type => Article, article => article.features)
  @JoinTable({
    name: "article_feature",
    joinColumn: {name: "feature_id", referencedColumnName: "featureId"},
    inverseJoinColumn: {name: "article_id", referencedColumnName: "articleId"}
  })
  articles: Article[];

  @ManyToOne(
    () => Category, 
    (category) => category.features, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;
}
