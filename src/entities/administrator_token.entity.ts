import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";
import * as Validator from "class-validator";

@Entity("administrator_token")
export class AdministratorToken {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "administrator_token_id", 
    unsigned: true })
    administratorTokenId: number;

  @Column({ 
    type: "int", 
    name: "administrator_id", 
    unsigned: true 
  })
  administratorId: number;

  @Column({ 
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: string;

  @Column({
    type: "text"
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  token: string;

  @Column({
    type: "datetime",
    name: "expires_at"
  })
  expiresAt: string;

  @Column({
    type: "tinyint",
    name: "is_valid",
    default: 1
  })
  @Validator.IsNotEmpty()
  @Validator.IsIn([ 1, 0 ])
  isValid: number =  1 | 0;

}