import {Column,Entity,Index,JoinColumn,ManyToOne,OneToMany,PrimaryGeneratedColumn} from "typeorm";
import { ArticleFeature } from "./article-features.entity";
import { Category } from "./category.entity";

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

  @ManyToOne(
    () => Category, 
    (category) => category.features, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;
}
