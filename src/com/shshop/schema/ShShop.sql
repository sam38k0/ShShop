 -- ShShop ----------------------------------------------------------------------------------

SET NAMES 'utf8';
DROP DATABASE IF EXISTS `ShShop`;
CREATE DATABASE IF NOT EXISTS `ShShop` 
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ShShop`;


 -- cr_user ----------------------------------------------------------------------------------

CREATE TABLE `cr_user` (
	`id_user`                 SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_user
	`name`                    VARCHAR(50)  NULL,    -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`gender`                  TINYINT(1)   NULL,    -- ï¿½ï¿½ï¿½ï¿½
	`ktalk_id`                VARCHAR(50)  NULL,    -- Ä«Ä«ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìµï¿½ï¿½
	`email`                   VARCHAR(128) NOT NULL,-- ï¿½Ì¸ï¿½ï¿½ï¿½ï¿½Ö¼ï¿½
	`phone`                   VARCHAR(30)  NULL,    -- ï¿½Úµï¿½ï¿½ï¿½ï¿½ï¿½È£
	`password`                VARCHAR(32)  NOT NULL,-- ï¿½Ð½ï¿½ï¿½ï¿½ï¿½ï¿½
	`birthday`                DATETIME     NULL,    -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`bio`					  TEXT		   NULL,	-- ï¿½Ú±ï¿½Ò°ï¿½
	`is_deleted`              TINYINT(1)   NULL,    -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 
	`is_guest`                TINYINT(1)   NULL,    -- ï¿½Õ´ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`is_producer`             TINYINT(1)   NULL,    -- ï¿½Ç¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
    `bank_name`				  VARCHAR(128) NULL,	-- ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½
    `bank_num`				  VARCHAR(128) NULL,	-- ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½Â¹ï¿½È£
	`last_password_generated` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½æ³¯Â¥
	`date_created`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, 								-- ï¿½ï¿½ï¿½Ô³ï¿½Â¥
	`date_updated`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½æ³¯Â¥

	CONSTRAINT `PK_cr_user_id_user` 
		PRIMARY KEY (`id_user`)
);

CREATE INDEX `PK_cr_user_email`ON `cr_user` (`email` ASC);

-- address ----------------------------------------------------------------------------------

DROP TABLE `cr_address`;
CREATE TABLE `cr_address` (
	`id_address` SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_address
	`id_user`    SMALLINT     UNSIGNED NOT NULL,     -- id_user
	`bagic_add`       VARCHAR(64)  NULL,     -- ì£¼ì†Œ
	`detail_add`        VARCHAR(255) NULL,      -- ìƒì„¸ì£¼ì†Œ
    CONSTRAINT `PK_cr_address` -- cr_address ê¸°ë³¸í‚¤
		PRIMARY KEY (`id_address`),
	CONSTRAINT `FK_cr_user_TO_cr_address` -- cr_user -> cr_address
		FOREIGN KEY (`id_user`)
		REFERENCES `cr_user` (`id_user`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

-- ps_category ----------------------------------------------------------------------------------

CREATE TABLE `ps_category` (
	`id_category`        SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_category
	`id_category_parent` SMALLINT     UNSIGNED NULL DEFAULT NULL,     	-- id_category_parent
	`name`               VARCHAR(50)  NOT NULL, -- Ä«ï¿½×°ï¿½ï¿½ï¿½
	`description`        TEXT         NOT NULL, -- Ä«ï¿½×°ï¿½ ï¿½ï¿½ï¿½ï¿½
	`link`               VARCHAR(255) NULL,     -- Ä«ï¿½×°ï¿½ ï¿½âº»ï¿½ï¿½Å©
	`is_root_category`   TINYINT(1)   NOT NULL, -- ï¿½ï¿½Æ®Ä«ï¿½×°ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`date_created`       DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP,   				  -- Ä«ï¿½×°ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Â¥
	`date_updated`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Ä«ï¿½×°ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Æ®ï¿½ï¿½ ï¿½ï¿½Â¥
    
     CONSTRAINT `PK_ps_category_id_category` 
		PRIMARY KEY (`id_category`),
	 CONSTRAINT `FK_ps_category_parent` 
		FOREIGN KEY (`id_category_parent`)
		REFERENCES `ps_category`(`id_category`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE INDEX `PK_ps_category_name` ON `ps_category` (`name` ASC);

-- ps_product ----------------------------------------------------------------------------------

CREATE TABLE `ps_product` (
	`id_product`      SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_product
	`id_user`         SMALLINT     UNSIGNED NOT NULL,     			 -- id_user
	`name`            VARCHAR(50)  NOT NULL, -- ï¿½ï¿½Ç°ï¿½Ì¸ï¿½
	`price`           INTEGER      NOT NULL, -- ï¿½ï¿½Ç°ï¿½ï¿½ï¿½ï¿½
	`stock`           INTEGER      NOT NULL, -- ï¿½ï¿½ï¿½ï¿½
	`translation`	  TINYINT(2)   NOT NULL, -- ï¿½Å·ï¿½ï¿½ï¿½ï¿½ ( 1:ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ , 2:ï¿½Ã¹ï¿½, ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ß°ï¿½ )
    `connection`	  SMALLINT     NOT NULL, -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ (ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½È­,SMS,Ä«ï¿½ï¿½,ï¿½Ì¸ï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½ï¿½,Ã¤ï¿½ï¿½,ï¿½ï¿½ï¿½)
	`on_sale`         TINYINT(1)   NOT NULL, -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`on_open`         TINYINT(1)   NOT NULL, -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	`tag`             VARCHAR(128) NULL,     -- ï¿½Â±ï¿½
	`out_of_stock`    TINYINT(1)   NOT NULL, -- ï¿½ï¿½Ç°ï¿½ï¿½ ï¿½ï¿½ ï¿½È·È´ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
	`description`     TEXT         NOT NULL, -- ï¿½ï¿½Ç°ï¿½ï¿½ï¿½ï¿½
	`searching_count` INTEGER      NOT NULL, -- ï¿½ï¿½Æ®ï¿½ï¿½
	`date_created`    DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP, 					-- ï¿½ï¿½Ç°ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Â¥
	`date_updated`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- ï¿½ï¿½Ç°ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Â¥
    
    CONSTRAINT `PK_ps_product_id_product` 
		PRIMARY KEY (`id_product`),
	CONSTRAINT `FK_cr_user_TO_ps_product` 
		FOREIGN KEY (`id_user`)
		REFERENCES `cr_user`(`id_user`)
		ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

CREATE INDEX `PK_ps_product_name`ON `ps_product` (`name` ASC);

 
-- ps_product_category ----------------------------------------------------------------------------------
 
CREATE TABLE `ps_product_category` (
	`id_product_category` SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, 
	`id_category` SMALLINT UNSIGNED NOT NULL, -- id_category
	`id_product`  SMALLINT UNSIGNED NOT NULL, -- id_product
 
      CONSTRAINT `PK_ps_product_category_id_product_category` 
		PRIMARY KEY (`id_product_category`),
	-- ps_category -> ps_product_category
	CONSTRAINT `FK_ps_category_TO_ps_product_category` 
		FOREIGN KEY (`id_category`)
		REFERENCES `ps_category` (`id_category`)
		ON DELETE CASCADE,
     
	 -- ps_product -> ps_product_category
	CONSTRAINT `FK_ps_product_TO_ps_product_category`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` ( `id_product` )
		ON DELETE CASCADE
);
 
 
-- ps_option ---------------------------------------------------------------------------------------

