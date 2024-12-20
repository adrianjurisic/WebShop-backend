import { Body, Controller, HttpException, HttpStatus, Post, Put, Req } from "@nestjs/common";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from 'jsonwebtoken';
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { Request } from "express";
import { jwtSecret } from "config/jwt.secret";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { UserService } from "src/services/user/user.service";
import { LoginUserDto } from "src/dtos/user/login.user.dto";
import { JwtRefreshDataDto } from "src/dtos/auth/jwt.refresh.dto";
import { time } from "console";
import { UserRefreshTokenDto } from "src/dtos/auth/user.refresh.token.dto";
import { AdministratorRefreshTokenDto } from "src/dtos/auth/administrator.refresh.token.dto";

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

        if(administrator.passwordHash !== passwordHashString){
            return new Promise(resolve => resolve (new ApiResponse("error", -3002)));
        }

        const jwtData = new JwtDataDto();
        jwtData.role = "administrator";
        jwtData.id = administrator.administratorId;
        jwtData.identity = administrator.username;
        jwtData.exp = this.getDatePlus(60 * 5);
        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const jwtRefershData = new JwtRefreshDataDto();
        jwtRefershData.role = jwtData.role;
        jwtRefershData.id = jwtData.id;
        jwtRefershData.identity = jwtData.identity;
        jwtRefershData.ip = jwtData.ip;
        jwtRefershData.ua = jwtData.ua;
        jwtRefershData.exp = this.getDatePlus(60 * 60 * 24 * 31);

        let refreshToken: string = jwt.sign(jwtRefershData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoDto(
            administrator.administratorId,
            administrator.username,
            token,
            refreshToken,
            this.getIsoDate(jwtRefershData.exp),
        );

        await this.administratorService.addToken(administrator.administratorId, refreshToken, this.getDatabaseDateFormat(this.getIsoDate(jwtRefershData.exp)));

        return new Promise(resolve => resolve(responseObject));
    }

    // http://localhost:3000/auth/administrator/refresh
    @Post('administrator/refresh')
    async administratorTokenRefresh(@Req() req: Request, @Body() data: AdministratorRefreshTokenDto): Promise <LoginInfoDto | ApiResponse>{
        const administratorToken = await this.administratorService.getAdministratorToken(data.token);
    
        if(!administratorToken){
            return new ApiResponse("error", -10002, "No refresh token!");
        }

        if(administratorToken.isValid === 0){
            return new ApiResponse("error", -10003, "Token is not valid!");
        }
    
        const sada = new Date();
        const datumIsteka = new Date(administratorToken.expiresAt);
    
        if(datumIsteka.getTime() < sada.getTime()){
            return new ApiResponse("error", -10004, "Token is no longer valid!");
        }
    
        let jwtRefreshData: JwtRefreshDataDto;
        try{
            jwtRefreshData = jwt.verify(data.token, jwtSecret);
        } catch(e){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }
    
        if(!jwtRefreshData){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }
    
        if (jwtRefreshData.ip !== req.ip.toString()){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }
    
        if (jwtRefreshData.ua !== req.headers["user-agent"]){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }
    
        const jwtData = new JwtDataDto();
        jwtData.role = jwtRefreshData.role;
        jwtData.id = jwtRefreshData.id;
        jwtData.identity = jwtRefreshData.identity;
        jwtData.exp = this.getDatePlus(60 * 5);
        jwtData.ip = jwtRefreshData.ip;
        jwtData.ua = jwtRefreshData.ua;
    
        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);
    
        const responseObject = new LoginInfoDto(
            jwtData.id,
            jwtData.identity,
            token,
            data.token,
            this.getIsoDate(jwtRefreshData.exp),
        );
    
        return responseObject;
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
        jwtData.exp = this.getDatePlus(60 * 5);

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const jwtRefershData = new JwtRefreshDataDto();
        jwtRefershData.role = jwtData.role;
        jwtRefershData.id = jwtData.id;
        jwtRefershData.identity = jwtData.identity;
        jwtRefershData.ip = jwtData.ip;
        jwtRefershData.ua = jwtData.ua;
        jwtRefershData.exp = this.getDatePlus(60 * 60 * 24 * 31);

        let refreshToken: string = jwt.sign(jwtRefershData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoDto(
            user.userId,
            user.email,
            token,
            refreshToken,
            this.getIsoDate(jwtRefershData.exp),
        );

        await this.userService.addToken(user.userId, refreshToken, this.getDatabaseDateFormat(this.getIsoDate(jwtRefershData.exp)));

        return new Promise(resolve => resolve(responseObject));
    }

    // http://localhost:3000/auth/user/refresh
    @Post('user/refresh')
    async userTokenRefresh(@Req() req: Request, @Body() data: UserRefreshTokenDto): Promise <LoginInfoDto | ApiResponse>{
        const userToken = await this.userService.getUserToken(data.token);

        if(!userToken){
            return new ApiResponse("error", -10002, "No refresh token!");
        }

        if(userToken.isValid === 0){
            return new ApiResponse("error", -10003, "Token is not valid!");
        }

        const sada = new Date();
        const datumIsteka = new Date(userToken.expiresAt);

        if(datumIsteka.getTime() < sada.getTime()){
            return new ApiResponse("error", -10004, "Token is no longer valid!");
        }

        let jwtRefreshData: JwtRefreshDataDto;
        try{
            jwtRefreshData = jwt.verify(data.token, jwtSecret);
        } catch(e){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if(!jwtRefreshData){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if (jwtRefreshData.ip !== req.ip.toString()){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if (jwtRefreshData.ua !== req.headers["user-agent"]){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        const jwtData = new JwtDataDto();
        jwtData.role = jwtRefreshData.role;
        jwtData.id = jwtRefreshData.id;
        jwtData.identity = jwtRefreshData.identity;
        jwtData.exp = this.getDatePlus(60 * 5);
        jwtData.ip = jwtRefreshData.ip;
        jwtData.ua = jwtRefreshData.ua;

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoDto(
            jwtData.id,
            jwtData.identity,
            token,
            data.token,
            this.getIsoDate(jwtRefreshData.exp),
        );

        return responseObject;
    }

    private getDatePlus (numberOfSeconds: number){
        return new Date().getTime() / 1000 + numberOfSeconds;
    }

    private getIsoDate(timestamp: number){
        const date = new Date();
        date.setTime(timestamp * 1000);
        return date.toISOString();
    }

    private getDatabaseDateFormat(isoFormat: string): string{
        return isoFormat.substring(0,19).replace('T', ' ');
    }
}