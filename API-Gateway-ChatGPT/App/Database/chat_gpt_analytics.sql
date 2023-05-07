-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chat_gpt_analytics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chat_gpt_analytics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chat_gpt_analytics` DEFAULT CHARACTER SET utf8 ;
USE `chat_gpt_analytics` ;

-- -----------------------------------------------------
-- Table `chat_gpt_analytics`.`user_agents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat_gpt_analytics`.`user_agents` (
  `id_user_agent` INT NOT NULL AUTO_INCREMENT,
  `user_agent` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_user_agent`),
  UNIQUE INDEX `user_agent_UNIQUE` (`user_agent` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat_gpt_analytics`.`ip_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat_gpt_analytics`.`ip_addresses` (
  `id_ip_address` INT NOT NULL AUTO_INCREMENT,
  `ip_address` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_ip_address`),
  UNIQUE INDEX `IP_ADDRESS_UNIQUE` (`ip_address` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat_gpt_analytics`.`questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat_gpt_analytics`.`questions` (
  `id_question` INT NOT NULL AUTO_INCREMENT,
  `id_user_agent` INT NOT NULL,
  `id_ip_address` INT NOT NULL,
  `question` LONGTEXT NOT NULL,
  `answer` LONGTEXT NOT NULL,
  `date_time` DATETIME NOT NULL,
  PRIMARY KEY (`id_question`),
  INDEX `fk_QUESTIONS_CLIENT_idx` (`id_user_agent` ASC),
  INDEX `fk_QUESTIONS_IP_ADDRESSES1_idx` (`id_ip_address` ASC),
  CONSTRAINT `fk_QUESTIONS_CLIENT`
    FOREIGN KEY (`id_user_agent`)
    REFERENCES `chat_gpt_analytics`.`user_agents` (`id_user_agent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QUESTIONS_IP_ADDRESSES1`
    FOREIGN KEY (`id_ip_address`)
    REFERENCES `chat_gpt_analytics`.`ip_addresses` (`id_ip_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
