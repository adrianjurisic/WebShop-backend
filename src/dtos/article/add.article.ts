export class AddArticleDto{
    name: string;
    categoryId: number;
    excerpt: string;
    description: Text;
    status: "available" | "visible" | "hidden";
    isPromoted: 1 | 0;
}