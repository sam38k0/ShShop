 -- ShShop ----------------------------------------------------------------------------------

SET NAMES 'utf8';
DROP DATABASE IF EXISTS `ShShop`;
CREATE DATABASE IF NOT EXISTS `ShShop` 
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ShShop`;


 -- cr_user ----------------------------------------------------------------------------------

CREATE TABLE `cr_user` (
	`id_user`                 SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_user
	`name`                    VARCHAR(50)  NULL,    -- 유저명
	`gender`                  TINYINT(1)   NULL,    -- 성별
	`ktalk_id`                VARCHAR(50)  NULL,    -- 카카오톡아이디명
	`email`                   VARCHAR(128) NOT NULL,-- 이메일주소
	`phone`                   VARCHAR(30)  NULL,    -- 핸드폰번호
	`password`                VARCHAR(32)  NOT NULL,-- 패스워드
	`birthday`                DATETIME     NULL,    -- 생년월일
	`bio`					  TEXT		   NULL,	-- 자기소개
	`is_deleted`              TINYINT(1)   NULL,    -- 계정삭제된 유저인지여부 
	`is_guest`                TINYINT(1)   NULL,    -- 손님유저인지여부
	`is_producer`             TINYINT(1)   NULL,    -- 판매자인지 여부
    `bank_name`				  VARCHAR(128) NULL,	-- 계정 인증용 은행명
    `bank_num`				  VARCHAR(128) NULL,	-- 계정 인증용 계좌번호
	`last_password_generated` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- 마지막으로 비번 변경날짜
	`date_created`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, 								-- 가입날짜
	`date_updated`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 	-- 정보변경날짜

	CONSTRAINT `PK_cr_user_id_user` 
		PRIMARY KEY (`id_user`)
);

CREATE INDEX `PK_cr_user_email`ON `cr_user` (`email` ASC);


-- ps_category ----------------------------------------------------------------------------------

CREATE TABLE `ps_category` (
	`id_category`        SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_category
	`id_category_parent` SMALLINT     UNSIGNED NULL DEFAULT NULL,     	-- id_category_parent
	`name`               VARCHAR(50)  NOT NULL, -- 카테고리명
	`description`        TEXT         NOT NULL, -- 카테고리 설명
	`link`               VARCHAR(255) NULL,     -- 카테고리 기본링크
	`is_root_category`   TINYINT(1)   NOT NULL, -- 루트카테고리인지여부
	`date_created`       DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP,   				  -- 카테고리 생성 날짜
	`date_updated`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 카테고리 업데이트된 날짜
    
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
	`name`            VARCHAR(50)  NOT NULL, -- 제품이름
	`price`           INTEGER      NOT NULL, -- 제품가격
	`stock`           INTEGER      NOT NULL, -- 제고량
	`translation`	  TINYINT(2)   NOT NULL, -- 거래방법 ( 1:안전결재 , 2:택배, 생기면 더 추가 )
    `connection`	  SMALLINT     NOT NULL, -- 희망연락방법 (직접통화,SMS,카톡,이메일,쪽지,채팅,댓글)
	`on_sale`         TINYINT(1)   NOT NULL, -- 세일중인지여부
	`on_open`         TINYINT(1)   NOT NULL, -- 공개설정
	`tag`             VARCHAR(128) NULL,     -- 태그
	`out_of_stock`    TINYINT(1)   NOT NULL, -- 상품이 다 팔렸는지 여부
	`description`     TEXT         NOT NULL, -- 상품설명
	`searching_count` INTEGER      NOT NULL, -- 히트수
	`date_created`    DATETIME     NOT NULL NOT NULL DEFAULT CURRENT_TIMESTAMP, 					-- 상품이 더해진 날짜
	`date_updated`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- 상품이 업뎃된 날짜
    
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
	`option_name`           VARCHAR(50) NOT NULL,     -- 현재 옵션이름
    
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
	`path`       VARCHAR(255) NOT NULL,     -- 파일경로
    
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
(null, '여성의류', 'category1_desc', 'category1_link', true),
(null, '남성의류', 'category2_desc', 'category2_link', true),
(null, '잡화', 'category3_desc', 'category3_link', true),
(null, '뷰티', 'category4_desc', 'category4_link', true),
(null, '출산,아동', 'category5_desc', 'category5_link', true),
(null, '가전', 'category6_desc', 'category6_link', true),
(null, '모바일', 'category7_desc', 'category7_link', true),
(null, '도서', 'category8_desc', 'category8_link', true),
(null, '자동차,오토바이', 'category9_desc', 'category9_link', true), 
(1, '여성티셔츠', 'category11_desc', 'category11_link', true),
(1, '여성니트류', 'category12_desc', 'category12_link', true),
(1, '여성조끼류', 'category13_desc', 'category13_link', true),
(1, '남방,블라우스', 'category14_desc', 'category14_link', true),
(1, '여성바지류', 'category15_desc', 'category15_link', true),
(1, '스커트,치마', 'category11_desc', 'category11_link', true),
(1, '여성자켓', 'category12_desc', 'category12_link', true),
(1, '코드,패딩', 'category13_desc', 'category13_link', true),
(1, '원피스,정장', 'category14_desc', 'category14_link', true),
(1, '여성속옷', 'category15_desc', 'category15_link', true),
(2, '남성티셔츠', 'category21_desc', 'category21_link', true),
(2, '남성니트류', 'category22_desc', 'category22_link', true),
(2, '남성남방류', 'category23_desc', 'category23_link', true),
(2, '남성바지류', 'category24_desc', 'category24_link', true),
(2, '남성자켓', 'category25_desc', 'category25_link', true),
(2, '남성정장', 'category21_desc', 'category21_link', true),
(2, '남성속옷', 'category22_desc', 'category22_link', true),
(2, '기타남성복', 'category23_desc', 'category23_link', true),
(2, '남성트레이닝복', 'category24_desc', 'category24_link', true), 
(3, '가방', 'category31_desc', 'category31_link', true),
(3, '지갑,벨트', 'category32_desc', 'category32_link', true),
(3, '모자,안경', 'category33_desc', 'category33_link', true),
(3, '시계,보석', 'category34_desc', 'category34_link', true),
(3, '기타잡화', 'category35_desc', 'category35_link', true),
(4, '여성화장품', 'category41_desc', 'category41_link', true),
(4, '메이크업', 'category42_desc', 'category42_link', true),
(4, '헤어,바디케어', 'category43_desc', 'category43_link', true),
(4, '남성화장품', 'category44_desc', 'category44_link', true),
(4, '향수,아로마', 'category45_desc', 'category45_link', true),
(5, '신생아의류', 'category51_desc', 'category51_link', true),
(5, '유아의류', 'category52_desc', 'category52_link', true),
(5, '유아생활용품', 'category53_desc', 'category53_link', true),
(5, '유아도서', 'category54_desc', 'category54_link', true),
(5, '아동완구', 'category55_desc', 'category55_link', true),
(6, 'TV', 'category61_desc', 'category61_link', true),
(6, '냉장고', 'category62_desc', 'category62_link', true),
(6, '세탁기', 'category63_desc', 'category63_link', true),
(6, '청소기', 'category64_desc', 'category64_link', true),
(6, '기타가전제품', 'category65_desc', 'category65_link', true),
(7, 'SKT', 'category71_desc', 'category71_link', true),
(7, 'KT', 'category72_desc', 'category72_link', true),
(7, 'LGU+', 'category73_desc', 'category73_link', true),
(7, '휴대폰주변기기', 'category74_desc', 'category74_link', true),
(7, '휴대폰액세서리', 'category75_desc', 'category75_link', true),
(8, '대학교제', 'category81_desc', 'category81_link', true),
(8, '외국어,학습', 'category82_desc', 'category82_link', true),
(8, '소설,문학', 'category83_desc', 'category83_link', true),
(8, '경영,경제', 'category84_desc', 'category84_link', true),
(8, '인문,사회', 'category85_desc', 'category85_link', true),
(9, '수입차', 'category91_desc', 'category91_link', true),
(9, '경차', 'category92_desc', 'category92_link', true),
(9, '중,대형차', 'category93_desc', 'category93_link', true),
(9, '버스,화물차', 'category94_desc', 'category94_link', true),
(9, '자동차용품', 'category95_desc', 'category95_link', true);
 
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