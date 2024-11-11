import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'src/entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { ArticleFeature } from 'src/entities/article-features.entity';
import { ArticlePrice } from 'src/entities/article-price.entity';
import { Article } from 'src/entities/article.entity';
import { CartArticle } from 'src/entities/cart-article.entity';
import { Cart } from 'src/entities/cart.entity';
import { Category } from 'src/entities/category.entity';
import { Feature } from 'src/entities/feature.entity';
import { Order } from 'src/entities/order.entity';
import { Photo } from 'src/entities/photo.entity';
import { User } from 'src/entities/user.entity';
import { AdministratorController } from './controlers/api/administrator.controller';
import { AppController } from './controlers/app.controller';
import { CategoryController } from './controlers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleService } from './services/article/article.service';
import { ArticleController } from './controlers/api/article.controller';
import { AuthController } from './controlers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { PhotoService } from './services/photo/photo.service';
import { FeatureService } from './services/feature/feature.service';
import { FeatureController } from './controlers/api/feature.controller';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseConfiguration.hostname,
      port: 3306,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      entities: [
        Administrator,
        ArticleFeature,
        ArticlePrice,
        Article,
        CartArticle,
        Cart,
        Category,
        Feature,
        Order,
        Photo,
        User,
      ]
    }),
    TypeOrmModule.forFeature([
      Administrator,
        ArticleFeature,
        ArticlePrice,
        Article,
        CartArticle,
        Cart,
        Category,
        Feature,
        Order,
        Photo,
        User,
    ])
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    ArticleController,
    AuthController,
    FeatureController,
  ],
  providers: [
    AdministratorService,
    CategoryService,
    ArticleService,
    PhotoService,
    FeatureService,
  ],
  exports: [
    AdministratorService,
  ]
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('auth/*')
      .forRoutes('api/*')
  }
  
}
