DROP DATABASE if EXISTS permuta;
CREATE DATABASE  if NOT  EXISTS permuta;
USE permuta;


CREATE TABLE users( 
    `id` INT(11) AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `is_active` ENUM('ACTIVE','INACTIVE') DEFAULT 'INACTIVE',
    `is_admin` BOOLEAN DEFAULT(0) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

-- CRIAR TABELA DE CLIENTES -- customers
CREATE TABLE customers(
    `id` INT(11) AUTO_INCREMENT,
    `user_id` INT(11) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

ALTER TABLE customers ADD FOREIGN KEY(user_id)  REFERENCES users(id);

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  `uf` VARCHAR(5) NOT NULL,
  `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

CREATE TABLE cities(
    `id` INT(11) AUTO_INCREMENT,
    `name` VARCHAR(120)  NOT NULL,
    `state_id` int(5)  NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

ALTER TABLE cities ADD FOREIGN KEY(state_id)  REFERENCES states(id);

-- TABLE IMOVEIS
CREATE TABLE properties(
    `id` INT(11) AUTO_INCREMENT,
    `name` VARCHAR(120) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` NOT NULL DEFAULT now() ON UPDATE now(),
    PRIMARY KEY(id)
);
-- O QUE O CLIENTE TEM
CREATE TABLE what_the_customer_has(
    `id` INT(11) AUTO_INCREMENT,
    `properti_id` INT(11) NOT NULL,
    `citie_id` INT(11) NOT NULL,
    `customers_id`  INT(11) NOT NULL,
    `bedrooms` ENUM('1','2','3','4','5','+ de 5') NOT NULL,
    `total_area` INT(11) NOT NULL,
    `useful_area` INT(11) NOT NULL,
    `property_initial_value` DECIMAL(10,2) NOT NULL,
    `final_property_value` DECIMAL(10,2) NOT NULL,    
    `property_code` VARCHAR(50) NULL,
    `branches_id` INT(11) NOT NULL DEFAULT(1),
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` NOT NULL DEFAULT now() ON UPDATE now(),
    PRIMARY KEY(id)
);

-- ALTER TABLE what_the_customer_has ADD COLUMN branches_id  INT(11)  NOT NULL DEFAULT(1) AFTER  property_code

ALTER TABLE what_the_customer_has ADD FOREIGN KEY(properti_id)  REFERENCES properties(id);
ALTER TABLE what_the_customer_has ADD FOREIGN KEY(citie_id)  REFERENCES cities(id);
ALTER TABLE what_the_customer_has ADD FOREIGN KEY(customers_id)  REFERENCES customers(id);
-- O QUE O CLIENTE QUER
CREATE TABLE what_the_customer_wants(
    `id` INT(11) AUTO_INCREMENT,
    `citie_id` INT(11) NOT NULL,
    `customers_id`  INT(11) NOT NULL,
    `bedrooms` ENUM('1','2','3','4','5','+ de 5') NOT NULL,
    `total_area` INT(11) NOT NULL,
    `useful_area` INT(11) NOT NULL,
    `property_initial_value` DECIMAL(10,2) NOT NULL,
    `final_property_value` DECIMAL(10,2) NOT NULL,
    `branches_id` INT(11) NOT NULL DEFAULT(1),
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` NOT NULL default now() on update now(),
    PRIMARY KEY(id)
);

-- ALTER TABLE what_the_customer_wants ADD COLUMN branches_id  INT(11)  NOT NULL DEFAULT(1) AFTER  final_property_value

ALTER TABLE what_the_customer_wants ADD FOREIGN KEY(citie_id)  REFERENCES cities(id);
ALTER TABLE what_the_customer_wants ADD FOREIGN KEY(customers_id)  REFERENCES customers(id);



insert into users (email, password)
    VALUES('gegomes_gpa@hotmail.com','$2b$10$fEB2KUqAoh7RBWkamzS9He7kDMrKPZRMmge9MoFRr82.p8e9DWN2G')

insert into users (email, password)
    VALUES('heuderdev@gmail.com','$2b$10$KUjI6RWRoPeruJqdarwEfu0cObTz3YzjZKC9TU5w1tDF5B07ZwGmG')

insert into users (email, password)
    VALUES('ge@gmail.com','$2b$10$Zyw6Yfz1psqLKBh/nNcVl.Cx/TkEoEfe0AeshoKFs8ASGU0SgzY6W')

CREATE TABLE permissions(
      `id` INT(11) AUTO_INCREMENT,
      `name` VARCHAR(255) NOT NULL,
      `slug` VARCHAR(255) NOT NULL,
      `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
      `updated_at` NOT NULL default now() on update now(),
      PRIMARY KEY(id)
);

CREATE TABLE permissions_users (
    user_id int(11) NOT NULL,
    permission_id int(11) NOT NULL,
)

ALTER TABLE permissions_users ADD FOREIGN KEY(user_id)  REFERENCES users(id);
ALTER TABLE permissions_users ADD FOREIGN KEY(permission_id)  REFERENCES permissions(id);

-- fILIAIS
DROP TABLE IF EXISTS branches
CREATE TABLE branches(
    `id` INT(11) AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL
    `situation` TINYINT(1) NULL DEFAULT 1,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE photographs(
    `id` INT(11) AUTO_INCREMENT,
    `what_the_customer_has_id` INT(11) NOT NULL,
    `url_path` TEXT NOT NULL,
    `situation` TINYINT(1) NULL DEFAULT 1,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

ALTER TABLE photographs ADD FOREIGN KEY(what_the_customer_has_id)  REFERENCES what_the_customer_has(id);

DROP table IF EXISTS estado;
CREATE TABLE estado(
    `id` INT(11) AUTO_INCREMENT,
    `what_the_customer_wants_id` INT(11) NOT NULL,
    `state_id` INT(11) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

ALTER TABLE estado ADD FOREIGN KEY(what_the_customer_wants_id)  REFERENCES what_the_customer_wants(id);
ALTER TABLE estado ADD FOREIGN KEY(what_the_customer_wants_id)  REFERENCES what_the_customer_wants(id);