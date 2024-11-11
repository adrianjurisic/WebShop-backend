import {Column,Entity,Index,JoinColumn,ManyToOne,PrimaryGeneratedColumn} from "typeorm";
import { Article } from "./article.entity";
import { Cart } from "./cart.entity";

@Index("cart_article_article_id_IDX", ["articleId", "cartId"], { unique: true })
@Index("cart_article_cart_FK", ["cartId"], {})
@Entity("cart_article")
export class CartArticle {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "cart_article_id",
    unsigned: true,
  })
  cartArticleId: number;

  @Column({ 
    type: "int",
    name: "cart_id", 
    unsigned: true })
  cartId: number;

  @Column({ 
    type: "int",
    name: "article_id",
    unsigned: true })
  articleId: number;

  @Column({ 
    type: "int", 
    unsigned: true })
  quantity: number;

  @ManyToOne(
    () => Article, 
    (article) => article.cartArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;

  @ManyToOne(
    () => Cart, 
    (cart) => cart.cartArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "cart_id", referencedColumnName: "cartId" }])
  cart: Cart;
}
