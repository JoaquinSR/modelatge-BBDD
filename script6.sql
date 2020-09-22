-- MySQL Workbench Synchronization
-- Generated: 2020-09-22 21:37
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: diwib

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `mydb`.`Provider` (
  `idProvider` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT(11) NOT NULL,
  `floor` INT(11) NOT NULL,
  `door` VARCHAR(2) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalCode` INT(11) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `telephone` INT(11) NOT NULL,
  `fax` INT(11) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idProvider`),
  UNIQUE INDEX `idProvider_UNIQUE` (`idProvider` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `fax_UNIQUE` (`fax` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Glasses` (
  `idGlasses` INT(11) NOT NULL AUTO_INCREMENT,
  `graduationR` DECIMAL(4,2) NOT NULL,
  `graduationL` DECIMAL(4,2) NOT NULL,
  `frame` VARCHAR(10) NOT NULL,
  `colorF` VARCHAR(45) NOT NULL,
  `colorR` VARCHAR(45) NOT NULL,
  `colorL` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `Brand_idBrand` INT(11) NOT NULL,
  PRIMARY KEY (`idGlasses`),
  UNIQUE INDEX `idGlasses_UNIQUE` (`idGlasses` ASC) VISIBLE,
  INDEX `fk_Glasses_Brand1_idx` (`Brand_idBrand` ASC) VISIBLE,
  CONSTRAINT `fk_Glasses_Brand1`
    FOREIGN KEY (`Brand_idBrand`)
    REFERENCES `mydb`.`Brand` (`idBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `postal` VARCHAR(45) NOT NULL,
  `telephone` INT(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `regDate` DATE NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `idClient_UNIQUE` (`idClient` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `idEmployee` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  UNIQUE INDEX `idEmployee_UNIQUE` (`idEmployee` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Brand` (
  `idBrand` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `Provider_idProvider` INT(11) NOT NULL,
  PRIMARY KEY (`idBrand`),
  UNIQUE INDEX `idBrand_UNIQUE` (`idBrand` ASC) VISIBLE,
  INDEX `fk_Brand_Provider1_idx` (`Provider_idProvider` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Brand_Provider1`
    FOREIGN KEY (`Provider_idProvider`)
    REFERENCES `mydb`.`Provider` (`idProvider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Recommended` (
  `Client_idClient` INT(11) NOT NULL,
  `Client_idClient1` INT(11) NOT NULL,
  PRIMARY KEY (`Client_idClient`, `Client_idClient1`),
  INDEX `fk_Recommended_Client1_idx` (`Client_idClient1` ASC) VISIBLE,
  CONSTRAINT `fk_Recommended_Client`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recommended_Client1`
    FOREIGN KEY (`Client_idClient1`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Sale` (
  `idSale` INT(11) NOT NULL,
  `Client_idClient` INT(11) NOT NULL,
  `Employee_idEmployee` INT(11) NOT NULL,
  PRIMARY KEY (`idSale`),
  UNIQUE INDEX `idSale_UNIQUE` (`idSale` ASC) VISIBLE,
  INDEX `fk_Sale_Client1_idx` (`Client_idClient` ASC) VISIBLE,
  INDEX `fk_Sale_Employee1_idx` (`Employee_idEmployee` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Employee1`
    FOREIGN KEY (`Employee_idEmployee`)
    REFERENCES `mydb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Sale_Glasses` (
  `Glasses_idGlasses` INT(11) NOT NULL,
  `Sale_idSale` INT(11) NOT NULL,
  PRIMARY KEY (`Glasses_idGlasses`, `Sale_idSale`),
  INDEX `fk_Sale_Glasses_Sale1_idx` (`Sale_idSale` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_Glasses_Glasses1`
    FOREIGN KEY (`Glasses_idGlasses`)
    REFERENCES `mydb`.`Glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Glasses_Sale1`
    FOREIGN KEY (`Sale_idSale`)
    REFERENCES `mydb`.`Sale` (`idSale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
