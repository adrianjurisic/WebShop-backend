import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";
import * as Validator from 'class-validator';

@Index("administrator_username_IDX", ["username"], { unique: true })
@Entity("administrator")
export class Administrator {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "administrator_id",
    unsigned: true,
  })
  administratorId: number;

  @Column("varchar", { 
    name: "username", 
    unique: true, 
    length: 32 
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Matches(/^[a-z][a-z0-9\.]{3,30}[a-z0-9]$/)
  username: string;

  @Column("varchar", { 
    name: "password_hash", 
    nullable: true, 
    length: 128 
  })
  @Validator.IsNotEmpty()
  @Validator.IsHash('sha512')
  passwordHash: string | null;
}
