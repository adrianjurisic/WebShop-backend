import * as Validator from 'class-validator';

export class UserRefreshTokenDto{
    @Validator.IsNotEmpty()
    @Validator.IsString()
    token: string;
}