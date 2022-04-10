-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema football
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `football` ;

-- -----------------------------------------------------
-- Schema football
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `football` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `football` ;

-- -----------------------------------------------------
-- Table `bookingpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookingpatient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `bookingpatient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `srfid` VARCHAR(50) NOT NULL,
  `bedtype` VARCHAR(50) NOT NULL,
  `hcode` VARCHAR(50) NOT NULL,
  `spo2` INT NOT NULL,
  `pname` VARCHAR(50) NOT NULL,
  `pphone` VARCHAR(12) NOT NULL,
  `paddress` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `srfid` ON `bookingpatient` (`srfid`(20) ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hospitaldata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospitaldata` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hospitaldata` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hcode` VARCHAR(200) NOT NULL,
  `hname` VARCHAR(200) NOT NULL,
  `silver_ticket` INT NOT NULL,
  `hicubed` INT NOT NULL,
  `icubed` INT NOT NULL,
  `vbed` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `hcode` ON `hospitaldata` (`hcode` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hospitaluser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospitaluser` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hospitaluser` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hcode` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `test` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `trig`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trig` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `trig` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hcode` VARCHAR(50) NOT NULL,
  `silver_ticket` INT NOT NULL,
  `hicubed` INT NOT NULL,
  `icubed` INT NOT NULL,
  `vbed` INT NOT NULL,
  `querys` VARCHAR(50) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `srfid` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `dob` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `srfid` ON `user` (`srfid` ASC) VISIBLE;

SHOW WARNINGS;
USE `football`;

DELIMITER $$

USE `football`$$
DROP TRIGGER IF EXISTS `Insert` $$
SHOW WARNINGS$$
USE `football`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `football`.`Insert`
AFTER INSERT ON `football`.`hospitaldata`
FOR EACH ROW
INSERT INTO trig VALUES(null,NEW.hcode,NEW.silver_ticket,NEW.hicubed,NEW.icubed,NEW.vbed,' INSERTED',NOW())$$

SHOW WARNINGS$$

USE `football`$$
DROP TRIGGER IF EXISTS `Update` $$
SHOW WARNINGS$$
USE `football`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `football`.`Update`
AFTER UPDATE ON `football`.`hospitaldata`
FOR EACH ROW
INSERT INTO trig VALUES(null,NEW.hcode,NEW.silver_ticket,NEW.hicubed,NEW.icubed,NEW.vbed,' UPDATED',NOW())$$

SHOW WARNINGS$$

USE `football`$$
DROP TRIGGER IF EXISTS `delet` $$
SHOW WARNINGS$$
USE `football`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `football`.`delet`
BEFORE DELETE ON `football`.`hospitaldata`
FOR EACH ROW
INSERT INTO trig VALUES(null,OLD.hcode,OLD.silver_ticket,OLD.hicubed,OLD.icubed,OLD.vbed,' DELETED',NOW())$$

SHOW WARNINGS$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
