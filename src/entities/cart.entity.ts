import {Column,Entity,Index,JoinColumn,ManyToOne,OneToMany,OneToOne,PrimaryGeneratedColumn} from "typeorm";
import { User } from "./user.entity";
import { CartArticle } from "./cart-article.entity";
import { Order } from "./order.entity";

@Index("cart_user_FK", ["userId"], {})
@Entity("cart")
export class Cart {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "cart_id", 
    unsigned: true })
  cartId: number;

  @Column({ 
    type: "int",
    name: "user_id", 
    unsigned: true })
  userId: number;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(
    () => User, 
    (user) => user.carts, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "user_id", referencedColumnName: "userId" }])
  user: User;

  @OneToMany(
    () => CartArticle, 
    (cartArticle) => cartArticle.cart
  )
  cartArticles: CartArticle[];

  @OneToOne(
    () => Order, 
    (order) => order.cart
  )
  order: Order;
}