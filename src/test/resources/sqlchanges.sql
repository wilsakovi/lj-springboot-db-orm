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

ALTER TABLE `login_activity` 
CHANGE COLUMN `extra_code_field4` `activity_code` CHAR(3) NULL DEFAULT NULL AFTER `id`,
CHANGE COLUMN `users_id` `users_id` INT NULL DEFAULT NULL AFTER `activity_code`;


CREATE TABLE `stat_report_usage` (
  `id` INT NOT NULL,
  `report_code` VARCHAR(30) NULL,
  `site_id` SMALLINT NULL,
  `role_code` CHAR(5) NULL,
  `view_mode` VARCHAR(30) NULL,
  `generate_location` VARCHAR(30) NULL,
  `total` INT NULL,
  PRIMARY KEY (`id`));

  ALTER TABLE `job` DROP COLUMN `taggings`;
  
  ALTER TABLE `tagging` 
ADD COLUMN `job_ids` JSON NULL AFTER `tag_name`;

ALTER TABLE `stat_report_usage` 
ADD CONSTRAINT `stat_rep_us_ste`
  FOREIGN KEY (`site_id`)
  REFERENCES `site` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
ALTER TABLE stat_report_usage
ADD CONSTRAINT stat_rep_us_pk UNIQUE(`report_code`, `site_id`, `role_code`, `view_mode`, `generate_location`);

ALTER TABLE `stat_report_usage` CHANGE COLUMN `total` `total` INT NOT NULL ;
ALTER TABLE `stat_report_usage` 
CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ;


ALTER TABLE `stat_report_usage` 
ADD COLUMN `stat_year` INT(4) NULL AFTER `id`,
DROP INDEX `stat_rep_us_pk` ,
ADD UNIQUE INDEX `stat_rep_us_pk` (`report_code` ASC, `site_id` ASC, `role_code` ASC, `view_mode` ASC, `generate_location` ASC, `stat_year` ASC) VISIBLE;
;


ALTER TABLE `stat_report_usage` 
CHANGE COLUMN `stat_year` `stat_year` INT NOT NULL ,
CHANGE COLUMN `report_code` `report_code` VARCHAR(30) NOT NULL ,
CHANGE COLUMN `role_code` `role_code` CHAR(5) NOT NULL ,
CHANGE COLUMN `view_mode` `view_mode` VARCHAR(30) NOT NULL ,
CHANGE COLUMN `generate_location` `generate_location` VARCHAR(30) NOT NULL ;



ALTER TABLE `staff_past_history` 
CHANGE COLUMN `effective_date` `effective_date` DATETIME NOT NULL ,
CHANGE COLUMN `end_date` `end_date` DATETIME NOT NULL ;

===================================================12/05/2020===================================================================
ALTER TABLE `survey` 
ADD COLUMN `schedulable` INT(1) NOT NULL DEFAULT 1 AFTER `custom_variables`;

ALTER TABLE `survey` 
ADD COLUMN `history` JSON NULL AFTER `schedulable`;

===============================================12/12/2020====================================================
ALTER TABLE `survey` 
ADD COLUMN `email_invitation_subject` VARCHAR(200) NULL AFTER `history`,
ADD COLUMN `email_reminder_subject` VARCHAR(200) NULL AFTER `email_invitation_subject`,
ADD COLUMN `email_invitation_body` TEXT NULL AFTER `email_reminder_subject`,
ADD COLUMN `email_reminder_body` TEXT NULL AFTER `email_invitation_body`;

ALTER TABLE `survey` 
CHANGE COLUMN `email_invitation_body` `email_invitation_purpose` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `email_reminder_body` `email_reminder_purpose` TEXT NULL DEFAULT NULL ;

============================================01/24/2021===================================================
UPDATE `stp_common_period` SET `name` = 'Less than 1 month' WHERE name = 'Less then 1 month';

============================================ 2/14/2021===================================================
ALTER TABLE `job` ADD COLUMN `tag_ids` JSON NULL AFTER `contract_sent_flag`;

ALTER TABLE `tagging` DROP COLUMN `job_ids`;

ALTER TABLE `tagging` CHANGE COLUMN `tag_name` `name` VARCHAR(80) NOT NULL ;


