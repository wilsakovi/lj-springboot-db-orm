====================== 05/14/2020======================================
ALTER TABLE `program_year` 
ADD COLUMN `timelog_flag` INT(1) NOT NULL DEFAULT 1 AFTER `sf_flag`,
ADD COLUMN `msr_flag` INT(1) NOT NULL DEFAULT 1 AFTER `timelog_flag`,
ADD COLUMN `pathways_flag` INT(1) NOT NULL DEFAULT 1 AFTER `msr_flag`,
ADD COLUMN `job_assess_flag` INT(1) NOT NULL DEFAULT 1,
ADD COLUMN `tsp_flag` INT(1) NOT NULL DEFAULT 1 ,
ADD COLUMN `ey_assess_flag` INT(1) NOT NULL DEFAULT 1;

ALTER TABLE `program_year` 
CHANGE COLUMN `ey_assess_flag` `cap_build_assess_flag` INT NOT NULL DEFAULT 1 ;

ALTER TABLE `program_year` 
CHANGE COLUMN `job_assess_flag` `ey_assess_flag` INT NOT NULL DEFAULT 1 ;

====================== 05/29/2020======================================
// vw_site_profile has been updated.

===========================07/05/2020========================================
ALTER TABLE `job` 
ADD COLUMN `sa_approval_status` CHAR(3) NULL AFTER `sf_failed_flag`,
ADD COLUMN `sa_approval_date` DATETIME NULL AFTER `sa_approval_status`,
ADD COLUMN `sa_approval_comment` TEXT NULL AFTER `sa_approval_date`;

CREATE TABLE `hst_job` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT NULL,
  `system_flag` INT(1) NOT NULL,
  `users_id` INT NULL,
  `action_description` TEXT NULL,
  `created_at` DATETIME NULL,
  CONSTRAINT `fk_hst_job_job` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hst_job_usr` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `hst_job` ADD COLUMN `old_full_name` VARCHAR(100) NULL AFTER `created_at`;
  
  ALTER TABLE `job` ADD COLUMN `contract_sent_flag` INT(1) NULL DEFAULT 0 AFTER `sa_approval_comment`;
  
  update job set contract_sent_flag = 1 where approval_status = 'AP';

ALTER TABLE `job` 
CHANGE COLUMN `sa_approval_status` `sa_approval_status` CHAR(3) NULL DEFAULT 'NA' ;

ALTER table site_profile add COLUMN req_data json DEFAULT NULL;

========================================= 08/20/2020 ==============================================

INSERT INTO env_properties(keyCode, keyValue) value('SM_UPDATE_DATE', yyyy-mm-dd here);
update env_properties set keyCode = 'SM_RES_UPDATE_DATE' where keyCode='SM_LAST_UPDATE';

ALTER TABLE `site_profile` 
CHANGE COLUMN `req_data` `msr_req_sections` JSON NULL DEFAULT NULL ;

======================================== 08/29/2020================================================
ALTER TABLE `users` ADD COLUMN `default_role` VARCHAR(25) NULL AFTER `default_term_id`;

ALTER TABLE `ally` ADD UNIQUE INDEX `users_id_UNIQUE` (`users_id` ASC) VISIBLE;

ALTER TABLE `partner_supervisor` ADD UNIQUE INDEX `users_id_UNIQUE` (`users_id` ASC) VISIBLE;

ALTER TABLE `staff` ADD UNIQUE INDEX `users_id_UNIQUE` (`users_id` ASC) VISIBLE;


ALTER TABLE `users` CHANGE COLUMN `default_role` `default_role_type` VARCHAR(25) NULL DEFAULT NULL ;

==========================================09/01/20=============================================
ALTER TABLE `ally_profile` 
CHANGE COLUMN `pos_approves_pisd_flag` `bypass_pos_approval` INT(1) NOT NULL DEFAULT 0 ;

update ally_profile set bypass_pos_approval = 0 where id > 0;

======================================================= 09/06/20================================
ALTER TABLE   survey     CONVERT TO CHARACTER SET utf8mb4     COLLATE utf8mb4_unicode_ci;
ALTER TABLE   survey_collector     CONVERT TO CHARACTER SET utf8mb4     COLLATE utf8mb4_unicode_ci;
ALTER TABLE   survey_question     CONVERT TO CHARACTER SET utf8mb4     COLLATE utf8mb4_unicode_ci;
ALTER TABLE   survey_response     CONVERT TO CHARACTER SET utf8mb4     COLLATE utf8mb4_unicode_ci;

ALTER TABLE `survey` 
CHANGE COLUMN `name` `name` TINYTEXT NOT NULL ,
CHANGE COLUMN `href` `href` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `nickname` `nickname` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `analyze_url` `analyze_url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `summary_url` `summary_url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `collect_url` `collect_url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `edit_url` `edit_url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `preview_url` `preview_url` TINYTEXT NULL DEFAULT NULL ;


ALTER TABLE `survey_collector` 
CHANGE COLUMN `name` `name` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `redirect_url` `redirect_url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `thanks_msg` `thanks_msg` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `closed_msg` `closed_msg` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `url` `url` TINYTEXT NULL DEFAULT NULL ,
CHANGE COLUMN `href` `href` TINYTEXT NULL DEFAULT NULL ;

ALTER TABLE `survey_question` 
CHANGE COLUMN `heading` `heading` TEXT NULL DEFAULT NULL ;
 ====================================================== 09/17/20==========================================
 ALTER TABLE `ally` CHANGE COLUMN `employment_title` `employment_title` VARCHAR(120) NULL DEFAULT NULL ;
 
 =====================================09/18/20=========================================================
 ALTER TABLE site_profile ADD COLUMN history JSON NULL DEFAULT NULL AFTER msr_req_sections ;
 
 ====================================== 10/17/20===================================================
 ALTER TABLE users ADD COLUMN pronoun VARCHAR(25) NULL DEFAULT NULL AFTER default_role_type;
 
 ===================================== 11/09/20======================================================
 ALTER TABLE `login_activity` 
ADD COLUMN `extra-code-field1` VARCHAR(50) NULL AFTER `users_id`,
ADD COLUMN `extra-code-field2` VARCHAR(50) NULL AFTER `extra-code-field1`,
ADD COLUMN `extra-code-field3` VARCHAR(50) NULL AFTER `extra-code-field2`,
ADD COLUMN `extra-code-field4` VARCHAR(50) NULL AFTER `extra-code-field3`;

ALTER TABLE `login_activity` 
CHANGE COLUMN `extra-code-field1` `extra_code_field1` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `extra-code-field2` `extra_code_field2` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `extra-code-field3` `extra_code_field3` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `extra-code-field4` `extra_code_field4` VARCHAR(50) NULL DEFAULT NULL ;



CREATE TABLE `tagging` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(80) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tag_name_UNIQUE` (`tag_name` ASC) VISIBLE);
  
  ALTER TABLE `job` ADD COLUMN `taggings` JSON NULL AFTER `contract_sent_flag`;
  ALTER TABLE `partner` ADD COLUMN `taggings` JSON NULL;
  
  CREATE TABLE `staff_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NOT NULL,
  `servicing_sites` JSON NULL,
  `staff_type` JSON NULL,
  `effective_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
    CONSTRAINT `fk_staff_hst` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  PRIMARY KEY (`id`))
COMMENT = 'History of staff information. This will track the history only when assigned roles or sites changed';

ALTER TABLE `staff_history` 
COMMENT = 'Past history of staff information. This will track the history only when assigned roles or sites changed. That is the current state of the staff will not be stored.' , RENAME TO  `staff_past_history` ;