CREATE TABLE `ps_option` (
	`id_option`             SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 	-- id_option
	`id_option_type_parent` SMALLINT UNSIGNED NULL DEFAULT NULL,     	-- id_option_parent
	`option_name`           VARCHAR(50) NOT NULL,     -- ï¿½ï¿½ï¿½ï¿½ ï¿½É¼ï¿½ï¿½Ì¸ï¿½
    
	 CONSTRAINT `PK_ps_option` 
		PRIMARY KEY (`id_option`),
        
	 CONSTRAINT `FK_ps_option_TO_ps_option` 
		FOREIGN KEY (`id_option_type_parent`)
		REFERENCES `ps_option`(`id_option`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE UNIQUE INDEX `PK_ps_option` ON `ps_option` ( 
	`id_option` ASC -- id_option
);


 -- ps_product_option ------------------------------------------------------------------------------

CREATE TABLE `ps_product_option` (
	`id_product` SMALLINT UNSIGNED NOT NULL, -- id_product
	`id_option`  SMALLINT UNSIGNED NOT NULL, -- id_option
    
	CONSTRAINT `PK_ps_product_option`
		PRIMARY KEY (`id_product`, `id_option`),

	CONSTRAINT `FK_ps_product_TO_ps_product_option`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE,
	
	CONSTRAINT `FK_ps_option_TO_ps_product_option` 
		FOREIGN KEY (`id_option`)
		REFERENCES `ps_option` (`id_option`)
		ON DELETE CASCADE
);

CREATE UNIQUE INDEX `PK_ps_product_option` ON `ps_product_option` (
	`id_product` ASC, -- id_product
	`id_option`  ASC  -- id_option
);


-- ps_image -------------------------------------------------------------------------------------
 
CREATE TABLE `ps_image` (
	`id_image`   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, -- id_image
	`id_product` SMALLINT UNSIGNED NOT NULL,     -- id_product
	`path`       VARCHAR(255) NOT NULL,     -- ï¿½ï¿½ï¿½Ï°ï¿½ï¿½
    
	CONSTRAINT `PK_ps_image` 
		PRIMARY KEY ( `id_image` ),
    
	CONSTRAINT `FK_ps_product_TO_ps_image`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

<<<<<<< HEAD
 -- Insert User ----------------------------------------------------------------------------------
 
INSERT INTO `cr_user` 
(`email`, `password`) 
VALUES 
('name1@gmail.com', '1111'),
('name2@gmail.com', '2222'),
('name3@gmail.com', '3333'),
('name4@gmail.com', '4444'),
('name4@gmail.com', '5555'),
('name4@gmail.com', '6666'),
('name4@gmail.com', '7777'),
('name4@gmail.com', '8888'),
('name4@gmail.com', '9999');

 -- Insert Category ----------------------------------------------------------------------------------
 
INSERT INTO `ps_category` 
(`id_category_parent`, `name`, `description`, `link`, `is_root_category`)
VALUES 
(null, 'ï¿½ï¿½ï¿½ï¿½ï¿½Ç·ï¿½', 'category1_desc', 'category1_link', true),
(null, 'ï¿½ï¿½ï¿½ï¿½ï¿½Ç·ï¿½', 'category2_desc', 'category2_link', true),
(null, 'ï¿½ï¿½È­', 'category3_desc', 'category3_link', true),
(null, 'ï¿½ï¿½Æ¼', 'category4_desc', 'category4_link', true),
(null, 'ï¿½ï¿½ï¿½,ï¿½Æµï¿½', 'category5_desc', 'category5_link', true),
(null, 'ï¿½ï¿½ï¿½ï¿½', 'category6_desc', 'category6_link', true),
(null, 'ï¿½ï¿½ï¿½ï¿½ï¿½', 'category7_desc', 'category7_link', true),
(null, 'ï¿½ï¿½ï¿½ï¿½', 'category8_desc', 'category8_link', true),
(null, 'ï¿½Úµï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category9_desc', 'category9_link', true), 
(1, 'ï¿½ï¿½ï¿½ï¿½Æ¼ï¿½ï¿½ï¿½ï¿½', 'category11_desc', 'category11_link', true),
(1, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Æ®ï¿½ï¿½', 'category12_desc', 'category12_link', true),
(1, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category13_desc', 'category13_link', true),
(1, 'ï¿½ï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½ì½º', 'category14_desc', 'category14_link', true),
(1, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category15_desc', 'category15_link', true),
(2, 'ï¿½ï¿½ï¿½ï¿½Æ¼ï¿½ï¿½ï¿½ï¿½', 'category21_desc', 'category21_link', true),
(2, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Æ®ï¿½ï¿½', 'category22_desc', 'category22_link', true), 
(2, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category21_desc', 'category21_link', true),
(2, 'ï¿½ï¿½ï¿½ï¿½ï¿½Ó¿ï¿½', 'category22_desc', 'category22_link', true), 
(3, 'ï¿½ï¿½ï¿½ï¿½', 'category31_desc', 'category31_link', true),
(3, 'ï¿½ï¿½ï¿½ï¿½,ï¿½ï¿½Æ®', 'category32_desc', 'category32_link', true),
(3, 'ï¿½ï¿½ï¿½ï¿½,ï¿½È°ï¿½', 'category33_desc', 'category33_link', true),
(3, 'ï¿½Ã°ï¿½,ï¿½ï¿½ï¿½ï¿½', 'category34_desc', 'category34_link', true),
(3, 'ï¿½ï¿½Å¸ï¿½ï¿½È­', 'category35_desc', 'category35_link', true),
(4, 'ï¿½ï¿½ï¿½ï¿½È­ï¿½ï¿½Ç°', 'category41_desc', 'category41_link', true),
(4, 'ï¿½ï¿½ï¿½ï¿½Å©ï¿½ï¿½', 'category42_desc', 'category42_link', true),
(4, 'ï¿½ï¿½ï¿½,ï¿½Ùµï¿½ï¿½É¾ï¿½', 'category43_desc', 'category43_link', true),
(4, 'ï¿½ï¿½ï¿½ï¿½È­ï¿½ï¿½Ç°', 'category44_desc', 'category44_link', true),
(4, 'ï¿½ï¿½ï¿½,ï¿½Æ·Î¸ï¿½', 'category45_desc', 'category45_link', true),
(5, 'ï¿½Å»ï¿½ï¿½ï¿½ï¿½Ç·ï¿½', 'category51_desc', 'category51_link', true),
(5, 'ï¿½ï¿½ï¿½ï¿½ï¿½Ç·ï¿½', 'category52_desc', 'category52_link', true),
(5, 'ï¿½ï¿½ï¿½Æ»ï¿½È°ï¿½ï¿½Ç°', 'category53_desc', 'category53_link', true),
(5, 'ï¿½ï¿½ï¿½Æµï¿½ï¿½ï¿½', 'category54_desc', 'category54_link', true),
(5, 'ï¿½Æµï¿½ï¿½Ï±ï¿½', 'category55_desc', 'category55_link', true),
(6, 'TV', 'category61_desc', 'category61_link', true),
(6, 'ï¿½ï¿½ï¿½ï¿½ï¿½', 'category62_desc', 'category62_link', true),
(6, 'ï¿½ï¿½Å¹ï¿½ï¿½', 'category63_desc', 'category63_link', true),
(6, 'Ã»ï¿½Ò±ï¿½', 'category64_desc', 'category64_link', true),
(6, 'ï¿½ï¿½Å¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ç°', 'category65_desc', 'category65_link', true),
(7, 'SKT', 'category71_desc', 'category71_link', true),
(7, 'KT', 'category72_desc', 'category72_link', true),
(7, 'LGU+', 'category73_desc', 'category73_link', true),
(7, 'ï¿½Þ´ï¿½ï¿½ï¿½ï¿½Öºï¿½ï¿½ï¿½ï¿½', 'category74_desc', 'category74_link', true),
(7, 'ï¿½Þ´ï¿½ï¿½ï¿½ï¿½×¼ï¿½ï¿½ï¿½ï¿½ï¿½', 'category75_desc', 'category75_link', true),
(8, 'ï¿½ï¿½ï¿½Ð±ï¿½ï¿½ï¿½', 'category81_desc', 'category81_link', true),
(8, 'ï¿½Ü±ï¿½ï¿½ï¿½,ï¿½Ð½ï¿½', 'category82_desc', 'category82_link', true),
(8, 'ï¿½Ò¼ï¿½,ï¿½ï¿½ï¿½ï¿½', 'category83_desc', 'category83_link', true),
(8, 'ï¿½æ¿µ,ï¿½ï¿½ï¿½ï¿½', 'category84_desc', 'category84_link', true),
(8, 'ï¿½Î¹ï¿½,ï¿½ï¿½È¸', 'category85_desc', 'category85_link', true),
(9, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category91_desc', 'category91_link', true),
(9, 'ï¿½ï¿½ï¿½ï¿½', 'category92_desc', 'category92_link', true),
(9, 'ï¿½ï¿½,ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'category93_desc', 'category93_link', true),
(9, 'ï¿½ï¿½ï¿½ï¿½,È­ï¿½ï¿½ï¿½ï¿½', 'category94_desc', 'category94_link', true),
(9, 'ï¿½Úµï¿½ï¿½ï¿½ï¿½ï¿½Ç°', 'category95_desc', 'category95_link', true);

=======
>>>>>>> fb078bf6686b0d858417cd12c00f79633d34939a

 -- Insert Product ----------------------------------------------------------------------------------

CREATE FUNCTION split_str(
  x TEXT,
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');

DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_product $$
CREATE PROCEDURE proc_insert_product (IN `proc_id_user`          SMALLINT,
									  IN `proc_id_category`      SMALLINT,
									  IN `proc_name`             VARCHAR(50),
									  IN `proc_price`            INTEGER,
									  IN `proc_stock`            INTEGER,
									  IN `proc_translation`	     TINYINT(2),
									  IN `proc_connection`	     SMALLINT,
									  IN `proc_on_sale`          TINYINT(1),
									  IN `proc_on_open`          TINYINT(1),
									  IN `proc_tag`              VARCHAR(128),
									  IN `proc_out_of_stock`     TINYINT(1),
									  IN `proc_description`      TEXT,
									  IN `proc_searching_count`  INTEGER,
                                      IN `proc_image_paths`      VARCHAR(1000)) 
BEGIN
	DECLARE indx INT Default 0 ;
	DECLARE str VARCHAR(255);
    DECLARE productId INT;
    
     -- Insert Product
    INSERT INTO `ps_product` 
	(`id_user`,`name`,`price`,`stock`,`translation`,`connection`,`on_sale`,`on_open`,`tag`,`out_of_stock`,`description`,`searching_count`)
	VALUES
	(`proc_id_user`,`proc_name`,`proc_price`,`proc_stock`,`proc_translation`,`proc_connection`,`proc_on_sale`,`proc_on_open`,`proc_tag`,`proc_out_of_stock`,`proc_description`,`proc_searching_count`);
    
    -- Insert prodcut category
    SET productId = LAST_INSERT_ID();
    
    INSERT INTO `ps_product_category` 
	(`id_category`, `id_product`)
	VALUES 
	(`proc_id_category`, productId);
    
    -- Insert Images 
	simpleLoop: LOOP  
         SET indx=indx+1;
         SET str = split_str(`proc_image_paths`,",",indx);
        IF str='' OR str=null THEN
            LEAVE simpleLoop;
         END IF; 
         INSERT INTO `ps_image` (`id_product`, `path`) VALUES (productId, str);
  	  END LOOP simpleLoop;
 
END $$
DELIMITER ;




/* EXAMPLE -----------------------------------------------------------------------------

 BEGIN;
 
INSERT INTO `cr_user` 
(`email`, `password`, `ktalk_id`, `phone`) 
VALUES 
('name1@gmail.com', '1111', 'ktalk1', '111-111-1111'),
('name2@gmail.com', '2222', 'ktalk2', '222-222-2222'),
('name3@gmail.com', '3333', 'ktalk3', '333-333-3333'),
('name4@gmail.com', '4444', 'ktalk4', '444-444-4444'),
('name4@gmail.com', '5555', 'ktalk5', '555-555-5555'),
('name4@gmail.com', '6666', 'ktalk6', '666-666-6666'),
('name4@gmail.com', '7777', 'ktalk7', '777-777-7777'),
('name4@gmail.com', '8888', 'ktalk8', '888-888-8888'),
('name4@gmail.com', '9999', 'ktalk9', '999-999-9999');
 
INSERT INTO `ps_category` 
(`id_category_parent`, `name`, `description`, `link`, `is_root_category`)
VALUES 
(null, '¿©¼ºÀÇ·ù', 'category1_desc', 'category1_link', true),
(null, '³²¼ºÀÇ·ù', 'category2_desc', 'category2_link', true),
(null, 'ÀâÈ­', 'category3_desc', 'category3_link', true),
(null, 'ºäÆ¼', 'category4_desc', 'category4_link', true),
(null, 'Ãâ»ê,¾Æµ¿', 'category5_desc', 'category5_link', true),
(null, '°¡Àü', 'category6_desc', 'category6_link', true),
(null, '¸ð¹ÙÀÏ', 'category7_desc', 'category7_link', true),
(null, 'µµ¼­', 'category8_desc', 'category8_link', true),
(null, 'ÀÚµ¿Â÷,¿ÀÅä¹ÙÀÌ', 'category9_desc', 'category9_link', true), 
(1, '¿©¼ºÆ¼¼ÅÃ÷', 'category11_desc', 'category11_link', true),
(1, '¿©¼º´ÏÆ®·ù', 'category12_desc', 'category12_link', true),
(1, '¿©¼ºÁ¶³¢·ù', 'category13_desc', 'category13_link', true),
(1, '³²¹æ,ºí¶ó¿ì½º', 'category14_desc', 'category14_link', true),
(1, '¿©¼º¹ÙÁö·ù', 'category15_desc', 'category15_link', true),
(2, '³²¼ºÆ¼¼ÅÃ÷', 'category21_desc', 'category21_link', true),
(2, '³²¼º´ÏÆ®·ù', 'category22_desc', 'category22_link', true), 
(2, '³²¼ºÁ¤Àå', 'category21_desc', 'category21_link', true),
(2, '³²¼º¼Ó¿Ê', 'category22_desc', 'category22_link', true), 
(3, '°¡¹æ', 'category31_desc', 'category31_link', true),
(3, 'Áö°©,º§Æ®', 'category32_desc', 'category32_link', true),
(3, '¸ðÀÚ,¾È°æ', 'category33_desc', 'category33_link', true),
(3, '½Ã°è,º¸¼®', 'category34_desc', 'category34_link', true),
(3, '±âÅ¸ÀâÈ­', 'category35_desc', 'category35_link', true),
(4, '¿©¼ºÈ­ÀåÇ°', 'category41_desc', 'category41_link', true),
(4, '¸ÞÀÌÅ©¾÷', 'category42_desc', 'category42_link', true),
(4, 'Çì¾î,¹ÙµðÄÉ¾î', 'category43_desc', 'category43_link', true),
(4, '³²¼ºÈ­ÀåÇ°', 'category44_desc', 'category44_link', true),
(4, 'Çâ¼ö,¾Æ·Î¸¶', 'category45_desc', 'category45_link', true),
(5, '½Å»ý¾ÆÀÇ·ù', 'category51_desc', 'category51_link', true),
(5, 'À¯¾ÆÀÇ·ù', 'category52_desc', 'category52_link', true),
(5, 'À¯¾Æ»ýÈ°¿ëÇ°', 'category53_desc', 'category53_link', true),
(5, 'À¯¾Æµµ¼­', 'category54_desc', 'category54_link', true),
(5, '¾Æµ¿¿Ï±¸', 'category55_desc', 'category55_link', true),
(6, 'TV', 'category61_desc', 'category61_link', true),
(6, '³ÃÀå°í', 'category62_desc', 'category62_link', true),
(6, '¼¼Å¹±â', 'category63_desc', 'category63_link', true),
(6, 'Ã»¼Ò±â', 'category64_desc', 'category64_link', true),
(6, '±âÅ¸°¡ÀüÁ¦Ç°', 'category65_desc', 'category65_link', true),
(7, 'SKT', 'category71_desc', 'category71_link', true),
(7, 'KT', 'category72_desc', 'category72_link', true),
(7, 'LGU+', 'category73_desc', 'category73_link', true),
(7, 'ÈÞ´ëÆùÁÖº¯±â±â', 'category74_desc', 'category74_link', true),
(7, 'ÈÞ´ëÆù¾×¼¼¼­¸®', 'category75_desc', 'category75_link', true),
(8, '´ëÇÐ±³Á¦', 'category81_desc', 'category81_link', true),
(8, '¿Ü±¹¾î,ÇÐ½À', 'category82_desc', 'category82_link', true),
(8, '¼Ò¼³,¹®ÇÐ', 'category83_desc', 'category83_link', true),
(8, '°æ¿µ,°æÁ¦', 'category84_desc', 'category84_link', true),
(8, 'ÀÎ¹®,»çÈ¸', 'category85_desc', 'category85_link', true),
(9, '¼öÀÔÂ÷', 'category91_desc', 'category91_link', true),
(9, '°æÂ÷', 'category92_desc', 'category92_link', true),
(9, 'Áß,´ëÇüÂ÷', 'category93_desc', 'category93_link', true),
(9, '¹ö½º,È­¹°Â÷', 'category94_desc', 'category94_link', true),
(9, 'ÀÚµ¿Â÷¿ëÇ°', 'category95_desc', 'category95_link', true);

 CALL proc_insert_product (1, 1, 'product1', '10', '10',1, 1, true, true, 'tag1', false, 'description1',0,
'/content/image/product_image/sample1.jpg,/content/image/product_image/sample2.jpg,/content/image/product_image/sample3.jpg,/content/image/product_image/sample4.jpg');


 -- getUserCount
SELECT COUNT(`cr_user`.`id_user`) as count FROM `cr_user`;

-- getAllProducts
SELECT * FROM `ps_product` WHERE `ps_product`.`id_user`=1;

-- getUserByEmail
SELECT * FROM  `cr_user` WHERE `cr_user`.`email`='name1@gmail.com';

-- updateUser
UPDATE  `cr_user` SET `cr_user`.`name`='tttt' WHERE `cr_user`.`email`='name1@gmail.com';
 
-- getProductById
SELECT * FROM `ps_product` WHERE `id_product` = 1;

-- getProductCount
SELECT COUNT(`id_product`) as count FROM `ps_product`;

-- insertProduct
INSERT INTO  `ps_product` (`id_user`,`name`,`price`,`stock`,`on_sale`,`on_open`,`tag`,`out_of_stock`,`description`,`searching_count`)
VALUES (3, 'product6', '60', '60', true, true, 'tag7', false, 'description6',0);
        
-- getCategoryById
SELECT * FROM `ps_category` WHERE `id_category` = 1;

-- getChildrenCategories 
SELECT * FROM `ps_category` WHERE `id_category_parent`= 1;		

-- getRootCategories        
SELECT * FROM `ps_category` WHERE ISNULL(`id_category_parent`);

-- getAllProducts
SELECT p.*
FROM `ps_product` p
	INNER JOIN `ps_product_category` pc USING(`id_product`) 
	INNER JOIN `ps_category` c USING(`id_category`)
WHERE c.`id_category` = 1;
 
 -- getAllProducts
BEGIN;
SELECT * FROM `ps_category`;
SELECT * FROM `ps_product`;
SELECT COUNT(`id_category`) as count FROM `ps_category`;
SELECT COUNT(`id_category`) as count FROM `ps_product_category`;
DELETE FROM `ps_category` WHERE `id_category`= 1;
SELECT COUNT(`id_category`) as count FROM `ps_category`;
SELECT COUNT(`id_category`) as count FROM `ps_product_category`;
SELECT * FROM `ps_category`;
SELECT * FROM `ps_product_category`;


-- getProductOptions
SELECT o.*
FROM `ps_product` p
	INNER JOIN `ps_product_option` po USING(`id_product`) 
	INNER JOIN `ps_option` o USING(`id_option`)
WHERE p.`id_product` = 1;


SELECT * FROM `ps_image` WHERE `id_product`= 1;

ROLLBACK;

 -----------------------------------------------------------------------------*/
