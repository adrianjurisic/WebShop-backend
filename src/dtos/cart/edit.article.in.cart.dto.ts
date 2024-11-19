import * as Validator from 'class-validator';

export class EditArticleInCartDto {
    articleId: number;

    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
      allowInfinity: false,
      allowNaN: false,
      maxDecimalPlaces: 0
    })
    quantity: number;
}