CREATE TABLE `survey_term` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `survey_id` INT NOT NULL,
  `term_id` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `survey_term_term_idx` (`term_id` ASC) VISIBLE,
   INDEX `survey_term_survey_idx` (`survey_id` ASC) VISIBLE,
  UNIQUE INDEX `survey_term_uq1` (`survey_id` ASC, `term_id` ASC) VISIBLE,
  CONSTRAINT `survey_term_term`
    FOREIGN KEY (`term_id`)
    REFERENCES `term` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `survey_term_survey`
    FOREIGN KEY (survey_id)
    REFERENCES `survey` (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    =============================================3/13/2021=========================================================
    CREATE TABLE `tsp_site_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tsp_id` INT NOT NULL,
  `site_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tsp_sp_tsp_uq` (`tsp_id` ASC, `site_profile_id` ASC) INVISIBLE,
 CONSTRAINT `tsp_sp_tsp`
    FOREIGN KEY (`tsp_id`)
    REFERENCES `tsp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 CONSTRAINT `tsp_sp_sp`
    FOREIGN KEY (`site_profile_id`)
    REFERENCES `site_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
ALTER TABLE `tsp` 
ADD COLUMN `program_year_id` SMALLINT NULL AFTER `title`;

ALTER TABLE `tsp` add 
 CONSTRAINT `fk_tsp_py`
    FOREIGN KEY (`program_year_id`)
    REFERENCES `program_year` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
insert into tsp_site_profile (tsp_id, site_profile_id) select id, site_profile_id from tsp where site_profile_id is not null;

update tsp t, site_profile sp
set t.program_year_id = sp.program_year_id 
where sp.id = t.site_profile_id
and t.site_profile_id is not null;


ALTER TABLE `tsp` 
ADD COLUMN `term_id` SMALLINT NULL AFTER `id`,
ADD INDEX `fk_tsp_term_idx` (`term_id` ASC) VISIBLE;
;
ALTER TABLE `tsp` 
ADD CONSTRAINT `fk_tsp_term`
  FOREIGN KEY (`term_id`)
  REFERENCES `term` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `tsp` 
DROP FOREIGN KEY `fk_tsp_py`;
ALTER TABLE `tsp` 
DROP COLUMN `program_year_id`,
DROP INDEX `fk_tsp_py` ;
;

update tsp t, site_profile sp, program_year py
set t.term_id = py.term_id
where sp.id = t.site_profile_id
and py.id = sp.program_year_id
and t.site_profile_id is not null;

ALTER TABLE `tsp` 
ADD COLUMN `program_year_id` SMALLINT NULL AFTER `community_impact`;

======================================== 05/02/21==========================================================================
CREATE TABLE `stp_pa_issue_area` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(75) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);
  
ALTER TABLE `stp_pa_issue_area` 
ADD COLUMN `code` CHAR(2) NULL AFTER `description`,
CHANGE COLUMN `description` `description` VARCHAR(250) NULL DEFAULT NULL ,
ADD UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE;

ALTER TABLE `stp_pa_issue_area` 
CHANGE COLUMN `description` `description` TEXT NULL DEFAULT NULL ;
  
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Full participation in the economy', 'Support community members towards full participation in the economy, increase access to career opportunities and living wages and more secure livelihood');
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Health Equity', 'Eradication of health disparities, unequal access to healthcare  & public health threats (including environmental health)');
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Education Equity', 'Eradication of achievement gaps, access to quality education');
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Equal application of justice', 'Supporting reforms within the criminal justice system; ensuring fair and equal application of the law, and promoting fundamental freedoms for everyone');
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Truth telling and healing', 'Leveraging relationships, insight, familiarity, proximity to tell stories about community from the perspective of the community; serve as resources of trusted information for communities that can counteract disinformation that creates confusion & apathy');
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Other', 'Other');

UPDATE `stp_pa_issue_area` SET `code` = 'OT' WHERE (`id` = '6');

ALTER TABLE `job`
     ADD CONSTRAINT `fk_pa_issue_area`
      FOREIGN KEY (`pa_issue_area_id`)
       REFERENCES `stp_pa_issue_area` (`id`)
     ON DELETE NO ACTION
       ON UPDATE NO ACTION;


       ALTER TABLE `term` 
CHANGE COLUMN `term_rank` `term_rank` INT(4) NULL DEFAULT NULL ;
