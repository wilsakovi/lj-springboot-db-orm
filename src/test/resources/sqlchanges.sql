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
INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Other', '');

UPDATE `stp_pa_issue_area` SET `code` = 'OT' WHERE (`id` = '6');
alter table job add column pa_issue_area_id int(2) default null;

ALTER TABLE `job`
     ADD CONSTRAINT `fk_pa_issue_area`
      FOREIGN KEY (`pa_issue_area_id`)
       REFERENCES `stp_pa_issue_area` (`id`)
     ON DELETE NO ACTION
       ON UPDATE NO ACTION;


       ALTER TABLE `term` 
CHANGE COLUMN `term_rank` `term_rank` INT(4) NULL DEFAULT NULL ;

ALTER TABLE `job` 
DROP FOREIGN KEY `fk_pa_issue_area`;

ALTER TABLE `job` 
DROP INDEX `fk_pa_issue_area_idx` ;

ALTER TABLE `job` 
DROP COLUMN `pa_issue_area_id`,
ADD COLUMN `pa_issue_area_ids` JSON NULL AFTER `tag_ids`;

update stp_pa_issue_area set description = concat(description, '.') where description is not null and description !='';


==================================== Issue 183==================================================================================

ALTER TABLE `users` 
ADD UNIQUE INDEX `uq-user-email` (`email` ASC) VISIBLE;

INSERT INTO `stp_pa_issue_area` (`name`, `description`) VALUES ('Full participation in democracy', 'Supporting awareness of civic duties and opportunities to engage in local efforts to improve communities.');

=================================== Issue 184 ================================================================================
DROP TABLE `msr_comment`;
DROP TABLE `msr_section`;

ALTER TABLE `msr_job_objective` 
ADD COLUMN `recent_activity_at_po` TEXT NULL AFTER `msr_id`,
ADD COLUMN `planned_activity` TEXT NULL AFTER `recent_activity_at_po`;

DROP TABLE `stp_action_status`;

ALTER TABLE `msr_job_objective` 
ADD COLUMN `pos_commit_comment` TEXT NULL DEFAULT NULL AFTER `staff_comment_date`,
ADD COLUMN `staff_commit_comment` TEXT NULL DEFAULT NULL AFTER `pos_commit_comment`,
ADD COLUMN `pos_commit_user_id` INT NULL DEFAULT NULL AFTER `staff_commit_comment`,
ADD COLUMN `staff_commit_user_id` INT NULL DEFAULT NULL AFTER `pos_commit_user_id`,
ADD COLUMN `pos_commit_date` DATE NULL DEFAULT NULL AFTER `staff_commit_user_id`,
ADD COLUMN `staff_commit_date` DATE NULL DEFAULT NULL AFTER `pos_commit_date`;

============================== Issues 193 194 195 ===================================================================
ALTER TABLE `program_year` 
ADD COLUMN `com_pre_post_cap_build_flag` INT NULL DEFAULT 0 AFTER `cap_build_assess_flag`,
CHANGE COLUMN `cap_build_assess_flag` `cap_build_assess_flag` INT NOT NULL DEFAULT 0 ;

ALTER TABLE `program_year` 
CHANGE COLUMN `com_pre_post_cap_build_flag` `comb_pre_post_cap_build_flag` INT NULL DEFAULT 1 ;

INSERT INTO `atomic_user_role` (`code`, `name`, `role_type_id`, `active_flag`, `editable_flag`, `required_site_flag`) VALUES ('HD', 'National Help Desk', '92', b'1', b'0', b'0');

ALTER TABLE `program_year` CHANGE COLUMN `comb_pre_post_cap_build_flag` `retro_cap_build_flag` INT NULL DEFAULT 1 ;

===================== Issue 115 =====================================================================

DROP TABLE `tagging`;

ALTER TABLE `job` DROP COLUMN `tag_ids`;

