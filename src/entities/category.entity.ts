import {Column,Entity,Index,JoinColumn,ManyToOne,OneToMany,PrimaryGeneratedColumn} from "typeorm";
import { Article } from "./article.entity";
import { Feature } from "./feature.entity";
import * as Validator from 'class-validator';

@Index("category_category_FK", ["parentCategoryId"], {})
@Index("category_image_path_IDX", ["imagePath"], { unique: true })
@Index("category_name_IDX", ["name"], { unique: true })
@Entity("category")
export class Category {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "category_id", 
    unsigned: true })
  categoryId: number;

  @Column({
    type: "varchar",
    unique: true, 
    length: 32
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 32)
  name: string;

  @Column({
    type: "varchar",
    name: "image_path",
    unique: true,
    length: 128,
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(1, 128)
  imagePath: string;

  @Column({
    type: "int",
    name: "parent__category_id",
    nullable: true,
    unsigned: true,
  })
  parentCategoryId: number | null;

  @OneToMany(
    () => Article, 
    (article) => article.category
  )
  articles: Article[];

  @ManyToOne(
    () => Category, 
    (category) => category.categories, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([
    { name: "parent__category_id", referencedColumnName: "categoryId" },
  ])
  parentCategory: Category;

  @OneToMany(
    () => Category, 
    (category) => category.parentCategory
  )
  categories: Category[];

  @OneToMany(
    () => Feature, 
    (feature) => feature.category
  )
  features: Feature[];
}
