export class JwtDataAdministratorDto{
    administratorId: number;
    username: string;
    ext: number; // UNIX TIMESTAMP
    ip: string;
    ua: string;

    toPlainObject(){
        return {
            administratorId: this.administratorId,
            username: this.username,
            ext: this.ext,
            ip: this.ip,
            ua: this.ua
        }
    }
}