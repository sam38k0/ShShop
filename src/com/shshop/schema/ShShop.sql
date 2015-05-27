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

CREATE INDEX `PK_ps_category_name`ON `ps_category` (`name` ASC);

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
	`id_category` SMALLINT UNSIGNED NOT NULL, -- id_category
	`id_product`  SMALLINT UNSIGNED NOT NULL, -- id_product
    
    -- compound key
	CONSTRAINT `PK_ps_product_category` 
		PRIMARY KEY (`id_category`, `id_product`),
        
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

CREATE UNIQUE INDEX `PK_ps_product_category`ON `ps_product_category` 
( 
	`id_category` ASC, -- id_category
	`id_product`  ASC  -- id_product
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

CREATE UNIQUE INDEX `PK_ps_image` ON `ps_image` (`id_image` ASC);


 -- Insert ----------------------------------------------------------------------------------
 
INSERT INTO `cr_user` 
(`email`, `password`) 
VALUES 
('name1@gmail.com', '1111'),
('name2@gmail.com', '2222'),
('name3@gmail.com', '3333'),
('name4@gmail.com', '4444');

 
INSERT INTO `ps_category` 
(`id_category_parent`, `name`, `description`, `link`, `is_root_category`)
VALUES 
(null, '�����Ƿ�', 'category1_desc', 'category1_link', true),
(null, '�����Ƿ�', 'category2_desc', 'category2_link', true),
(null, '��ȭ', 'category3_desc', 'category3_link', true),
(null, '��Ƽ', 'category4_desc', 'category4_link', true),
(null, '���,�Ƶ�', 'category5_desc', 'category5_link', true),
(null, '����', 'category6_desc', 'category6_link', true),
(null, '�����', 'category7_desc', 'category7_link', true),
(null, '����', 'category8_desc', 'category8_link', true),
(null, '�ڵ���,�������', 'category9_desc', 'category9_link', true), 
(1, '����Ƽ����', 'category11_desc', 'category11_link', true),
(1, '������Ʈ��', 'category12_desc', 'category12_link', true),
(1, '����������', 'category13_desc', 'category13_link', true),
(1, '����,���콺', 'category14_desc', 'category14_link', true),
(1, '����������', 'category15_desc', 'category15_link', true),
(1, '��ĿƮ,ġ��', 'category11_desc', 'category11_link', true),
(1, '��������', 'category12_desc', 'category12_link', true),
(1, '�ڵ�,�е�', 'category13_desc', 'category13_link', true),
(1, '���ǽ�,����', 'category14_desc', 'category14_link', true),
(1, '�����ӿ�', 'category15_desc', 'category15_link', true),
(2, '����Ƽ����', 'category21_desc', 'category21_link', true),
(2, '������Ʈ��', 'category22_desc', 'category22_link', true),
(2, '���������', 'category23_desc', 'category23_link', true),
(2, '����������', 'category24_desc', 'category24_link', true),
(2, '��������', 'category25_desc', 'category25_link', true),
(2, '��������', 'category21_desc', 'category21_link', true),
(2, '�����ӿ�', 'category22_desc', 'category22_link', true),
(2, '��Ÿ������', 'category23_desc', 'category23_link', true),
(2, '����Ʈ���̴׺�', 'category24_desc', 'category24_link', true), 
(3, '����', 'category31_desc', 'category31_link', true),
(3, '����,��Ʈ', 'category32_desc', 'category32_link', true),
(3, '����,�Ȱ�', 'category33_desc', 'category33_link', true),
(3, '�ð�,����', 'category34_desc', 'category34_link', true),
(3, '��Ÿ��ȭ', 'category35_desc', 'category35_link', true),
(4, '����ȭ��ǰ', 'category41_desc', 'category41_link', true),
(4, '����ũ��', 'category42_desc', 'category42_link', true),
(4, '���,�ٵ��ɾ�', 'category43_desc', 'category43_link', true),
(4, '����ȭ��ǰ', 'category44_desc', 'category44_link', true),
(4, '���,�Ʒθ�', 'category45_desc', 'category45_link', true),
(5, '�Ż����Ƿ�', 'category51_desc', 'category51_link', true),
(5, '�����Ƿ�', 'category52_desc', 'category52_link', true),
(5, '���ƻ�Ȱ��ǰ', 'category53_desc', 'category53_link', true),
(5, '���Ƶ���', 'category54_desc', 'category54_link', true),
(5, '�Ƶ��ϱ�', 'category55_desc', 'category55_link', true),
(6, 'TV', 'category61_desc', 'category61_link', true),
(6, '�����', 'category62_desc', 'category62_link', true),
(6, '��Ź��', 'category63_desc', 'category63_link', true),
(6, 'û�ұ�', 'category64_desc', 'category64_link', true),
(6, '��Ÿ������ǰ', 'category65_desc', 'category65_link', true),
(7, 'SKT', 'category71_desc', 'category71_link', true),
(7, 'KT', 'category72_desc', 'category72_link', true),
(7, 'LGU+', 'category73_desc', 'category73_link', true),
(7, '�޴����ֺ����', 'category74_desc', 'category74_link', true),
(7, '�޴����׼�����', 'category75_desc', 'category75_link', true),
(8, '���б���', 'category81_desc', 'category81_link', true),
(8, '�ܱ���,�н�', 'category82_desc', 'category82_link', true),
(8, '�Ҽ�,����', 'category83_desc', 'category83_link', true),
(8, '�濵,����', 'category84_desc', 'category84_link', true),
(8, '�ι�,��ȸ', 'category85_desc', 'category85_link', true),
(9, '������', 'category91_desc', 'category91_link', true),
(9, '����', 'category92_desc', 'category92_link', true),
(9, '��,������', 'category93_desc', 'category93_link', true),
(9, '����,ȭ����', 'category94_desc', 'category94_link', true),
(9, '�ڵ�����ǰ', 'category95_desc', 'category95_link', true);
 
INSERT INTO `ps_product` 
(`id_user`,`name`,`price`,`stock`,`translation`,`connection`,`on_sale`,`on_open`,`tag`,`out_of_stock`,`description`,`searching_count`)
VALUES
(1, 'product1', '10', '10',1, 1, true, true, 'tag1', false, 'description1',0),
(1, 'product2', '20', '20',1, 3, true, true, 'tag2', false, 'description2',0),
(2, 'product3', '30', '30',1, 7, true, true, 'tag3', false, 'description3',0),
(2, 'product4', '40', '40',1, 15, true, true, 'tag4', false, 'description4',0),
(3, 'product5', '50', '50',1, 12, true, true, 'tag5', false, 'description5',0),
(3, 'product6', '60', '60',1, 204, true, true, 'tag6', false, 'description6',0);
 
 
INSERT INTO `ps_product_category` 
(`id_category`, `id_product`)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 1);