====================== Issue 186 ======================================================================
DROP TABLE `option_list_option`;
DROP TABLE `form_field`;
DROP TABLE `option_list`;
DROP TABLE `pa_form`;
ALTER TABLE `atomic_user_role` ADD COLUMN `help_page` TEXT NULL AFTER `homePage`;

CREATE TABLE `editor` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NOT NULL,
  `description` VARCHAR(80) NULL,
  `content` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE);
  
  INSERT INTO `editor` (`code`, `description`) VALUES ('HP', 'Help content');
  
  ALTER TABLE `atomic_user_role` ADD COLUMN `extended_code` VARCHAR(45) NULL AFTER `help_page`;
  
UPDATE `atomic_user_role` SET `extended_code` = 'ALLY' WHERE (`code` = 'AL');
UPDATE `atomic_user_role` SET `extended_code` = 'SUPER' WHERE (`code` = 'sp');
UPDATE `atomic_user_role` SET `extended_code` = 'PM' WHERE (`code` = 'PM');
UPDATE `atomic_user_role` SET `extended_code` = 'SD' WHERE (`code` = 'SD');
UPDATE `atomic_user_role` SET `extended_code` = 'NA' WHERE (`code` = 'NA');
UPDATE `atomic_user_role` SET `extended_code` = 'SR' WHERE (`code` = 'SR');
UPDATE `atomic_user_role` SET `extended_code` = 'SA' WHERE (`code` = 'SA');
UPDATE `atomic_user_role` SET `extended_code` = 'REPORTS' WHERE (`code` = 'RR');
UPDATE `atomic_user_role` SET `extended_code` = 'ALUMNI' WHERE (`code` = 'LM');
UPDATE `atomic_user_role` SET `extended_code` = 'TSP' WHERE (`code` = 'TP');
UPDATE `atomic_user_role` SET `extended_code` = 'HELPDESK' WHERE (`code` = 'HD');

ALTER TABLE `atomic_user_role` 
DROP COLUMN `help_page`,
CHANGE COLUMN `extended_code` `extended_code` VARCHAR(45) NOT NULL AFTER `code`,
ADD UNIQUE INDEX `extended_code_UNIQUE` (`extended_code` ASC) VISIBLE;

