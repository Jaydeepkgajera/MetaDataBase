-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon` ;

-- -----------------------------------------------------
-- Table `little_lemon`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`address` (
  `address_id` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Customer` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `contact` INT NOT NULL,
  `adress_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `adrress_id_fk_idx` (`adress_id` ASC) VISIBLE,
  CONSTRAINT `adrress_id_fk`
    FOREIGN KEY (`adress_id`)
    REFERENCES `little_lemon`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `role` VARCHAR(20) NOT NULL,
  `contact` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `annual_salary` VARCHAR(20) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `address_id_fk_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `address_id_fk`
    FOREIGN KEY (`address_id`)
    REFERENCES `little_lemon`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `staff_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `customer_id_fk_idx` (`customer_id` ASC) VISIBLE,
  INDEX `employee_id_fk_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `little_lemon`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`staff_id`)
    REFERENCES `little_lemon`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 218
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`menuitems` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `type` VARCHAR(100) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`menus` (
  `menu_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`menu_id`),
  INDEX `item_id_fk_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `item_id_fk`
    FOREIGN KEY (`item_id`)
    REFERENCES `little_lemon`.`menuitems` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`delivery` (
  `delivery_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`delivery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`orders` (
  `order_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `bill_amount` INT NOT NULL,
  `quantity` INT NOT NULL,
  `delivery_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `booking_id_fk_idx` (`booking_id` ASC) VISIBLE,
  INDEX `menu_id_fk_idx` (`menu_id` ASC) VISIBLE,
  INDEX `delivery_id_idx` (`delivery_id` ASC) VISIBLE,
  CONSTRAINT `booking_id_fk`
    FOREIGN KEY (`booking_id`)
    REFERENCES `little_lemon`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`menu_id`)
    REFERENCES `little_lemon`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_id`
    FOREIGN KEY (`delivery_id`)
    REFERENCES `little_lemon`.`delivery` (`delivery_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
