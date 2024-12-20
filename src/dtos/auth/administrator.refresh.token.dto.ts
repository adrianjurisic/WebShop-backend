import * as Validator from 'class-validator';

export class AdministratorRefreshTokenDto{
    @Validator.IsNotEmpty()
    @Validator.IsString()
    token: string;
}