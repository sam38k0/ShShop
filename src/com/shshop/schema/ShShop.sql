-- ShShop ----------------------------------------------------------------------------------

SET NAMES 'utf8';
DROP DATABASE IF EXISTS `ShShop`;
CREATE DATABASE IF NOT EXISTS `ShShop` 
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ShShop`;


 -- cr_user ----------------------------------------------------------------------------------

CREATE TABLE `cr_user` (
	`id_user`                 INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_user
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

-- address ----------------------------------------------------------------------------------

CREATE TABLE `cr_address` (
	`id_address` 		INTEGER   UNSIGNED NOT NULL AUTO_INCREMENT, -- id_address
	`id_parent_address` INTEGER  DEFAULT NULL, -- null 이면 지번, 아니면 지번 주소 id 를 가지는 도로명 주소
	`id_user`    		INTEGER   UNSIGNED NOT NULL, -- id_user
	`basic_add`        	VARCHAR(64) NOT NULL, -- 주소
	`detail_add`        VARCHAR(255) NOT NULL, -- 상세주소
	`post_num_header`   VARCHAR(3)   NOT NULL, -- 우편번호 앞 번호
	`post_num_tail`     VARCHAR(3)   NOT NULL, -- 우편번호 뒷 번호
	`name`              VARCHAR(50)  NOT NULL, -- 주소별명
    `phone_number`      VARCHAR(30)  NOT NULL, -- 핸드폰번호
	
    CONSTRAINT `PK_cr_address`
		PRIMARY KEY (`id_address`),
		
	CONSTRAINT `FK_cr_user_TO_cr_address`
		FOREIGN KEY (`id_user`)
		REFERENCES `cr_user` (`id_user`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


-- ps_category ----------------------------------------------------------------------------------

CREATE TABLE `ps_category` (
	`id_category`        INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_category
	`id_category_parent` INTEGER     UNSIGNED NULL DEFAULT NULL,     	-- id_category_parent
	`name`               VARCHAR(50)  NOT NULL, -- 카테고리명
	`date_created`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 카테고리 생성 날짜
	`date_updated`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 카테고리 업데이트된 날짜
    
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
	`id_product`      INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_product
	`id_user`         INTEGER     UNSIGNED NOT NULL,     			 -- id_user
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
	`date_created`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, 					-- 상품이 더해진 날짜
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
	`id_product_category` INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, 
	`id_category` INTEGER UNSIGNED NOT NULL, -- id_category
	`id_product`  INTEGER UNSIGNED NOT NULL, -- id_product
 
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
	`id_option`             INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 	-- id_option
	`id_option_type_parent` INTEGER UNSIGNED NULL DEFAULT NULL,     	-- id_option_parent
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
	`id_product` INTEGER UNSIGNED NOT NULL, -- id_product
	`id_option`  INTEGER UNSIGNED NOT NULL, -- id_option
    
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
	`id_image`   INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- id_image
	`id_product` INTEGER UNSIGNED NOT NULL,     -- id_product
	`path`       VARCHAR(255) NOT NULL,     -- 파일경로
    
	CONSTRAINT `PK_ps_image` 
		PRIMARY KEY ( `id_image` ),
    
	CONSTRAINT `FK_ps_product_TO_ps_image`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


-- or_order -------------------------------------------------------------------------------------

CREATE TABLE `or_order` (
	`id_order`        INTEGER 	UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_user`         INTEGER 	UNSIGNED NOT NULL,
	`id_product`      INTEGER 	UNSIGNED NOT NULL,
	`id_address`      INTEGER 	UNSIGNED NOT NULL,
	`amount`          INTEGER 	NULL,  -- 주문수량
	`cost`            INTEGER 	NULL,  -- 주문가격
	`delivery_cost`   INTEGER 	NULL,  -- 배송가격
	`order_request`   TEXT     	NULL,  -- 추가요청사항설명
	`date_created`    DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 주문 날짜
	`date_updated`    DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- 주문업뎃날짜
	
	CONSTRAINT `PK_or_order`
		PRIMARY KEY (`id_order`),
		
	CONSTRAINT `FK_cr_user_TO_or_order`
		FOREIGN KEY (`id_user`)
		REFERENCES `cr_user` ( `id_user`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
		
	CONSTRAINT `FK_ps_product_TO_or_order`
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
		
	CONSTRAINT `FK_cr_address_TO_or_order`
		FOREIGN KEY (`id_address`)
		REFERENCES `cr_address` (`id_address`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE `or_order_state` (
	`id_order`       INTEGER   UNSIGNED NOT NULL, -- id_order
	`virtual_order`  BOOLEAN  NOT NULL,     -- 가상주문(장바구니상태)
	`activated`      BOOLEAN  NOT NULL,     -- 주문활성화여부
	`paid`           BOOLEAN  NOT NULL,     -- 지불완료
	`sended_email`   BOOLEAN  NOT NULL,     -- 이메일보냄
	`shipped`        BOOLEAN  NOT NULL,     -- 배송중
	`delivered`      BOOLEAN  NOT NULL,     -- 배송완료
	`deleted`        BOOLEAN  NOT NULL,     -- 주문취소
	
	CONSTRAINT `PK_or_order_state`
		PRIMARY KEY (`id_order`),
		
	CONSTRAINT `FK_or_order_TO_or_order_state`
		FOREIGN KEY (`id_order`)
		REFERENCES `or_order` (`id_order`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- dt_board -------------------------------------------------------------------------------------

CREATE TABLE `dt_board` (
	`id_board` 	 INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_board
	`board_name`  VARCHAR(50)  NOT NULL,      -- 보드이름
    
	CONSTRAINT `PK_dt_board` 
		PRIMARY KEY ( `id_board` )
);

-- dt_post -------------------------------------------------------------------------------------

CREATE TABLE `dt_post` (
	`id_post`       	INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT, -- id_post
	`id_board`      	INTEGER 	 UNSIGNED NOT NULL, -- id_board
    `id_post_parent`    INTEGER     UNSIGNED DEFAULT NULL, -- 부모 코멘트 아이디
	`comment`       	VARCHAR(128) NOT NULL,     -- 코멘트
	`node_position` 	TINYINT(2)   NOT NULL,      -- 형제간의순서
    `date_created`    	DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 생성시간

	CONSTRAINT `PK_dt_post` 
		PRIMARY KEY ( `id_post` ),
    
	CONSTRAINT `FK_dt_board_TO_dt_post`
		FOREIGN KEY (`id_board`)
		REFERENCES `dt_board` (`id_board`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
 
-- dt_product_post -------------------------------------------------------------------------------------
 
CREATE TABLE `dt_product_post` (
	`id_proudct_post`  INTEGER     UNSIGNED NOT NULL AUTO_INCREMENT NOT NULL,  -- id_proudct_board
	`id_product`        INTEGER     UNSIGNED NOT NULL , -- id_product
	`id_post`           INTEGER     UNSIGNED NOT NULL , -- id_post
    `id_board`			INTEGER 	 UNSIGNED NOT NULL , -- id_board

	CONSTRAINT `PK_dt_product_post` 
		PRIMARY KEY (`id_proudct_post`),
        
	CONSTRAINT `FK_ps_product_TO_dt_product_post` 
		FOREIGN KEY (`id_product`)
		REFERENCES `ps_product` (`id_product`)
		ON DELETE CASCADE,
      
	CONSTRAINT `FK_dt_post_TO_dt_product_post`
		FOREIGN KEY (`id_post`)
		REFERENCES `dt_post` ( `id_post` )
		ON DELETE CASCADE,
        
	CONSTRAINT `FK_dt_board_TO_dt_product_post`
		FOREIGN KEY (`id_board`)
		REFERENCES `dt_board` ( `id_board` )
		ON DELETE CASCADE     
);


-- dt_user_post -------------------------------------------------------------------------------------

CREATE TABLE `dt_user_post` (
	`id_user_post`  INTEGER	UNSIGNED NOT NULL AUTO_INCREMENT NOT NULL,  -- id_user_board
	`id_post`      	INTEGER	UNSIGNED NOT NULL, -- id_post
	`id_user`       INTEGER	UNSIGNED NOT NULL, -- id_user
    `id_board`		INTEGER UNSIGNED NOT NULL , -- id_board
	
    CONSTRAINT `PK_dt_user_post` 
		PRIMARY KEY (`id_user_post`),
        
	CONSTRAINT `FK_dt_post_TO_dt_user_post` 
		FOREIGN KEY (`id_post`)
		REFERENCES `dt_post` (`id_post`)
		ON DELETE CASCADE,
      
	CONSTRAINT `FK_cr_user_TO_dt_user_board`
		FOREIGN KEY (`id_user`)
		REFERENCES `cr_user` ( `id_user` )
		ON DELETE CASCADE
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
CREATE PROCEDURE proc_insert_product (IN `proc_id_user`          INTEGER,
									  IN `proc_id_category`      INTEGER,
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
                                      IN `proc_image_paths`      VARCHAR(1000),
                                      OUT `proc_inserted_product_id` INT) 
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
    
    -- return value
	SET `proc_inserted_product_id` = productId;
END $$
DELIMITER ;


 -- Insert Post ----------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_post $$
CREATE PROCEDURE proc_insert_post (IN `proc_board_id`		INTEGER,
								   IN `proc_id_product`		INTEGER,
								   IN `proc_id_user`		INTEGER,
								   IN `proc_id_post_parent` INTEGER,
								   IN `proc_comment`        VARCHAR(128),
								   IN `proc_node_position`  TINYINT(2),
                                   OUT `proc_inserted_post_id` INT) 
BEGIN
	DECLARE indx INT Default 0 ;
	DECLARE str VARCHAR(255);
    DECLARE productId INT;
    DECLARE boardId INT; 
    DECLARE postId INT;
    DECLARE postParentId INT;
    
    SET postParentId = `proc_id_post_parent`;
	IF (`proc_id_post_parent` < 0) 
    THEN  
		SET postParentId = null;
	END IF;
    
    SET boardId = `proc_board_id`;
 
    -- insert board ------------------------------------------------------
    IF (ISNULL(boardId)) 
    THEN 
		INSERT INTO `dt_board` (`board_name`) VALUES (`proc_board_name`);
		SET boardId = LAST_INSERT_ID();
	END IF;
    
    -- insert post -------------------------------------------------------
    INSERT INTO `dt_post` 
	( `id_board`, `id_post_parent`, `comment`, `node_position`)
	VALUES
	( boardId, postParentId, `proc_comment`, `proc_node_position`);

	-- insert product-post -----------------------------------------------
    SET postId = LAST_INSERT_ID();
    
    INSERT INTO `dt_product_post` 
		(`id_product`, `id_post`, `id_board`)
	VALUES 
		(`proc_id_product`, postId, boardId);
 
    -- insert user-post --------------------------------------------------
    INSERT INTO `dt_user_post`
		(`id_post`, `id_user`, `id_board`)
	VALUES
		(postId, `proc_id_user`, boardId);
        
	SET `proc_inserted_post_id` = postId;
END $$
DELIMITER ;


 
 -- Insert Address ----------------------------------------------------------------------------------
 
DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_address $$
CREATE PROCEDURE proc_insert_address ( IN `proc_id_user`			INTEGER, 
									   IN `proc_id_parent_address`  INTEGER,
								       IN `proc_basic_add`        	VARCHAR(64),
								       IN `proc_detail_add`  		VARCHAR(255),
                                       IN `proc_post_num_header`  	VARCHAR(3),
                                       IN `proc_post_num_tail`  	VARCHAR(3),
                                       IN `proc_name`				VARCHAR(50),
                                       IN `proc_phone_number`       VARCHAR(30),
									   OUT `proc_inserted_address_id` INT) 
BEGIN
    DECLARE addressParentId INT;
    
    SET addressParentId = `proc_id_parent_address`;
	IF (`proc_id_parent_address` <= 0) 
    THEN  
		SET addressParentId = null;
	END IF;
     
    
	INSERT INTO `cr_address`(`id_user`, `id_parent_address`, `basic_add`, `detail_add`, `post_num_header`, `post_num_tail`, `name`, `phone_number`) 
		VALUES (`proc_id_user`, addressParentId, `proc_basic_add`, `proc_detail_add` , `proc_post_num_header`, `proc_post_num_tail`, `proc_name`, `proc_phone_number`);
 
	SET `proc_inserted_address_id` = LAST_INSERT_ID();
END $$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_order $$
CREATE PROCEDURE proc_insert_order (IN  `proc_id_user`           INTEGER,
									IN  `proc_id_product`        INTEGER,
									IN  `proc_id_address`        INTEGER,
									IN  `proc_amount`            INTEGER,
									IN  `proc_cost`              INTEGER,
									IN  `proc_delivery_cost`     INTEGER,
									IN  `proc_order_request`   	 TEXT,
                                    OUT `proc_inserted_order_id` INT)
BEGIN 
 
	INSERT into `or_order` (`id_user`, `id_product`, `id_address`, `amount`, `cost`, `delivery_cost`, `order_request`) 
        VALUES (`proc_id_user`, `proc_id_product`,  `proc_id_address`, `proc_amount`, `proc_cost`, `proc_delivery_cost`, `proc_order_request`);
        
	SET `proc_inserted_order_id` = LAST_INSERT_ID();
END $$
DELIMITER ;

select * from `or_order_state`;

		update `or_order_state` 
		set `virtual_order` = 1, `activated` = 1, `paid` = 1, 
			`sended_email` = 1, `shipped` = 1, `delivered` = 1, `deleted` = 1
		where `id_order`=1;

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
SELECT  * FROM `ps_product` as p WHERE p.`name` REGEXP '농구' or 
									   p.`description` REGEXP '농구' or 
									   p.`tag` REGEXP '농구';
                                     
 -- Search Category Product
SELECT * FROM `ps_category` c 
		LEFT OUTER JOIN `ps_product_category` pc USING(`id_category`)
        LEFT OUTER JOIN `ps_product` p USING(`id_product`)
WHERE c.`name`= '여성의류';

ROLLBACK;

-- Insert Post Test -----------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_post_test $$
CREATE PROCEDURE proc_insert_post_test () 
BEGIN
	DECLARE outputId INT unsigned DEFAULT 1;

	INSERT INTO `dt_board` (`board_name`) VALUES ('testboard');
	 
	INSERT INTO `cr_user` (`email`, `password`) VALUES ('email','pass');

	INSERT INTO `ps_product` 
	(`id_user`,`name`,`price`,`stock`,`translation`,`connection`,`on_sale`,`on_open`,`tag`,`out_of_stock`,`description`,`searching_count`)
	VALUES
	(1, 'product1', '60', '60', 1, 204, true, true, 'tag7', false, 'description6',0);

	-- insert post test 
	
	CALL proc_insert_post(1 , 1, 1, null, 'testcomment', 0, outputId);
	CALL proc_insert_post(1 , 1, 1, 1, 'testChildcomment', 1, outputId);
	CALL proc_insert_post(1 , 1, 1, 1, 'testChildcomment2', 2, outputId);

	SELECT * FROM `dt_board`;
	SELECT * FROM `dt_post`;
	SELECT * FROM `dt_product_post`;
	SELECT * FROM `dt_user_post`;
END $$
DELIMITER ;

BEGIN;
	CALL proc_insert_post_test();
    
	-- 일단 product 에 속해있는 모든 comment 를 검색한다.
	SELECT t.*
	FROM `dt_post` t
		INNER JOIN `dt_product_post` pt USING(`id_post`) 
		INNER JOIN `ps_product` p USING(`id_product`)
	WHERE p.`id_product` = 1;

	 
	-- 검색한 코멘트에 해당하는 유저 정보를 찾는다.
	SELECT u.*
	FROM `cr_user` u
		INNER JOIN `dt_user_post` up USING(`id_user`) 
		INNER JOIN `dt_post` p USING(`id_post`)
	WHERE p.`id_post` = 1;
ROLLBACK;

-- Insert Address Test -----------------------------------------------------------------

 DELIMITER $$
DROP PROCEDURE IF EXISTS proc_insert_address_test $$
CREATE PROCEDURE proc_insert_address_test () 
BEGIN
	DECLARE userId INT;
	DECLARE outputId INT unsigned DEFAULT 1;

	INSERT INTO `cr_user` (`email`, `password` ) VALUES ('email1','password1'); 
    
    SET userId = LAST_INSERT_ID();
 
	CALL proc_insert_address(userId , null, 'basic1', 'detail1',  '000','111', outputId); 
	CALL proc_insert_address(userId , outputId, 'basic2', 'detail2',  '000','111', outputId); 

	SELECT outputId;
END $$
DELIMITER ;

 CALL proc_insert_address_test();

 
-- Category Select Test -----------------------------------------------------------------

SELECT t1.name AS lev1, t2.name as lev2, t3.name as lev3
FROM `ps_category` AS t1
LEFT JOIN `ps_category` AS t2 ON t2.`id_category_parent` = t1.`id_category`
LEFT JOIN `ps_category` AS t3 ON t3.`id_category_parent` = t2.`id_category`
LEFT JOIN `ps_category` AS t4 ON t4.`id_category_parent` = t3.`id_category`
WHERE t1.name = '여성의류';

 
*/