INSERT INTO `ps_option` (`id_option_type_parent`, `option_name`)
VALUES
-- root option
(null,'Option1'),
(null, 'Option2'),
(null, 'Option3'),
(null, 'Option4'),
(null, 'Option5'),
(null, 'Option6'),
-- child option
(1, 'Option11'),
(1, 'Option12'),
(1, 'Option13'),
(2, 'Option21'),
(2, 'Option22'),
(2, 'Option23'),
(3, 'Option31'),
(3, 'Option32'),
(3, 'Option33'),
(4, 'Option41'),
(4, 'Option42'),
(4, 'Option43'),
(5, 'Option51'),
(5, 'Option52'),
(5, 'Option53'),
(6, 'Option61'),
(6, 'Option62'),
(6, 'Option63');
  

INSERT INTO `ps_product_option` 
(`id_product`, `id_option`)
VALUES 
-- product 1
(1, 1),
(1, 2),
-- product 2
(2, 3),
(2, 4),
-- product 3
(3, 5),
(3, 6),
-- product 4
(4, 1),
(4, 2),
(4, 3),
-- product 5
(5, 2),
(5, 4),
(5, 6);


INSERT INTO `ps_image` (`id_product`, `path`)
VALUES
(1, '/content/image/product_image/sample1.jpg'),
(1, '/content/image/product_image/sample2.jpg'),
(1, '/content/image/product_image/sample3.jpg'),
(1, '/content/image/product_image/sample4.jpg'),
(2, '/content/image/product_image/sample1.jpg'),
(2, '/content/image/product_image/sample2.jpg'),
(2, '/content/image/product_image/sample3.jpg'),
(2, '/content/image/product_image/sample4.jpg'),
(3, '/content/image/product_image/sample1.jpg'),
(3, '/content/image/product_image/sample2.jpg'),
(3, '/content/image/product_image/sample3.jpg'),
(3, '/content/image/product_image/sample4.jpg'),
(4, '/content/image/product_image/sample1.jpg'),
(4, '/content/image/product_image/sample2.jpg'),
(4, '/content/image/product_image/sample3.jpg'),
(4, '/content/image/product_image/sample4.jpg');
 
 -- Confirm ----------------------------------------------------------------------------------
 BEGIN;
 
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