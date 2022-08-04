-- -----------------------------------------------------
-- Schema shop_for_home
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ShopForHome`;

CREATE SCHEMA `ShopForHome`;
USE `ShopForHome` ;

-- -----------------------------------------------------
-- Table  `ShopForHome`.`cart`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `ShopForHome`.cart;

 create table hibernate_sequence(next_val BIGINT NOT NULL);
 INSERT INTO hibernate_sequence (next_val) VALUES (4);

CREATE TABLE IF NOT EXISTS `ShopForHome`.`cart`
(
    `user_id` BIGINT(20) NOT NULL,
    CONSTRAINT `cart_pkey1` PRIMARY KEY (`user_id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;
	

-- -----------------------------------------------------
-- Table: `ShopForHome`.`discount`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `ShopForHome`.`discount`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`discount`
(
    `id` VARCHAR(255) NOT NULL,
    `status` BIGINT(20),
    CONSTRAINT `discount_pkey` PRIMARY KEY (`id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table: `ShopForHome`.`order_main`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `ShopForHome`.order_main;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`order_main`
(
    `order_id` BIGINT(20) NOT NULL,
    `buyer_address` VARCHAR(255) ,
    `buyer_email` VARCHAR(255) ,
    `buyer_name` VARCHAR(255) ,
    `buyer_phone` VARCHAR(255) ,
    `create_time` DATETIME(6),
    `order_amount` DECIMAL(19,2) NOT NULL,
    `order_status` INT(11) NOT NULL DEFAULT 0,
    `update_time` DATETIME(6),
    CONSTRAINT `order_main_pkey` PRIMARY KEY (`order_id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table: `ShopForHome`.`product_category`
-- -----------------------------------------------------

-- DROP TABLE IF EXISTS `ShopForHome`.`product_category`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`product_category`
(
    `category_id` INT(11) NOT NULL,
    `category_name` VARCHAR(255) ,
    `category_type` INT(11),
    `create_time` DATETIME(6),
    `update_time` DATETIME(6),
    CONSTRAINT `product_category_pkey` PRIMARY KEY (`category_id`),
    CONSTRAINT `uk_6kq6iveuim6wd90cxo5bksumw` UNIQUE (`category_type`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------	
-- Table: `ShopForHome`.`product_in_order`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `ShopForHome`.`product_in_order`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`product_in_order`
(
    `id` BIGINT(20) NOT NULL,
    `category_type` INT(11) NOT NULL,
    `count` INT(11),
    `product_description` VARCHAR(255)  NOT NULL,
    `product_icon` VARCHAR(255) ,
    `product_id` VARCHAR(255) ,
    `product_name` VARCHAR(255) ,
    `product_price` DECIMAL(19,2) NOT NULL,
    `product_stock` INT(11),
    `cart_user_id` BIGINT(20),
    `order_id` BIGINT(20),
    CONSTRAINT `product_in_order_pkey` PRIMARY KEY (`id`),
    CONSTRAINT `fkt0sfj3ffasrift1c4lv3ra85e` FOREIGN KEY (`order_id`)
        REFERENCES `ShopForHome`.`order_main` (`order_id`) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT `product_cart_fkey` FOREIGN KEY (`cart_user_id`)
        REFERENCES `ShopForHome`.`cart` (`user_id`) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT `product_in_order_count_check` CHECK (count >= 1),
    CONSTRAINT `product_in_order_product_stock_check` CHECK (product_stock >= 0)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table: `ShopForHome`.`product_info`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `ShopForHome`.`product_info`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`product_info`
(
    `product_id` VARCHAR(255)  NOT NULL,
    `category_type` INT(11) DEFAULT 0,
    `create_time` DATETIME(6),
    `product_description` VARCHAR(255) ,
    `product_icon` VARCHAR(255) ,
    `product_name` VARCHAR(255)  NOT NULL,
    `product_price` DECIMAL(19,2) NOT NULL,
    `product_status` INT(11) DEFAULT 0,
    `product_stock` INT(11) NOT NULL,
    `update_time` DATETIME(6),
    CONSTRAINT `product_info_pkey` PRIMARY KEY (`product_id`),
    CONSTRAINT `product_info_product_stock_check` CHECK (product_stock >= 0)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table: `ShopForHome`.`users`
-- -----------------------------------------------------

-- DROP TABLE IF EXISTS `ShopForHome`.`users`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`users`
(
    `id` BIGINT(20) NOT NULL auto_increment,
    `active` boolean NOT NULL,
    `address` VARCHAR(255) ,
    `email` VARCHAR(255) ,
    `name` VARCHAR(255) ,
    `password` VARCHAR(255) ,
    `phone` VARCHAR(255) ,
    `role` VARCHAR(255) ,
    CONSTRAINT `users_pkey` PRIMARY KEY (`id`),
    CONSTRAINT `uk_sx468g52bpetvlad2j9y0lptc` UNIQUE (`email`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;

-- -----------------------------------------------------
-- Table: ShopForHome.wishlist
-- -----------------------------------------------------

-- DROP TABLE IF EXISTS `ShopForHome`.`wishlist`;

CREATE TABLE IF NOT EXISTS `ShopForHome`.`wishlist`
(
    `id` BIGINT(20) NOT NULL,
    `created_date` DATETIME(6),
    `user_id` BIGINT(20),
    `product_id` VARCHAR(255) ,
    CONSTRAINT `wishlist_pkey` PRIMARY KEY (`id`),
    CONSTRAINT `product_wish_fkey` FOREIGN KEY (`product_id`)
        REFERENCES `ShopForHome`.`product_info` (`product_id`) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT `user_wish_Fkey` FOREIGN KEY (`user_id`)
        REFERENCES `ShopForHome`.`users` (`id`) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Categories
-- -----------------------------------------------------

INSERT INTO `ShopForHome`.`product_category` VALUES (2147483641, 'Books', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO `ShopForHome`.`product_category` VALUES (2147483642, 'Coffee Mugs', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO `ShopForHome`.`product_category` VALUES (2147483643, 'Mouse Pads', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO `ShopForHome`.`product_category` VALUES (2147483644, 'Luggage Tags', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


-- -----------------------------------------------------
-- Books
-- -----------------------------------------------------

INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1000', 'Crash Course in Python', 'Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1000.png', 0, 100, 14.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1001', 'Become a Guru in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1001.png', 0, 100, 20.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1002', 'Exploring Vue.js', 'Learn Vue.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1002.png', 0, 100, 14.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1003', 'Advanced Techniques in Big Data', 'Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1003.png', 0, 100, 13.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1004', 'Crash Course in Big Data', 'Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1004.png', 0, 100, 18.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1005', 'JavaScript Cookbook', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1005.png', 0, 100, 23.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1006', 'Beginners Guide to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1006.png', 0, 100, 14.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1007', 'Advanced Techniques in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1007.png', 0, 100, 16.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1008', 'Introduction to Spring Boot', 'Learn Spring Boot at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1008.png', 0, 100, 25.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1009', 'Become a Guru in React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1009.png', 0, 100, 23.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1010', 'Beginners Guide to Data Science', 'Learn Data Science at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1010.png', 0, 100, 24.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1011', 'Advanced Techniques in Java', 'Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1011.png', 0, 100, 19.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1012', 'Exploring DevOps', 'Learn DevOps at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1012.png', 0, 100, 24.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1013', 'The Expert Guide to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1013.png', 0, 100, 19.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1014', 'Introduction to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1014.png', 0, 100, 22.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1015', 'The Expert Guide to JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1015.png', 0, 100, 22.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1016', 'Exploring React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1016.png', 0, 100, 27.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1017', 'Advanced Techniques in React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1017.png', 0, 100, 13.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1018', 'Introduction to C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1018.png', 0, 100, 26.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1019', 'Crash Course in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1019.png', 0, 100, 13.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1020', 'Introduction to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1020.png', 0, 100, 19.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1021', 'Become a Guru in Java', 'Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1021.png', 0, 100, 18.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1022', 'Introduction to Python', 'Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1022.png', 0, 100, 26.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1023', 'Advanced Techniques in C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1023.png', 0, 100, 22.99, 0, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('BOOK-TECH-1024', 'The Expert Guide to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1024.png', 0, 100, 16.99, 0, NOW());


-- -----------------------------------------------------
-- Coffee Mugs
-- -----------------------------------------------------
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1000', 'Coffee Mug - Express', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1000.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1001', 'Coffee Mug - Cherokee', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1001.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1002', 'Coffee Mug - Sweeper', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1002.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1003', 'Coffee Mug - Aspire', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1003.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1004', 'Coffee Mug - Dorian', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1004.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1005', 'Coffee Mug - Columbia', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1005.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1006', 'Coffee Mug - Worthing', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1006.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1007', 'Coffee Mug - Oak Cliff', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1007.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1008', 'Coffee Mug - Tachyon', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1008.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1009', 'Coffee Mug - Pan', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1009.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1010', 'Coffee Mug - Phase', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1010.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1011', 'Coffee Mug - Falling', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1011.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1012', 'Coffee Mug - Wispy', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1012.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1013', 'Coffee Mug - Arlington', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1013.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1014', 'Coffee Mug - Gazing', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1014.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1015', 'Coffee Mug - Azura', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1015.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1016', 'Coffee Mug - Quantum Leap', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1016.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1017', 'Coffee Mug - Light Years', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1017.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1018', 'Coffee Mug - Taylor', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1018.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1019', 'Coffee Mug - Gracia', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1019.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1020', 'Coffee Mug - Relax', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1020.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1021', 'Coffee Mug - Windermere', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1021.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1022', 'Coffee Mug - Prancer', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1022.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1023', 'Coffee Mug - Recursion', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1023.png', 0, 100, 18.99, 1, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('COFFEEMUG-1024', 'Coffee Mug - Treasure', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 'assets/images/products/coffeemugs/coffeemug-luv2code-1024.png', 0, 100, 18.99, 1, NOW());

-- -----------------------------------------------------
-- Mouse Pads
-- -----------------------------------------------------
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1000', 'Mouse Pad - Express', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1000.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1001', 'Mouse Pad - Cherokee', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1001.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1002', 'Mouse Pad - Sweeper', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1002.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1003', 'Mouse Pad - Aspire', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1003.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1004', 'Mouse Pad - Dorian', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1004.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1005', 'Mouse Pad - Columbia', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1005.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1006', 'Mouse Pad - Worthing', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1006.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1007', 'Mouse Pad - Oak Cliff', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1007.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1008', 'Mouse Pad - Tachyon', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1008.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1009', 'Mouse Pad - Pan', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1009.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1010', 'Mouse Pad - Phase', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1010.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1011', 'Mouse Pad - Falling', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1011.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1012', 'Mouse Pad - Wispy', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1012.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1013', 'Mouse Pad - Arlington', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1013.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1014', 'Mouse Pad - Gazing', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1014.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1015', 'Mouse Pad - Azura', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1015.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1016', 'Mouse Pad - Quantum Leap', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1016.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1017', 'Mouse Pad - Light Years', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1017.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1018', 'Mouse Pad - Taylor', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1018.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1019', 'Mouse Pad - Gracia', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1019.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1020', 'Mouse Pad - Relax', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1020.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1021', 'Mouse Pad - Windermere', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1021.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1022', 'Mouse Pad - Prancer', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1022.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1023', 'Mouse Pad - Recursion', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1023.png', 0, 100, 17.99, 2, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('MOUSEPAD-1024', 'Mouse Pad - Treasure', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 'assets/images/products/mousepads/mousepad-luv2code-1024.png', 0, 100, 17.99, 2, NOW());

-- -----------------------------------------------------
-- Luggage Tags
-- -----------------------------------------------------
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1000', 'Luggage Tag - Cherish', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1000.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1001', 'Luggage Tag - Adventure', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1001.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1002', 'Luggage Tag - Skyline', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1002.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1003', 'Luggage Tag - River', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1003.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1004', 'Luggage Tag - Trail Steps', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1004.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1005', 'Luggage Tag - Blooming', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1005.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1006', 'Luggage Tag - Park', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1006.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1007', 'Luggage Tag - Beauty', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1007.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1008', 'Luggage Tag - Water Fall', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1008.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1009', 'Luggage Tag - Trail', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1009.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1010', 'Luggage Tag - Skyscraper', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1010.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1011', 'Luggage Tag - Leaf', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1011.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1012', 'Luggage Tag - Jungle', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1012.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1013', 'Luggage Tag - Shoreline', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1013.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1014', 'Luggage Tag - Blossom', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1014.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1015', 'Luggage Tag - Lock', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1015.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1016', 'Luggage Tag - Cafe', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1016.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1017', 'Luggage Tag - Darling', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1017.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1018', 'Luggage Tag - Full Stack', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1018.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1019', 'Luggage Tag - Courtyard', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1019.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1020', 'Luggage Tag - Coaster', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1020.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1021', 'Luggage Tag - Bridge', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1021.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1022', 'Luggage Tag - Sunset', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1022.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1023', 'Luggage Tag - Flames', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1023.png', 0, 100, 16.99, 3, NOW());
INSERT INTO product_info (product_id, product_name, product_description, product_icon, product_status, product_stock, product_price, category_type,create_time) VALUES ('LUGGAGETAG-1024', 'Luggage Tag - Countryside', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 'assets/images/products/luggagetags/luggagetag-luv2code-1024.png',0, 100, 16.99, 3, NOW());

-- -----------------------------------------------------
-- Users
-- -----------------------------------------------------

INSERT INTO `ShopForHome`.`users` VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@gmail.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
