export class LoginInfoAdministratorDto {
    administratorId: number;
    username: string;
    token: string;

    constructor(id: number, un: string, jwt: string){
        this.administratorId = id;
        this.username = un;
        this.token = jwt;
    }
}