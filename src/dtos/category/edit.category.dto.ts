import * as Validator from 'class-validator'

export class EditCategoryDto{
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 32)
    name: string;
    imagePath: string;
    parentCategory: number;
}