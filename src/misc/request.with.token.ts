import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";

declare module 'express' {
    interface Request{
        token: JwtDataDto;
    }
}