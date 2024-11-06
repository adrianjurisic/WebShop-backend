export class AddArticleDto{
    name: string;
    categoryId: number;
    excerpt: string;
    description: string;
    price: number;
    features: {
        featureId: number;
        value: string;
    }[];
}