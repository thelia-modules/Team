
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- team
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `team`;

CREATE TABLE `team`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_team_link
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_team_link`;

CREATE TABLE `person_team_link`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `person_id` INTEGER NOT NULL,
    `team_id` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `FI_person_team_link_person_id` (`person_id`),
    INDEX `FI_person_team_link_team_id` (`team_id`),
    CONSTRAINT `fk_person_team_link_person_id`
        FOREIGN KEY (`person_id`)
        REFERENCES `person` (`id`)
        ON DELETE CASCADE,
    CONSTRAINT `fk_person_team_link_team_id`
        FOREIGN KEY (`team_id`)
        REFERENCES `team` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_image
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_image`;

CREATE TABLE `person_image`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `file` VARCHAR(255),
    `person_id` INTEGER NOT NULL,
    `visible` TINYINT DEFAULT 1 NOT NULL,
    `position` INTEGER,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `idx_person_image_person_id` (`person_id`),
    INDEX `idx_person_image_person_id_position` (`person_id`, `position`),
    CONSTRAINT `fk_person_image_person_id`
        FOREIGN KEY (`person_id`)
        REFERENCES `person` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_function
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_function`;

CREATE TABLE `person_function`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(255),
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_function_link
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_function_link`;

CREATE TABLE `person_function_link`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `person_id` INTEGER NOT NULL,
    `function_id` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `FI_person_function_link_person_id` (`person_id`),
    INDEX `FI_person_function_link_function_id` (`function_id`),
    CONSTRAINT `fk_person_function_link_person_id`
        FOREIGN KEY (`person_id`)
        REFERENCES `person` (`id`)
        ON DELETE CASCADE,
    CONSTRAINT `fk_person_function_link_function_id`
        FOREIGN KEY (`function_id`)
        REFERENCES `person_function` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- team_i18n
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `team_i18n`;

CREATE TABLE `team_i18n`
(
    `id` INTEGER NOT NULL,
    `locale` VARCHAR(5) DEFAULT 'en_US' NOT NULL,
    `title` VARCHAR(255),
    `description` LONGTEXT,
    PRIMARY KEY (`id`,`locale`),
    CONSTRAINT `team_i18n_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `team` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_i18n
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_i18n`;

CREATE TABLE `person_i18n`
(
    `id` INTEGER NOT NULL,
    `locale` VARCHAR(5) DEFAULT 'en_US' NOT NULL,
    `description` LONGTEXT,
    PRIMARY KEY (`id`,`locale`),
    CONSTRAINT `person_i18n_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `person` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_image_i18n
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_image_i18n`;

CREATE TABLE `person_image_i18n`
(
    `id` INTEGER NOT NULL,
    `locale` VARCHAR(5) DEFAULT 'en_US' NOT NULL,
    `title` VARCHAR(255),
    `description` LONGTEXT,
    `chapo` TEXT,
    `postscriptum` TEXT,
    PRIMARY KEY (`id`,`locale`),
    CONSTRAINT `person_image_i18n_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `person_image` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- person_function_i18n
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `person_function_i18n`;

CREATE TABLE `person_function_i18n`
(
    `id` INTEGER NOT NULL,
    `locale` VARCHAR(5) DEFAULT 'en_US' NOT NULL,
    `label` VARCHAR(255),
    PRIMARY KEY (`id`,`locale`),
    CONSTRAINT `person_function_i18n_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `person_function` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
