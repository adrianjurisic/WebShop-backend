import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { User } from "src/entities/user.entity";
import { UserToken } from "src/entities/user_token.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class UserService{
    constructor ( 
        @InjectRepository(User)
        private readonly user: Repository<User>, // !!! navesti u app.module.ts

        @InjectRepository(UserToken)
        private readonly userToken: Repository<UserToken>,
    ){}

    getAll(): Promise<User[]>{
        return this.user.find();
    }

    async getById(userId: number): Promise<User | ApiResponse>{
        let user: User = await this.user.findOne({where: {userId}});

        if(user === null){
            return new Promise((resolve)=>{
                resolve(new ApiResponse("error", -1002));
            });
        }
        return this.user.findOne({where: {userId}});
    }

    async getByEmail(email: string): Promise<User | null>{
        let user: User = await this.user.findOne({where: {email: email}});
        if(user){
            return user;
        }
        return null;
    }

    async register(data: UserRegistrationDto): Promise<User | ApiResponse>{
        const crypto = require('crypto');
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        const newUser: User = new User();
        newUser.email = data.email;
        newUser.passwordHash = passwordHashString;
        newUser.forename = data.forename;
        newUser.surname = data.surname;
        newUser.phoneNumber = data.phoneNumber;
        newUser.postalAdress = data.postalAddress;

        try{
            const savedUser = await this.user.save(newUser);
            if(!savedUser){
                throw new Error('');
            }
            return savedUser;

        }catch(e){
            return new ApiResponse('error', -6001, 'This user can not be created!')
        }
    }

    async addToken(userId: number, token: string, expiresAt: string){
        const userToken = new UserToken();
        userToken.userId = userId;
        userToken.token = token;
        userToken.expiresAt = expiresAt;

        return await this.userToken.save(userToken);
    }

    async getUserToken(token: string): Promise<UserToken>{
        return await this.userToken.findOne({where: {token: token,}});
    }

    async invalidateToken(token: string): Promise<UserToken | ApiResponse>{
        const userToken = await this.getUserToken(token);

        if(!userToken){
            return new ApiResponse("error", -10001, "No refresh token!");
        }

        userToken.isValid = 0;

        await this.userToken.save(userToken);
        return await this.getUserToken(token);
    }

    async invalidateUserToken(userId: number): Promise<(UserToken | ApiResponse)[]>{
        const userTokens = await  this.userToken.find({where: {userId: userId}})
        const results = [];
        for(const userToken of userTokens){
            results.push(this.invalidateToken(userToken.token));
        }
        return results;
    }


}