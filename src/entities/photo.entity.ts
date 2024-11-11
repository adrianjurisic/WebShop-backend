import {Column,Entity,Index,JoinColumn,ManyToOne,PrimaryGeneratedColumn} from "typeorm";
import { Article } from "./article.entity";

@Index("photo_article_FK", ["articleId"], {})
@Index("photo_image_path_IDX", ["imagePath"], { unique: true })
@Entity("photo")
export class Photo {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "photo_id", 
    unsigned: true })
  photoId: number;

  @Column({ 
    type: "int", 
    name: "article_id", 
    unsigned: true })
  articleId: number;

  @Column({ 
    type: "varchar", 
    name: "image_path", 
    nullable: true,
    unique: true, 
    length: 128 })
  imagePath: string;

  @ManyToOne(
    () => Article, 
    (article) => article.photos, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE", 
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
