import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { ChangeOrderStatusDto } from "src/dtos/order/change.order.status.dto";
import { Cart } from "src/entities/cart.entity";
import { Order } from "src/entities/order.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class OrderService {
    constructor (
        @InjectRepository(Order) 
        private readonly order: Repository<Order>,

        @InjectRepository(Cart) 
        private readonly cart: Repository<Cart>
    ){ }

    async add(cartId: number): Promise <Order | ApiResponse> {
        const order = await this.order.findOne({where: {cartId: cartId} });
        if (order){
            return new ApiResponse ("error", -7001, "An order for this cart alredy exist!");
        }

        const cart = await this.cart.findOne({
            where: {cartId},
            relations: [
                "cartArticles",
            ],
        });

        if(!cart){
            return new ApiResponse("error", -7002, "No cart found!");
        }

        if(cart.cartArticles.length === 0){
            return new ApiResponse("error", -7003, "This cart is empty!");
        }

        const newOrder: Order = new Order();
        newOrder.cartId = cartId;
        const savedOrder = await this.order.save(newOrder);

        return await this.getById(savedOrder.orderId);

    }

    async getById(orderId: number){
        return await this.order.findOne({
            where: {orderId},
            relations: [
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices",
            ],
        });
    }

    async getAllByUserId(userId: number): Promise<Order[]> {
        return await this.order.find({
            where: {
                cart: {
                    userId: userId,
                },
            },
            relations: [
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices",
            ],
        });
    }
    

    async changeStatus(orderId: number, newStatus: "rejected" | "accepted" | "shipped" | "pending"): Promise<Order | ApiResponse>{
        const order = await this.getById(orderId);
        if(!order){
            return new ApiResponse("error", -9001, "Order not found!");
        }
        order.status = newStatus;
        await this.order.save(order);
        return await this.getById(orderId);
    }
}