================================== 120 ========================================
CREATE TABLE `schdeuled_report` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `report_data` JSON NOT NULL,
  `schedule_data` DATE NOT NULL,
  `run` INT(1) NULL,
  `file_id` VARCHAR(100) NULL,
  `run_date` DATE NULL,
  `email_sent` INT(1) NULL,
  `downloaded` INT(1) NULL,
  `created_users_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `qb` INT(1) NOT NULL COMMENT 'Is it query builder report?',
  PRIMARY KEY (`id`),
        FOREIGN KEY (`created_users_id`)
       REFERENCES `users` (`id`)
     ON DELETE NO ACTION
       ON UPDATE NO ACTION);
       
       ALTER TABLE `schdeuled_report` 
RENAME TO  `scheduled_report` ;

ALTER TABLE `scheduled_report` 
CHANGE COLUMN `schedule_data` `schedule_date` DATE NOT NULL ;

ALTER TABLE `scheduled_report` 
ADD COLUMN `description` VARCHAR(180) NULL AFTER `qb`,
ADD COLUMN `shared_roled` JSON NULL AFTER `description`;

ALTER TABLE `scheduled_report` 
CHANGE COLUMN `shared_roled` `shared_roles` JSON NULL DEFAULT NULL ;

INSERT INTO `env_properties` (`keycode`, `keyValue`) VALUES ('EXPORT_DIR', THE PATH HERE);

ALTER TABLE `scheduled_report` 
ADD COLUMN `failed_flag` INT(1) NULL DEFAULT 0 AFTER `shared_roles`,
ADD COLUMN `national_role_selected` INT(1) NOT NULL AFTER `failed_flag`,
ADD COLUMN `servicing_sites` JSON NULL AFTER `national_role_selected`;

ALTER TABLE `scheduled_report` 
DROP COLUMN `servicing_sites`,
DROP COLUMN `national_role_selected`,
CHANGE COLUMN `file_id` `file_name` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `failed_flag` `failed` INT NULL DEFAULT '0' ;

ALTER TABLE `scheduled_report` 
ADD COLUMN `report_codes` JSON NULL AFTER `failed`;

ALTER TABLE `scheduled_report` 
ADD COLUMN `deleted` INT(1) NOT NULL DEFAULT 0;

============================== 232======================================================
ALTER TABLE `partner` 
DROP COLUMN `taggings`,
ADD COLUMN `duplicate_level` INT(1) NULL DEFAULT 0 COMMENT '1 for duplicate hard stop. 2 for duplicate cleared. 0 for no duplicate';
=====================================235==========================================================
ALTER TABLE `msr`  ADD COLUMN `reminder_date_ally` DATE NULL;
ALTER TABLE `pay_period`  ADD COLUMN `reminder_date_ally` DATE NULL;

=================================185===================================================================================
CREATE TABLE `partner_site` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `partner_id` INT NOT NULL,
  `site_id` SMALLINT NOT NULL,
  `active_flag` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  CONSTRAINT `ps_partner_fk`
    FOREIGN KEY (`partner_id`)
    REFERENCES `partner` (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `ps_site_fk`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    UNIQUE INDEX `partner_site_uq` (`partner_id` ASC, `site_id` ASC) VISIBLE
    );
    
    insert into partner_site (partner_id, site_id, active_flag) select id, site_id, 1 from partner;
    
    ALTER TABLE `partner_site` 
ADD COLUMN `created_at` DATETIME NULL AFTER `active_flag`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;


ALTER TABLE `stp_cap_increase_exp` 
ADD COLUMN `old_cap_flag` INT NOT NULL DEFAULT 0 AFTER `name`;

UPDATE `stp_cap_increase_exp` SET `old_cap_flag` = '1' WHERE (`id` = '1');
UPDATE `stp_cap_increase_exp` SET `old_cap_flag` = '1' WHERE (`id` = '2');
UPDATE `stp_cap_increase_exp` SET `old_cap_flag` = '1' WHERE (`id` = '3');
UPDATE `stp_cap_increase_exp` SET `old_cap_flag` = '1' WHERE (`id` = '4');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('PS', 'More people served', '0', '1');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('SO', 'Better services offered', '0', '1');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('IS', 'Improved system or process', '0', '1');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('NP', 'New project or program developed', '0', '1');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('OT', 'Other (explain)', '0', '1');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`, `old_cap_flag`, `active_flag`) VALUES ('NI', 'No impact', '0', '1');


ALTER TABLE `job_ey_assessment` 
ADD COLUMN `service_impact` INT(1) NULL AFTER `submitted_user_id`,
ADD COLUMN `additional_comment` TEXT NULL AFTER `service_impact`;

ALTER TABLE `job_ey_assessment` 
ADD COLUMN `cap_increase_exp_other` VARCHAR(100) NULL AFTER `cap_increase_exp_ids`;

==================================== 273================================================================================
ALTER TABLE `job` ADD COLUMN `egrant_location` INT NULL;

ALTER TABLE `job` ADD COLUMN `egrant_location_confirmed` INT  NULL;

======================= 274====================================================================================
ALTER TABLE `program` CHANGE COLUMN `name` `name` VARCHAR(80) NOT NULL ;

