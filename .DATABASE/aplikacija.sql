DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username_IDX` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `administrator` VALUES (1,'Adrian','80511108AFB0F965A336651BBA51BCF4A8A476901FAB1AB5EB5FD5709A9CBE5D78F12D641888B590BEDC6D3C1A99E5EF10F085A8C42EDB8D9F8121E915533524'),(2,'test','test123'),(3,'peric','68076CA59B3569F762FE80118BAC26A1F3CD95F465DCFCF290B9FC370192BAE964CFE895878AF85D356003BA084FB86D1D15A16B2962DF170B119C2AC947EC05'),(5,'juric','DD455981DB0A3B75D910034E01E0FB8BBDADBD0DD7DFFC4D21A5AB77619317A75EF4E9F8EBB7942837B63013BE11A81F6894A60E710A338E5EA19A473B084DD1');

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `excerpt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('available','visible','hidden') COLLATE utf8mb4_unicode_ci DEFAULT 'available',
  `is_promoted` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `article_category_FK` (`category_id`),
  CONSTRAINT `article_category_FK` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article` VALUES (1,'ACME HD11 dddddd',5,'Neki kratak tekst 2...','Neki detaljniji sadrzaj 2...','visible',1,'2024-11-05 14:15:52');

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `feature_id` int unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `article_feature_article_id_IDX` (`article_id`,`feature_id`) USING BTREE,
  KEY `article_feature_feature_FK` (`feature_id`),
  CONSTRAINT `article_feature_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `article_feature_feature_FK` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article_feature` VALUES (4,1,1,'1024GB'),(5,1,2,'SATA 3.0');

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `article_price_article_FK` (`article_id`),
  CONSTRAINT `article_price_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article_price` VALUES (1,1,57.11,'2024-11-12 21:08:01'),(2,1,54.56,'2024-11-12 21:14:57');

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `cart_user_FK` (`user_id`),
  CONSTRAINT `cart_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `article_id` int unsigned DEFAULT NULL,
  `quantity` int unsigned NOT NULL,
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `cart_article_article_id_IDX` (`article_id`,`cart_id`) USING BTREE,
  KEY `cart_article_cart_FK` (`cart_id`),
  CONSTRAINT `cart_article_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cart_article_cart_FK` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name_IDX` (`name`) USING BTREE,
  UNIQUE KEY `category_image_path_IDX` (`image_path`) USING BTREE,
  KEY `category_category_FK` (`parent__category_id`),
  CONSTRAINT `category_category_FK` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category` VALUES (1,'Računarske komponente','assets/pc.jpg',NULL),(2,'Kućna elektronika','assets/home.jpg',NULL),(3,'Laptop/računari','assets/pc/laptp.jpg',1),(4,'Memorijski medij','assets/pc/memory.jpg',1),(5,'Hard diskovi','assets/pc/memory/hdd.jpg',4);

DROP TABLE IF EXISTS `feature`;
CREATE TABLE `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_name_IDX` (`name`,`category_id`) USING BTREE,
  KEY `feature_category_FK` (`category_id`),
  CONSTRAINT `feature_category_FK` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `feature` VALUES (1,'Kapacitet',5),(4,'Napon',2),(3,'Tehnologija',5),(2,'Tip',5);

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL,
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_cart_id_IDX` (`cart_id`) USING BTREE,
  CONSTRAINT `order_cart_FK` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `image_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `photo_image_path_IDX` (`image_path`) USING BTREE,
  KEY `photo_article_FK` (`article_id`),
  CONSTRAINT `photo_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `photo` VALUES (11,1,'2024117-3583356160-hard-disk-slika.jpg');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forename` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_adress` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_IDX` (`email`) USING BTREE,
  UNIQUE KEY `user_phone_number_IDX` (`phone_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user` VALUES (1,'test@test.ba','DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991','Neko','Nekic','061/455-455','Gradacacka 31, 71000 Sarajevo');
