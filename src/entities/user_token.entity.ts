import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";
import * as Validator from "class-validator";

@Entity("user_token")
export class UserToken {
  @PrimaryGeneratedColumn({ 
    type: "int", 
    name: "user_token_id", 
    unsigned: true })
  userTokenId: number;

  @Column({ 
    type: "int", 
    name: "user_id", 
    unsigned: true })
  userId: number;

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
    length: 1,
    default: 1
  })
  @Validator.IsNotEmpty()
  @Validator.IsIn([ 1, 0 ])
  isValid: number =  1 | 0;

}