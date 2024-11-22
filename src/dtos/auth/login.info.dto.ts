export class LoginInfoDto {
    id: number;
    identity: string;
    token: string;
    refreshToken: string;
    refreshTokenExpiresAt: string;

    constructor(id: number, identity: string, jwt: string, refreshToken: string, refreshTokenExpiresAt: string){
        this.id = id;
        this.identity = identity;
        this.token = jwt;
        this.refreshToken = refreshToken;
        this.refreshTokenExpiresAt = refreshTokenExpiresAt;
    }
}