import {Column,Entity,Index,JoinColumn,OneToOne,PrimaryGeneratedColumn} from "typeorm";
import { Cart } from "./cart.entity";

@Index("order_cart_id_IDX", ["cartId"], { unique: true })
@Entity("order")
export class Order {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "order_id", 
    unsigned: true })
  orderId: number;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column({
    type: "int",
    name: "cart_id", 
    unique: true, 
    unsigned: true })
  cartId: number;

  @Column({
    type: "enum",
    enum: ["rejected", "accepted", "shipped", "pending"],
    default: () => "'pending'",
  })
  status: "rejected" | "accepted" | "shipped" | "pending";

  @OneToOne(
    () => Cart, 
    (cart) => cart.order, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "cart_id", referencedColumnName: "cartId" }])
  cart: Cart;
}
