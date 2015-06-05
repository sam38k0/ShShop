 -- ShShop ----------------------------------------------------------------------------------

SET NAMES 'utf8';
DROP DATABASE IF EXISTS `ShShop`;
CREATE DATABASE IF NOT EXISTS `ShShop` 
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ShShop`;


 -- cr_user ----------------------------------------------------------------------------------

CREATE TABLE `cr_user` (
	`id_user`                 SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_user
	`name`                    VARCHAR(50)  NULL,    -- ������
	`gender`                  TINYINT(1)   NULL,    -- ����
	`ktalk_id`                VARCHAR(50)  NULL,    -- īī������̵��
	`email`                   VARCHAR(128) NOT NULL,-- �̸����ּ�
	`phone`                   VARCHAR(30)  NULL,    -- �ڵ�����ȣ
	`password`                VARCHAR(32)  NOT NULL,-- �н�����
	`birthday`                DATETIME     NULL,    -- �������
	`bio`					  TEXT		   NULL,	-- �ڱ�Ұ�
	`is_deleted`              TINYINT(1)   NULL,    -- ���������� ������������ 
	`is_guest`                TINYINT(1)   NULL,    -- �մ�������������
	`is_producer`             TINYINT(1)   NULL,    -- �Ǹ������� ����
    `bank_name`				  VARCHAR(128) NULL,	-- ���� ������ �����
    `bank_num`				  VARCHAR(128) NULL,	-- ���� ������ ���¹�ȣ
	`last_password_generated` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- ���������� ��� ���泯¥
	`date_created`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, 								-- ���Գ�¥
	`date_updated`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- �������泯¥

	CONSTRAINT `PK_cr_user_id_user` 
		PRIMARY KEY (`id_user`)
);

CREATE INDEX `PK_cr_user_email`ON `cr_user` (`email` ASC);


-- ps_category ----------------------------------------------------------------------------------

CREATE TABLE `ps_category` (
	`id_category`        SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_category
	`id_category_parent` SMALLINT     UNSIGNED NULL DEFAULT NULL,     	-- id_category_parent
	`name`               VARCHAR(50)  NOT NULL, -- ī�װ���
	`description`        TEXT         NOT NULL, -- ī�װ� ����
	`link`               VARCHAR(255) NULL,     -- ī�װ� �⺻��ũ
	`is_root_category`   TINYINT(1)   NOT NULL, -- ��Ʈī�װ���������
	`date_created`       DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP,   				  -- ī�װ� ���� ��¥
	`date_updated`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- ī�װ� ������Ʈ�� ��¥
    
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
	`name`            VARCHAR(50)  NOT NULL, -- ��ǰ�̸�
	`price`           INTEGER      NOT NULL, -- ��ǰ����
	`stock`           INTEGER      NOT NULL, -- ����
	`translation`	  TINYINT(2)   NOT NULL, -- �ŷ���� ( 1:�������� , 2:�ù�, ����� �� �߰� )
    `connection`	  SMALLINT     NOT NULL, -- ���������� (������ȭ,SMS,ī��,�̸���,����,ä��,���)
	`on_sale`         TINYINT(1)   NOT NULL, -- ��������������
	`on_open`         TINYINT(1)   NOT NULL, -- ��������
	`tag`             VARCHAR(128) NULL,     -- �±�
	`out_of_stock`    TINYINT(1)   NOT NULL, -- ��ǰ�� �� �ȷȴ��� ����
	`description`     TEXT         NOT NULL, -- ��ǰ����
	`searching_count` INTEGER      NOT NULL, -- ��Ʈ��
	`date_created`    DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP, 					-- ��ǰ�� ������ ��¥
	`date_updated`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- ��ǰ�� ������ ��¥
    
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
	`option_name`           VARCHAR(50) NOT NULL,     -- ���� �ɼ��̸�
    
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
	`path`       VARCHAR(255) NOT NULL,     -- ���ϰ��
    
	CONSTRAINT `PK_ps_image` 
		PRIMARY KEY ( `id_image` ),
    
	CONSTRAINT `FK_ps_product_TO_ps_image`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


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


 
 
/* -- Confirm ----------------------------------------------------------------------------------
 BEGIN;

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

-- getImage
SELECT * FROM `ps_image` WHERE `id_product`= 1;

 -- Search Product By Keyword
SELECT  * FROM `ps_product` as p WHERE p.`name` REGEXP '��' or 
									   p.`description` REGEXP '��' or 
									   p.`tag` REGEXP '��';
                                     
 -- Search Category Product
SELECT * FROM `ps_category` c 
		LEFT OUTER JOIN `ps_product_category` pc USING(`id_category`)
        LEFT OUTER JOIN `ps_product` p USING(`id_product`)
WHERE c.`name`= '�����Ƿ�';

ROLLBACK;

*/