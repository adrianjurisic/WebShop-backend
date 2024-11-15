import { Body, Controller, Post, Put, Req } from "@nestjs/common";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from 'jsonwebtoken';
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { REQUEST } from "@nestjs/core";
import { Request } from "express";
import { jwtSecret } from "config/jwt.secret";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { UserService } from "src/services/user/user.service";
import { LoginUserDto } from "src/dtos/user/login.user.dto";

@Controller('auth')
export class AuthController{
    constructor(
        public administratorService: AdministratorService,
        public userService: UserService
    ){}

    // http://localhost:3000/auth/administrator/login
    @Post('administrator/login') 
    async doAdministratorLogin(@Body() data: LoginAdministratorDto, @Req() req: Request): Promise <LoginInfoDto | ApiResponse>{
        const administrator = await this.administratorService.getByUsername(data.username);

        if(!administrator){
            return new Promise(resolve=>{
                resolve(new ApiResponse("error", -3001));
            })
        }

        const crypto = require('crypto');
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        if(administrator.passwordHash != data.password){
            return new Promise(resolve => resolve (new ApiResponse("error", -3002)));
        }

        const jwtData = new JwtDataDto();
        jwtData.role = "administrator";
        jwtData.id = administrator.administratorId;
        jwtData.identity = administrator.username;
        let sada = new Date();
        sada.setDate(sada.getDate() + 14);
        const istekTimeStamp = sada.getTime() / 1000;
        jwtData.exp = istekTimeStamp;

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoDto(
            administrator.administratorId,
            administrator.username,
            token
        );

        return new Promise(resolve => resolve(responseObject));
    }

    // POST http://localhost:3000/auth/user/register
    @Post('user/register') 
    async userRegister(@Body() data: UserRegistrationDto){
        return await this.userService.register(data);
    }

    // POST http://localhost:3000/auth/user/login
    @Post('user/login') 
    async doUserLogin(@Body() data: LoginUserDto, @Req() req: Request): Promise <LoginInfoDto | ApiResponse>{
        const user = await this.userService.getByEmail(data.email);

        if(!user){
            return new Promise(resolve=>{
                resolve(new ApiResponse("error", -3001));
            })
        }

        const crypto = require('crypto');
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        if(user.passwordHash != passwordHashString){
            return new Promise(resolve => resolve (new ApiResponse("error", -3002)));
        }

        const jwtData = new JwtDataDto();
        jwtData.role = "user";
        jwtData.id = user.userId;
        jwtData.identity = user.email;
        let sada = new Date();
        sada.setDate(sada.getDate() + 14);
        const istekTimeStamp = sada.getTime() / 1000;
        jwtData.exp = istekTimeStamp;

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoDto(
            user.userId,
            user.email,
            token
        );
        return new Promise(resolve => resolve(responseObject));
    }
}