===============================280========================================================================
CREATE TABLE `ally_profile_stats` (
  id  INT NOT NULL AUTO_INCREMENT,
  `ally_profile_id` INT NOT NULL,
  `pps_grand_total` DECIMAL(8,2) NULL,
  `pps_total_placement` DECIMAL(8,2) NULL,
  `pps_total_fundraising` DECIMAL(8,2) NULL,
  `pps_total_tsp` DECIMAL(8,2) NULL,
  `pps_total_service` DECIMAL(8,2) NULL,
  `pps_total_training` DECIMAL(8,2) NULL,
  `ratioHoursCompleted` DECIMAL(8,2) NULL,
  UNIQUE INDEX `ap_ap_stat_uq` (`ally_profile_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ap_ap_stat`
    FOREIGN KEY (`ally_profile_id`)
    REFERENCES `ally_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
ALTER TABLE `ally_profile_stats` 
ADD COLUMN `pathways_code` VARCHAR(2) NULL AFTER `ratioHoursCompleted`;    


ALTER TABLE `ally_profile_stats` 
ADD COLUMN `total_ally_submitted` DECIMAL(8,2) NULL AFTER `ratioHoursCompleted`;


insert into ally_profile_stats(ally_profile_id, pps_grand_total, pps_total_placement, pps_total_fundraising,
pps_total_tsp, pps_total_service, pps_total_training, ratioHoursCompleted, pathways_code)
select ap_id, pps_grand_total, pps_total_placement, pps_total_fundraising,
pps_total_tsp, pps_total_service, pps_total_training, ratioHoursCompleted, pathways_code
from vw_ally_profile;

update ally_profile_stats aps, (
              SELECT ally_profile_id, SUM(grand_total) as total
                FROM pay_period
                WHERE  ally_submit_STATUS_code = 'SB' group by ally_profile_id) sq
                set aps.total_ally_submitted = sq.total
                where aps.ally_profile_id = sq.ally_profile_id;
                
=========================================adhoc==========================================

mysql> insert into env_properties(keyCode, keyValue) values('DROPBOX_DIR', value here);

=====================314 =================================================

ALTER TABLE `ally_exit_reason` ADD COLUMN `active_flag` INT NOT NULL DEFAULT 1 AFTER `cpc_exit_only_flag`;

UPDATE `ally_exit_reason` SET `active_flag` = '0' WHERE (`name` = 'COVID-19 / Coronavirus');

========================314 - cont ====================================================
UPDATE `ally_exit_reason` SET `active_flag` = '1' WHERE (`name` = 'COVID-19 / Coronavirus');

ALTER TABLE `ally_exit_reason` 
ADD COLUMN `lower_term_id` SMALLINT NULL,
ADD COLUMN `upper_term_id` SMALLINT NULL AFTER `lower_term_id`,
ADD INDEX `fk_ap_er_term_1_idx` (`lower_term_id` ASC) VISIBLE,
ADD INDEX `fk_ap_er_term_2_idx` (`upper_term_id` ASC) VISIBLE;
;
ALTER TABLE `ally_exit_reason` 
ADD CONSTRAINT `fk_ap_er_term_1`
  FOREIGN KEY (`lower_term_id`)
  REFERENCES `term` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ap_er_term_2`
  FOREIGN KEY (`upper_term_id`)
  REFERENCES `term` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  UPDATE `ally_exit_reason` SET `upper_term_id` = (select id from term where name = '2021-2022') WHERE (`name` = 'COVID-19 / Coronavirus');
  =============================================333=================================================================
  
  ALTER TABLE `ally_profile_history` 
ADD COLUMN `satisfactory_effort_flag` INT(1) NOT NULL DEFAULT 2 AFTER `updated_by_user_id`,
ADD COLUMN `satisfactory_effort_comment` TEXT NULL AFTER `satisfactory_effort_flag`,
ADD COLUMN `met_criteria_flag` INT(1) NOT NULL DEFAULT 2 AFTER `satisfactory_effort_comment`,
ADD COLUMN `met_criteria_comment` TEXT NULL AFTER `met_criteria_flag`,
ADD COLUMN `suspended_egrant_flag` INT(1) NOT NULL DEFAULT 2 AFTER `met_criteria_comment`,
ADD COLUMN `sf_allow_exit_flag` INT(1) NOT NULL DEFAULT 2 AFTER `suspended_egrant_flag`,
ADD COLUMN `sf_allow_graduate_flag` INT(1) NOT NULL DEFAULT 2 AFTER `sf_allow_exit_flag`,
ADD COLUMN `no_satisf_ey_graduate_comment` TEXT NULL AFTER `sf_allow_graduate_flag`,
ADD COLUMN `latest_flag` INT(1) NOT NULL DEFAULT 1 AFTER `no_satisf_ey_graduate_comment`;

ALTER TABLE `ally_profile` 
ADD COLUMN `temp_pending_sf_case` INT(1) NOT NULL DEFAULT 0,
ADD COLUMN `pending_sf_case` INT(1) NOT NULL default 2 ,
ADD COLUMN `sf_case_date` DATETIME NULL ,
ADD COLUMN `sf_case_close_date` DATETIME NULL ;

ALTER TABLE `ally_profile_history` 
DROP COLUMN `sf_allow_graduate_flag`,
DROP COLUMN `sf_allow_exit_flag`;

ALTER TABLE `ally_profile` 
ADD COLUMN `sf_case_graduation_id` TINYINT NULL ,
ADD COLUMN `sf_case_ally_start_date` DATE NULL,
ADD COLUMN `sf_case_status_effective_date` DATE NULL,
CHANGE COLUMN `temp_pending_sf_case` `sf_case_temp_pending_flag` INT NOT NULL DEFAULT '0' ,
CHANGE COLUMN `pending_sf_case` `sf_case_pending_flag` INT NOT NULL DEFAULT '2' ;

ALTER TABLE `ally_profile_history` 
CHANGE COLUMN `latest_flag` `latest_flag` INT NOT NULL DEFAULT 0 ;

update ally_profile_history set latest_flag = 0;

SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

update ally_profile_history aph
join (
  select id, max(graduate_status_date) grd, ally_profile_id
  from ally_profile_history
  group by ally_profile_id
) sq
set aph.latest_flag = 1 
where aph.id = sq.id;

=============== 353 =====================================
ALTER TABLE `msr` 
ADD COLUMN `pos_pa_satisfaction` VARCHAR(15) NULL AFTER `reminder_date_ally`;

========================= issue-373=====================================
ALTER TABLE `msr` 
ADD COLUMN `pm_member_satisfaction` VARCHAR(15) NULL ;

==================================================================

CREATE TABLE `ap_midterm_evaluation` (
  `id` INT NOT NULL auto_increment,
  `ally_profile_id` INT NOT NULL,
  `ally_satisfaction` VARCHAR(15) NULL,
  `pos_satisfaction` VARCHAR(15) NULL,
  `staff_satisfaction` VARCHAR(15) NULL,
  `ally_assessment_date` DATETIME NULL,
  `pos_assessment` DATETIME NULL,
  `staff_assessment_date` DATETIME NULL,
  `assess_pos_users_id` INT NULL,
  `assess_staff_id` INT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  
  UNIQUE INDEX `ally_profile_id_UNIQUE` (`ally_profile_id` ASC) VISIBLE);
  
  alter table ap_midterm_evaluation rename column assess_staff_id to assess_staff_users_id;
  
  ALTER TABLE ap_midterm_evaluation add constraint fk_ap_midterm_ap FOREIGN KEY (`ally_profile_id`) REFERENCES ally_profile(`id`);
  ALTER TABLE ap_midterm_evaluation ADD constraint fk_ap_midterm_posu FOREIGN KEY (`assess_pos_users_id`) REFERENCES users(`id`);
    ALTER TABLE ap_midterm_evaluation ADD constraint fk_ap_midterm_stu FOREIGN KEY (`assess_staff_users_id`) REFERENCES users(`id`);

ALTER TABLE `ap_midterm_evaluation` 
ADD COLUMN `attached_msr_id` INT NOT NULL AFTER `updated_at`,
ADD UNIQUE INDEX `attached_msr_id_UNIQUE` (`attached_msr_id` ASC) VISIBLE;
;
ALTER TABLE `ap_midterm_evaluation` 
ADD CONSTRAINT `fk_ap_midterm_msr`
  FOREIGN KEY (attached_msr_id)
  REFERENCES `msr` (id)
  ON DELETE cascade
  ON UPDATE NO ACTION;