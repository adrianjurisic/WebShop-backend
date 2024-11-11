import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

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
    length: 32 })
  username: string;

  @Column("varchar", { 
    name: "password_hash", 
    nullable: true, 
    length: 128 })
  passwordHash: string | null;
}
