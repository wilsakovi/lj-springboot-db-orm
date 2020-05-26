CREATE TABLE `msr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_year_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_approved` bit(1) DEFAULT true,
  `generated_by` varchar(60) DEFAULT NULL,
   `ally_submit_status_code` varchar(2) DEFAULT NULL,
  `pos_approval_status_code` varchar(2) DEFAULT NULL,
  `pm_approval_status_code` varchar(2) DEFAULT NULL,
  `pos_approval_date` datetime DEFAULT NULL,
  `pm_approval_date` datetime DEFAULT NULL,
  `ally_initial` varchar(5) DEFAULT NULL,
  `pos_initial` varchar(5) DEFAULT NULL,
  `pm_initial` varchar(5) DEFAULT NULL,
  `notes` text,
  `ally_submit_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `active_flag` bit(1) NOT NULL DEFAULT true,
  `ally_profile_id` int(11) NOT NULL,
  `has_pos_assessment` tinyint(1) DEFAULT '0',
  `job_id` int(11) DEFAULT NULL,
  `report_order` tinyint(2) DEFAULT '0',
  `history_json` json DEFAULT NULL,
  `old_id` int(11) DEFAULT NULL unique,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ally_profile_id` (`ally_profile_id`, job_id, `start_date`,`end_date`),
  KEY `fk_msr_ally_profile` (`ally_profile_id`),
  KEY `fk_msr_job1_idx` (`job_id`),
  CONSTRAINT `fk_msr_ally_profile` FOREIGN KEY (`ally_profile_id`) REFERENCES `ally_profile` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_msr_job1` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


CREATE TABLE `msr_section` (
  `id` tinyint(2) NOT NULL,
  `name` varchar(60) NOT NULL,
  `description` tinytext,
  `active_flag` bit(1) NOT NULL DEFAULT true,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;






CREATE TABLE `msr_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ally_comment` text,
  `pos_comment` text,
  `pm_comment` text,
  `ally_date_comment` datetime DEFAULT NULL,
  `pos_date_comment` datetime DEFAULT NULL,
  `pm_date_comment` datetime DEFAULT NULL,
  `msr_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `msr_section_id` tinyint(2) NOT NULL,
  `active_flag` bit(1) NOT NULL DEFAULT true,
  `submission_status` tinyint(2) DEFAULT '10',
  `old_id` int(11) DEFAULT NULL unique,
  PRIMARY KEY (`id`),
  KEY `fk_report_comment_msr1` (`msr_id`),
  KEY `fk_report_comment_msr_sections1` (`msr_section_id`),
  CONSTRAINT `fk_report_comment_msr1` FOREIGN KEY (`msr_id`) REFERENCES `msr` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_comment_msr_sections1` FOREIGN KEY (`msr_section_id`) REFERENCES `msr_section` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;




CREATE TABLE  msr_job_objective  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   ally_profile_id  int(11) NOT NULL,
   activity_description  text,
   created_at  datetime DEFAULT NULL,
   updated_at  datetime DEFAULT NULL,
   job_objective_id  int(11) NOT NULL,
   msr_id  int(11) NOT NULL,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  UNIQUE KEY  msr_id  ( msr_id , job_objective_id ),
  KEY  fk_msr_job_objective_job_objective1  ( job_objective_id ),
  KEY  fk_msr_job_objective_msr1  (msr_id ),
  CONSTRAINT  fk_msr_job_objective_msr1  FOREIGN KEY ( msr_id ) REFERENCES  msr  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT  fk_msr_job_objective_job_objective1  FOREIGN KEY ( job_objective_id ) REFERENCES  job_objective  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;





CREATE TABLE  msr_pathways  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   msr_id  int(11) NOT NULL,
   ally_profile_id  int(11) NOT NULL,
   fafsa_completed  tinyint(1) DEFAULT NULL,
   college_appl_submitted  tinyint(2) DEFAULT NULL,
   college_accepted  tinyint(1) DEFAULT NULL,
   finaid_applied  tinyint(1) DEFAULT NULL,
   college_regis_completed  tinyint(1) DEFAULT NULL,
   college_name  varchar(50) DEFAULT NULL,
   netevent_attended  tinyint(2) DEFAULT NULL,
   resume_completed  tinyint(1) DEFAULT NULL,
   job_applied  tinyint(2) DEFAULT NULL,
   job_interview  tinyint(2) DEFAULT NULL,
   position_accepted  tinyint(1) DEFAULT NULL,
   position_type  tinyint(3) DEFAULT NULL,
   position_withpo  tinyint(1) DEFAULT NULL,
   company_name  varchar(50) DEFAULT NULL,
   position_title  varchar(50) DEFAULT NULL,
   step_inline  tinyint(1) DEFAULT NULL,
   national_service_applied  tinyint(2) DEFAULT NULL,
   past_pathways_id  tinyint(3) DEFAULT NULL,
   pathways_same  tinyint(1) DEFAULT NULL,
   current_pathways_id  tinyint(3) DEFAULT NULL,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  UNIQUE KEY  msr_pathways_unique  ( msr_id )
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;





CREATE TABLE  msr_snapshot  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   ally_profile_id  int(11) NOT NULL,
   success_story  text,
   created_at  datetime DEFAULT NULL,
   updated_at  datetime DEFAULT NULL,
   msr_id  int(11) NOT NULL,
  PRIMARY KEY ( id ),
  KEY  fk_msr_snapshot_msr1  ( msr_id ),
  CONSTRAINT  fk_msr_snapshot_msr1  FOREIGN KEY ( msr_id ) REFERENCES  msr  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;





CREATE TABLE  msr_training  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   activity_title  varchar(100) DEFAULT NULL,
   activity_date  date DEFAULT NULL,
   activity_description  text,
   created_at  datetime DEFAULT NULL,
   updated_at  datetime DEFAULT NULL,
   ally_profile_id  int(11) NOT NULL,
   msr_id  int(11) NOT NULL,
   training_type  tinyint(3) DEFAULT NULL,
   training_lesson  text,
   understand_level  tinyint(1) DEFAULT NULL,
   confidence_level  tinyint(1) DEFAULT NULL,
   reaction_level  varchar(10) DEFAULT NULL,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  KEY  fk_msr_training_msr1  ( msr_id ),
  CONSTRAINT  fk_msr_training_msr1  FOREIGN KEY ( msr_id ) REFERENCES  msr  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;




CREATE TABLE  msr_volunteer  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   total_new_recruited  int(6) DEFAULT '0',
   total_volunteer_hours  float(8,2) DEFAULT '0.00',
   peope_served  varchar(45) DEFAULT NULL,
   total_active_volunteer  int(11) DEFAULT '0',
   percentage_local  float DEFAULT '0',
   impact_description  text,
   ally_profile_id  int(11) DEFAULT NULL,
   created_at  datetime DEFAULT NULL,
   updated_at  datetime DEFAULT NULL,
   msr_id  int(11) NOT NULL,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  UNIQUE KEY  msr_id  ( msr_id ),
  KEY  fk_msr_volunteer_msr1  ( msr_id ),
  CONSTRAINT  fk_msr_volunteer_msr1  FOREIGN KEY ( msr_id ) REFERENCES  msr  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE  msr_output  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   total_output  float DEFAULT '0',
   created_at  datetime DEFAULT NULL,
   updated_at  datetime DEFAULT NULL,
   job_objective_output_id  int(11) NOT NULL,
   msr_job_objective_id  int(11) NOT NULL,
   underserved_population  tinytext,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  UNIQUE KEY  msr_job_objective_id  ( msr_job_objective_id , job_objective_output_id ),
  KEY  fk_msr_output_job_objective_output1  ( job_objective_output_id ),
  KEY  fk_msr_output_ally_report_job_objective1  ( msr_job_objective_id ),
  CONSTRAINT  fk_msr_output_ally_report_job_objective1  FOREIGN KEY ( msr_job_objective_id ) REFERENCES  msr_job_objective  ( id )
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


CREATE TABLE  msr_output_has_people  (
   id  int(11) NOT NULL AUTO_INCREMENT,
   people_served_id  tinyint(2) NOT NULL,
   msr_output_id  int(11) NOT NULL,
   total_beneficiary  int(10) DEFAULT NULL,
   old_id  int(11) DEFAULT NULL unique,
  PRIMARY KEY ( id ),
  KEY  fk_msr_out_has_people_people_served1  ( people_served_id ),
  KEY  fk_msr_out_has_people_ally_report_output1  ( msr_output_id ),
  CONSTRAINT  fk_msr_out_has_people_ally_report_output1  FOREIGN KEY ( msr_output_id ) REFERENCES  msr_output  ( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


CREATE TABLE `msr_action_activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT NULL,
  `collaborators` TEXT NULL,
  `completion_date` DATE NULL,
  `completed_at` DATE NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `active_flag` BIT(1) NOT NULL DEFAULT true,
  `additional_detail` TEXT NULL,
  `initial_msr_id` INT(11) NOT NULL,
  ally_profile_id int(11) not null,
  action_status_code char(2),
  job_id int(11),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_msr_action_mrs`    FOREIGN KEY (initial_msr_id)    REFERENCES `msr` (id)     ON DELETE NO ACTION     ON UPDATE NO ACTION,
  CONSTRAINT `fk_msr_action_job`    FOREIGN KEY (job_id)    REFERENCES `job` (id)     ON DELETE NO ACTION     ON UPDATE NO ACTION,
  CONSTRAINT `fk_mrs_action_ally_profile`    FOREIGN KEY (ally_profile_id)    REFERENCES `ally_profile` (id)     ON DELETE NO ACTION     ON UPDATE NO ACTION
  );
  
  
  CREATE TABLE `stp_msr_action_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `active_flag` BIT(1) NOT NULL DEFAULT true,
  PRIMARY KEY (`id`));
  
  
ALTER TABLE `site` 
ADD COLUMN `sf_id` VARCHAR(45) NULL AFTER `state_id`,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);


CREATE TABLE `stp_grant_type` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NULL,
  `name` VARCHAR(60) NULL,
  `sf_flag` BIT(1) NULL DEFAULT false,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  

CREATE TABLE `stp_source_fund` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NULL,
  `name` VARCHAR(60) NULL,
  `sf_flag` BIT(1) NULL DEFAULT false,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  
ALTER TABLE `program` 
ADD COLUMN `slot_type_id` TINYINT(2) NULL AFTER `tl_categories`,
ADD INDEX `fk_program_slot_idx` (`slot_type_id` ASC);
ALTER TABLE `program` 
ADD CONSTRAINT `fk_program_slot`
  FOREIGN KEY (`slot_type_id`)
  REFERENCES `slot_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
ALTER TABLE `program` 
ADD COLUMN `default_net_award` DECIMAL(8,2) NULL AFTER `slot_type_id`,
ADD COLUMN `default_gross_award` DECIMAL(8,2) NULL AFTER `default_net_award`,
ADD COLUMN `max_hours` INT(4) NULL AFTER `default_gross_award`;

ALTER TABLE `program` 
ADD COLUMN `sf_flag` BIT(1) default false NULL;

update site set name = 'New York' where name = 'New York - ND';
update site set name = 'San Antonio' where name = 'San Antonio - ND';
update site set name = 'Washington, D.C.' where name = 'Washington D.C.';

set foreign_key_checks = 0;
ALTER TABLE site drop primary key, MODIFY COLUMN id smallint(5)  auto_increment primary key;
set foreign_key_checks = 1;

ALTER TABLE `site` 
CHANGE COLUMN `address1` `address1` VARCHAR(100) NULL DEFAULT NULL ;

update slot_type set name='Full-Time (1700 Hours)' where name like '%1700%';
update slot_type set name='Half-Time (900 Hours)' where name like '%900%';
update slot_type set name='Reduced Half-Time (675 Hours)' where name like '%675%';
update slot_type set name='Quarter-Time (450 Hours)' where name like '%450%';
update slot_type set name='Minimum-Time (300 Hours)' where name like '%300%';

CREATE TABLE `stp_partner_type` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NULL,
  `name` VARCHAR(80) NULL,
  `sf_flag` BIT(1) NULL DEFAULT false,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));


ALTER TABLE `partner` 
ADD COLUMN `partner_type_id` INT(2) NULL ,
ADD INDEX `fk_partner_type_partner_idx` (`partner_type_id` ASC);
ALTER TABLE `pisd_local`.`partner` 
ADD CONSTRAINT `fk_partner_type_partner`
  FOREIGN KEY (`partner_type_id`)
  REFERENCES `stp_partner_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `contact` 
ADD COLUMN `sf_id` VARCHAR(45) NULL ,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);

  ALTER TABLE `partner` 
ADD COLUMN `sf_id` VARCHAR(45) NULL ,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);

  ALTER TABLE `slot_type` 
ADD COLUMN `sf_flag` BIT(1) default false NULL;

  ALTER TABLE `term` 
ADD COLUMN `sf_flag` BIT(1) default false NULL;

  ALTER TABLE `program_year` 
ADD COLUMN `sf_flag` BIT(1) default false NULL;

ALTER TABLE `program` 
ADD COLUMN `src_fund_id` INT(2) NULL ,
ADD INDEX `fk_program_srcfund_idx` (`src_fund_id` ASC);

ALTER TABLE `program` 
ADD CONSTRAINT `fk_program_srcfund`
  FOREIGN KEY (`src_fund_id`)
  REFERENCES `stp_source_fund` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `site_profile` 
ADD COLUMN `sf_id` VARCHAR(60) NULL ;

ALTER TABLE `partner_other` 
ADD COLUMN `sf_id` VARCHAR(60) NULL ,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);


ALTER TABLE `site_profile` 
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);

ALTER TABLE `site_profile` 
ADD COLUMN `slot_type_id` TINYINT(2) NULL AFTER `sf_id`,
ADD COLUMN `src_fund_id` TINYINT(2) NULL AFTER `slot_type_id`,
ADD INDEX `sk_sp_slottype_idx` (`slot_type_id` ASC);


  
  ALTER TABLE `program` 
DROP FOREIGN KEY `fk_program_srcfund`;
ALTER TABLE `program` 
DROP COLUMN `src_fund_id`,
DROP COLUMN `sf_flag`,
DROP INDEX `fk_program_srcfund_idx` ;

ALTER TABLE `site_profile` 
CHANGE COLUMN `src_fund_id` `src_fund_id` INT(2) NULL DEFAULT NULL ,
ADD INDEX `fk_sp_src_idx` (`src_fund_id` ASC);
ALTER TABLE `site_profile` 
ADD CONSTRAINT `fk_sp_src`
  FOREIGN KEY (`src_fund_id`)
  REFERENCES `stp_source_fund` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `sk_sp_slot`
  FOREIGN KEY (`slot_type_id`)
  REFERENCES `slot_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
    ALTER TABLE `program` 
ADD COLUMN `sf_flag` BIT(1) default false NULL;


ALTER TABLE `site_profile` 
DROP FOREIGN KEY `reft_pssite_type`,
DROP FOREIGN KEY `FKo9f2ibiph5ettm5wms0fbfx9u`;
ALTER TABLE `site_profile` 
DROP INDEX `reft_pssite_type_idx` ;
ALTER TABLE `site_profile`  DROP COLUMN `national_type`;



ALTER TABLE `ally_profile` DROP COLUMN `slot_type_id`;

ALTER TABLE `contact` 
ADD INDEX `fk_contact_state_idx` (`state_id` ASC);
ALTER TABLE `contact` 
ADD CONSTRAINT `fk_contact_state`
  FOREIGN KEY (`state_id`)
  REFERENCES `state` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `cncs` 
CHANGE COLUMN `status_id` `active_flag` TINYINT(1) NULL DEFAULT '1' ;

INSERT INTO `atomic_user_role` (`code`, `name`, `role_type_id`, `active_flag`) VALUES ('SA', 'System Admin', '92', true);


CREATE TABLE `stp_action_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `active_flag` BIT(1) NULL DEFAULT true,
  step_rank int(1) not null,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  CREATE TABLE `action_step_objective` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `users_id` INT NULL,
  `step_status_id` INT(2) NULL,
  `history` JSON NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_asobj_status`    FOREIGN KEY (step_status_id)    REFERENCES `stp_action_status` (id)     ON DELETE NO ACTION     ON UPDATE NO ACTION
  );


  
  CREATE TABLE `stp_action_step_category` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(2) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `active_flag` BIT(1) NULL DEFAULT true,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  alter table `action_step_objective` add column category_id int(2) not null,
  ADD CONSTRAINT `fk_action_cat`
  FOREIGN KEY (`category_id`)
  REFERENCES `stp_action_step_category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
 ALTER TABLE `action_step_objective` 
DROP FOREIGN KEY `fk_asobj_status`;
ALTER TABLE `action_step_objective` 
DROP COLUMN `step_status_id`,
ADD COLUMN `completed_flag` BIT(1) NULL DEFAULT false,
DROP INDEX `fk_asobj_status` ;

INSERT INTO `stp_action_step_category` (`code`, `name`) VALUES ('CA', 'Career');
INSERT INTO `stp_action_step_category` (`code`, `name`) VALUES ('PS', 'Personal');
INSERT INTO `stp_action_step_category` (`code`, `name`) VALUES ('CM', 'Community');

ALTER TABLE `action_step_objective` 
DROP FOREIGN KEY `fk_action_cat`;
ALTER TABLE `action_step_objective` 
CHANGE COLUMN `category_id` `category_ids` JSON NOT NULL ,
DROP INDEX `fk_action_cat` ;


CREATE TABLE `action_commitment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `objective_id` INT NOT NULL,
  `action_detail` TEXT NULL,
  `partner_role` TEXT NULL,
  `est_completino_date` DATE NULL,
  `add_detail` TEXT NULL,
  `active_status` BIT(1) NULL DEFAULT true,
  `status_id` INT(2) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_action1_status_idx` (`status_id` ASC),
  CONSTRAINT `fk_action1_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `stp_action_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
    
   CONSTRAINT `fk_action2_action`
    FOREIGN KEY (`objective_id`)
    REFERENCES `action_step_objective` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    
    );
    
    
 ALTER TABLE `action_step_objective` ADD COLUMN `final_comment` TEXT NULL ;
 
 

  
  
  CREATE TABLE `acts_progress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commitment_id` INT NOT NULL,
  `progress_detail` TEXT NULL,
  `status_id` INT(2) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `action2_status_idx` (`status_id` ASC),
  INDEX `action3_commit_idx` (`commitment_id` ASC),
  CONSTRAINT `action2_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `stp_action_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `action3_commit`
    FOREIGN KEY (`commitment_id`)
    REFERENCES `action_commitment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    ALTER TABLE `action_commitment` RENAME TO  `acts_commitment` ;
    
    
    ALTER TABLE `action_step_objective` RENAME TO  `acts_objective` ;
    
    
 ALTER TABLE `acts_commitment` 
CHANGE COLUMN `est_completino_date` `est_completion_date` DATE NULL DEFAULT NULL ,
ADD COLUMN `completion_date` DATE NULL;


CREATE TABLE `acts_report` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `success_note` TEXT NULL,
  `learning_note` TEXT NULL,
  `snapshot_note` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `objective_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  
   CONSTRAINT `fk_action5_report`
    FOREIGN KEY (`objective_id`)
    REFERENCES `acts_objective` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  
  
  );

  
  ALTER TABLE `stp_action_step_category` RENAME TO  `stp_acts_category` ;
  
  ALTER TABLE `stp_action_status` RENAME TO  `stp_acts_status` ;
  
  DROP TABLE `stp_msr_action_status`;
  
  ALTER TABLE `acts_report` 
ADD COLUMN `submitted_flag` BIT(1) NULL DEFAULT false ;


ALTER TABLE `acts_progress` 
ADD COLUMN `report_id` INT NOT NULL AFTER `updated_at`,
ADD INDEX `action6_report_idx` (`report_id` ASC);
ALTER TABLE `acts_progress` 
ADD CONSTRAINT `action6_report`
  FOREIGN KEY (`report_id`)
  REFERENCES `acts_report` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `acts_report` 
ADD COLUMN `add_note` TEXT NULL AFTER `submitted_flag`;

ALTER TABLE `acts_partner` 
CHANGE COLUMN `modified_at` `updated_at` DATETIME NULL DEFAULT NULL ;

=================================================================================================

ALTER TABLE `acts_commitment` ADD COLUMN `init_report_id` INT NULL ;

INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('CP', 'Completed', 1,6);
INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('CG', 'Completed and On-Going', 1,5);
INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('PR', 'In Progress', 1,4);
INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('NB', 'Not yet begun', 1,1);
INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('ND', 'Not Begun and Dropped', 1,2);
INSERT INTO `stp_acts_status` (`code`, `name`, `active_flag`, `step_rank`) VALUES ('BD', 'Begun but Dropped', 1,3);
======================================== 06/02/18 ====================================================
ALTER TABLE `acts_report` 
ADD COLUMN `review_completed_flag` BIT(1) NULL AFTER `add_note`,
ADD COLUMN `review_flag` BIT(1) NULL  DEFAULT false AFTER `review_completed_flag`,
ADD COLUMN `staff_reviewer_id` INT NULL DEFAULT  false AFTER `review_flag`,
ADD COLUMN `reviewer_first_name` VARCHAR(45) NULL  AFTER `staff_reviewer_id`,
ADD COLUMN `reviewer_last_name` VARCHAR(45) NULL  AFTER `reviewer_first_name`,
ADD COLUMN `reviewer_email` VARCHAR(80) NULL AFTER `reviewer_last_name`,
ADD COLUMN `review_note` TEXT NULL AFTER `reviewer_email`;



ALTER TABLE `acts_progress` 
DROP FOREIGN KEY `action2_status`;
ALTER TABLE `acts_progress` 
CHANGE COLUMN `status_id` `status_id` INT(2) NULL ;
ALTER TABLE `acts_progress` 
ADD CONSTRAINT `action2_status`
  FOREIGN KEY (`status_id`)
  REFERENCES `stp_acts_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `acts_progress` 
ADD UNIQUE INDEX `ACTION10_UQ` (`commitment_id` ASC, `report_id` ASC);


============================================= 06/03/17 ============================================================
INSERT INTO `atomic_user_role` (`code`, `name`, `role_type_id`, `active_flag`, `required_site_flag`) VALUES ('RR', 'Reports Reviewer', '92', true, false);
UPDATE `atomic_user_role` SET `required_site_flag`= false WHERE code='SA';

ALTER TABLE `acts_report` 
ADD COLUMN `review_submitted_date` DATE NULL AFTER `review_note`;

============================================== 06/09/18 ===================================================
ALTER TABLE`users` 
ADD COLUMN `sf_id` VARCHAR(45) NULL ,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);

ALTER TABLE `staff` ADD COLUMN `sf_ids` JSON NULL ;

CREATE TABLE `stp_gender` (
  `id` INT(1) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(11) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
INSERT INTO `stp_gender` (`name`, `code`) VALUES ('Female', 'F');
INSERT INTO `stp_gender` (`name`, `code`) VALUES ('Male', 'M');
INSERT INTO `stp_gender` (`name`, `code`) VALUES ('Prefer Not To Respond', 'O');
INSERT INTO `stp_gender` (`name`, `code`) VALUES ('Transgender / Non-conforming', 'T');


ALTER TABLE `users` 
DROP FOREIGN KEY `FKrbachxgjwxcvfw47e1425qrgr`,
DROP FOREIGN KEY `FKo8tbedxu7bcw7uqj2s3iqorh0`,
DROP FOREIGN KEY `FKkmycmwth540xwo2w244f5vqtv`,
DROP FOREIGN KEY `FKek484if4ah4vxh88l7t6d0xdx`,
DROP FOREIGN KEY `FK5rdxrxyj4npmev040yj3si3a2`,
DROP FOREIGN KEY `FK536flv4s87i24ttocdmybfseb`;

ALTER TABLE `users` 
DROP FOREIGN KEY `fk_users_ref_table_data1`;


ALTER TABLE `users` 
CHANGE COLUMN `gender_id` `gender_id` INT(2) NULL DEFAULT NULL ;

ALTER TABLE `users` 
CHANGE COLUMN `user_name` `user_name` VARCHAR(50) NULL ;

CREATE TABLE `stp_race` (
  `id` INT(2) NOT NULL,
  `name` VARCHAR(50) NULL,
  `code` VARCHAR(2) NULL,
  `special_flag` VARCHAR(3) NULL,
  `old_id` INT(5) NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `stp_race` 
CHANGE COLUMN `id` `id` INT(2) NOT NULL AUTO_INCREMENT ,
CHANGE COLUMN `name` `name` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `code` `code` VARCHAR(2) NOT NULL ,
CHANGE COLUMN `old_id` `old_id` INT(5) NOT NULL ,
ADD UNIQUE INDEX `name_UNIQUE` (`name` ASC);

ALTER TABLE `stp_race` 
CHANGE COLUMN `old_id` `old_id` INT(5) NULL ;

INSERT INTO `stp_race` (`name`, `code`) VALUES ('American Indian or Alaska Native', 'AI');
INSERT INTO `stp_race` (`name`, `code`) VALUES ('Asian', 'AS');
INSERT INTO `stp_race` (`name`, `code`) VALUES ('Black or African American', 'BA');
INSERT INTO `stp_race` (`name`, `code`) VALUES ('Hispanic or Latino', 'HL');
INSERT INTO `stp_race` (`name`, `code`) VALUES ('Native Hawaiian or Other Pacific Islander', 'NH');
INSERT INTO `stp_race` (`name`, `code`) VALUES ('White', 'WH');
INSERT INTO `stp_race` (`name`, `code`, `special_flag`) VALUES ('Other Race', 'OR', 'O');


CREATE TABLE `stp_education` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(5) NULL,
  `special_flag` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));
  
  insert into stp_education (name, code, special_flag, old_id) select name, code, special_flag, old_id
  from ref_table_data where ref_table_code = 'EDC';
  
  ALTER TABLE `users` 
DROP FOREIGN KEY `fk_users_hedu`;
ALTER TABLE `users` 
DROP COLUMN `higher_education_id`,
DROP INDEX `fk_users_hedu_idx` ;


ALTER TABLE `users` 
ADD COLUMN `higher_education_id` INT(2) NULL AFTER `sf_id`,
ADD INDEX `fk_user_education_idx` (`higher_education_id` ASC);
ALTER TABLE `users` 
ADD CONSTRAINT `fk_user_education`
  FOREIGN KEY (`higher_education_id`)
  REFERENCES `stp_education` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


============================================ 06/10/18=============================================================================================
ALTER TABLE `ally` 
DROP FOREIGN KEY `FKt9nhgtxj8wiyt8kvq3w5yd3un`,
DROP FOREIGN KEY `FKswi0mo4l8vijn1wy4vs09r95`,
DROP FOREIGN KEY `FKqe0htn3gcmabkcc4ynj6cukta`,
DROP FOREIGN KEY `FKkw5xgs8wp8ojsb9q1vvb02kdy`,
DROP FOREIGN KEY `FKhtekgnb3a7j4145hy68e1lx6f`,
DROP FOREIGN KEY `FKgwpiipxehgsvmwu770nxj03q9`,
DROP FOREIGN KEY `FKdrj6x6fe4vw64whk003dct73c`,
DROP FOREIGN KEY `FKa6phi8qoqwk7v0hwvddejmgw7`,
DROP FOREIGN KEY `FK6tnwj7ptcotogwhdncfqiyccj`,
DROP FOREIGN KEY `FK1mr2dy2d8jsjf7nma6nmxjl2y`;


CREATE TABLE `stp_employ_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(5) NULL,
  `special_flag` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));
  
  ALTER TABLE `stp_employ_status` 
CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL ;

  insert into stp_employ_status (name, code, special_flag, old_id) select name, code, special_flag, old_id
  from ref_table_data where ref_table_code = 'EMP';

  
  CREATE TABLE `stp_marital_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(5) NULL,
  `special_flag` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));
  
  ALTER TABLE `stp_marital_status` 
CHANGE COLUMN `name` `name` VARCHAR(150) NOT NULL ;

  insert into stp_marital_status (name, code, special_flag, old_id) select name, code, special_flag, old_id
  from ref_table_data where ref_table_code = 'MRT';

  
    CREATE TABLE `stp_social_assist` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(5) NULL,
  `special_flag` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));
  
  insert into stp_social_assist (name, code, special_flag, old_id) select name, code, special_flag, old_id
  from ref_table_data where ref_table_code = 'SAS';

     CREATE TABLE `stp_common_period` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(2) NULL,
  `old_id` INT(5) NULL,
  `special_flag` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));
  
  ALTER TABLE `stp_common_period` 
CHANGE COLUMN `name` `name` VARCHAR(150) NOT NULL ;
  
  insert into stp_common_period (name, code, special_flag, old_id) select name, code, special_flag, old_id
  from ref_table_data where ref_table_code = 'UEP';
  
  update ally set employment_status_id = null, unemployment_period= null, enrolled_college_period = null, marital_status_id= null, employment_period = null;
  update ally set social_assists = null;
  
  ALTER TABLE `ally` 
DROP FOREIGN KEY `fk_ally_college_period`,
DROP FOREIGN KEY `fk_ally_employ_period`,
DROP FOREIGN KEY `fk_ally_emply_staus`,
DROP FOREIGN KEY `fk_ally_matial1`,
DROP FOREIGN KEY `fk_ally_ref_table_data1`,
DROP FOREIGN KEY `fk_ally_unemply_period`;
ALTER TABLE `ally` 
CHANGE COLUMN `highest_education` `highest_education` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `employment_status_id` `employment_status_id` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `unemployment_period` `unemployment_period` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `enrolled_college_period` `enrolled_college_period` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `employment_period` `employment_period` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `marital_status_id` `marital_status_id` INT(2) NULL DEFAULT NULL ;
ALTER TABLE `ally` 
ADD CONSTRAINT `fk_ally_college_period`
  FOREIGN KEY (`enrolled_college_period`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_employ_period`
  FOREIGN KEY (`employment_period`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_emply_staus`
  FOREIGN KEY (`employment_status_id`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_matial1`
  FOREIGN KEY (`marital_status_id`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_ref_table_data1`
  FOREIGN KEY (`highest_education`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_unemply_period`
  FOREIGN KEY (`unemployment_period`)
  REFERENCES `ref_table_data` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `ally` 
DROP FOREIGN KEY `fk_ally_college_period`,
DROP FOREIGN KEY `fk_ally_employ_period`,
DROP FOREIGN KEY `fk_ally_emply_staus`,
DROP FOREIGN KEY `fk_ally_matial1`;
ALTER TABLE `ally` 
ADD INDEX `fk_ally_college_period_idx` (`enrolled_college_period` ASC),
ADD INDEX `fk_ally_employ_period_idx` (`employment_period` ASC),
ADD INDEX `fk_ally_emply_staus_idx` (`employment_status_id` ASC),
ADD INDEX `fk_ally_matial1_idx` (`marital_status_id` ASC),
DROP INDEX `fk_ally_emply_staus_idx` ,
DROP INDEX `fk_ally_college_period_idx` ,
DROP INDEX `fk_ally_employ_period_idx` ,
DROP INDEX `fk_ally_matial1_idx` ;
ALTER TABLE `ally` 
ADD CONSTRAINT `fk_ally_college_period`
  FOREIGN KEY (`enrolled_college_period`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_employ_period`
  FOREIGN KEY (`employment_period`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_emply_staus`
  FOREIGN KEY (`employment_status_id`)
  REFERENCES `stp_employ_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ally_matial1`
  FOREIGN KEY (`marital_status_id`)
  REFERENCES `stp_marital_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `ally` 
DROP FOREIGN KEY `fk_ally_ref_table_data1`;
ALTER TABLE `ally` 
DROP COLUMN `highest_education`,
DROP INDEX `fk_ally_ref_table_data1_idx` ;

ALTER TABLE `users` 
CHANGE COLUMN `phone_home` `phone_home` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `phone_cell` `phone_cell` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `phone_office` `phone_office` VARCHAR(30) NULL DEFAULT NULL ;

ALTER TABLE `contact` 
CHANGE COLUMN `phone_home` `phone_home` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `phone_cell` `phone_cell` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `phone_office` `phone_office` VARCHAR(30) NULL DEFAULT NULL ;

ALTER TABLE `partner` 
CHANGE COLUMN `phone_office` `phone_office` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `phone_cell` `phone_cell` VARCHAR(30) NULL DEFAULT NULL ;

ALTER TABLE `site` 
DROP FOREIGN KEY `FKcs91j3wko3xqlhey6mjqd2xcr`,
DROP FOREIGN KEY `fk_site_state1`;
ALTER TABLE `site` 
CHANGE COLUMN `state_id` `state_id` TINYINT(2) NULL ;
ALTER TABLE `site` 
ADD CONSTRAINT `FKcs91j3wko3xqlhey6mjqd2xcr`
  FOREIGN KEY (`state_id`)
  REFERENCES `state` (`id`),
ADD CONSTRAINT `fk_site_state1`
  FOREIGN KEY (`state_id`)
  REFERENCES `state` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `users` 
CHANGE COLUMN `address1` `address1` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `contact` 
CHANGE COLUMN `address1` `address1` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `partner` 
CHANGE COLUMN `address1` `address1` VARCHAR(100) NULL DEFAULT NULL ;

================================================== 06/16/18 ===========================================================
ALTER TABLE `partner` 
DROP FOREIGN KEY `FKq9yn5ta9qf8wggjicfspa9xeu`,
DROP FOREIGN KEY `FKeiuueap8oys7ac9hbq809y7vl`,
DROP FOREIGN KEY `FKau0xlllb5kl6usiojyy8j8jvf`,
DROP FOREIGN KEY `FKaloqo9o6aeqj8662stlbecmfu`,
DROP FOREIGN KEY `FK888jetjokyt27nofgebsd0mvw`,
DROP FOREIGN KEY `FK86o78083wlw8yj2u07e0iiee7`,
DROP FOREIGN KEY `FK81v2tt0cx3mon03o2c27r7sos`,
DROP FOREIGN KEY `FK5tm2jm1qtx1h6r58wfu9jth99`,
DROP FOREIGN KEY `FK1rmr5ra7f23a2bwfrwl0tm6q0`;


ALTER TABLE `partner` 
DROP FOREIGN KEY `fk_partner_contact1`;
ALTER TABLE `partner` 
CHANGE COLUMN `contact_id` `gen_contact_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `partner` 
ADD CONSTRAINT `fk_partner_contact1`
  FOREIGN KEY (`gen_contact_id`)
  REFERENCES `contact` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  ALTER TABLE `partner` 
DROP FOREIGN KEY `fk_partner_contact1`;
ALTER TABLE `partner` 
CHANGE COLUMN `gen_contact_id` `contact_gen_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `partner` 
ADD CONSTRAINT `fk_partner_contact1`
  FOREIGN KEY (`contact_gen_id`)
  REFERENCES `contact` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  =============================================== 06/23/18 ==========================================================
  ALTER TABLE `program_year` 
CHANGE COLUMN `title` `title` VARCHAR(75) NULL DEFAULT NULL ;

UPDATE `graduate_status` SET `name`='In Program [Extended]' WHERE name like '%In Program%exten%';

UPDATE `stp_employ_status` SET `name`='Employed Full-Time' WHERE name like '%Full%tim%';
UPDATE `stp_employ_status` SET `name`='Employed Part-Time' WHERE name like '%part%time%'

UPDATE `stp_education` SET `name`='Associates Degree' WHERE name like '%Associat%degr%';
UPDATE `stp_education` SET `name`='Bachelors Degree' WHERE name like '%Bachelor%degr%';
UPDATE `stp_education` SET `name`='Some college' WHERE name like '%some%coll%';
INSERT INTO `stp_education` (`name`, `special_flag`) VALUES ('Doctoral Degree', '2');
UPDATE `stp_education` SET `name`='Technical school/apprenticeship' WHERE name like '%Technical%appr%';

UPDATE `stp_common_period` SET `name`='Less then 1 month' WHERE name like '%less%month%';

alter table ally_profile_history add status_end_date date;


=========================================================== 06/30/18=====================================================
ALTER TABLE `ally` 
ADD COLUMN `alumni_sfId` VARCHAR(45) NULL,
ADD UNIQUE INDEX `alumni_sfId_UNIQUE` (`alumni_sfId` ASC);

ALTER TABLE `ally_profile` 
ADD COLUMN `sf_id` VARCHAR(45) NULL AFTER `ally_exit_reason_id`,
ADD UNIQUE INDEX `sf_id_UNIQUE` (`sf_id` ASC);

ALTER TABLE `partner_supervisor` 
ADD COLUMN `sf_ids` JSON NULL AFTER `site_ids`;
UPDATE `stp_race` SET `name`='American Indian or Alaskan Native' WHERE `id`='1';

ALTER TABLE `program_year` 
CHANGE COLUMN `title` `title` VARCHAR(100) NULL DEFAULT NULL ;


===================================== 07/06/18=========================================================================
UPDATE `atomic_user_role` SET `name`='National Team' WHERE `code`='NA';
update stp_race set name = ' Hispanic or Latino / Latina / Latinx' where code = 'HL';
ALTER TABLE `stp_gender` ADD COLUMN `active_flag` BIT(1) default true;
update `stp_gender` set `active_flag` = false where code in ('T', 'O');
INSERT INTO `stp_gender` (`name`, `code`) VALUES ('Prefer to Self-Describe', 'D');

ALTER TABLE `users` CHANGE COLUMN `race_other` `race_other` VARCHAR(80) NULL DEFAULT NULL ,
ADD COLUMN `gender_other` VARCHAR(80) NULL;

CREATE TABLE `stp_sex_orientation` (
  `id` INT(2) NOT NULL,
  `name` VARCHAR(45) NULL,
  `code` CHAR(1) NULL,
  `active_flag` BIT(1) NULL DEFAULT true,
  PRIMARY KEY (`id`));
  ALTER TABLE `stp_sex_orientation` CHANGE COLUMN `id` `id` INT(2) NOT NULL AUTO_INCREMENT ;
  
  INSERT INTO `stp_sex_orientation` (`name`) VALUES ('Straight / Heterosexual');
INSERT INTO `stp_sex_orientation` (`name`) VALUES ('Gay, Lesbian, or Bisexual');
INSERT INTO `stp_sex_orientation` (`name`, `code`) VALUES ('Prefer to self-describe', 'S');

ALTER TABLE `users` ADD COLUMN `sex_orientation_other` VARCHAR(80) NULL;
UPDATE `stp_education` SET `name`='Graduate Degree or Doctorate Degree' WHERE name like '%doctora%';
ALTER TABLE `stp_education` 
ADD COLUMN `active_flag` BIT(1) NULL DEFAULT false ;

UPDATE `stp_education` SET `active_flag`=true WHERE `id`='1';
UPDATE `stp_education` SET `active_flag`=true WHERE `id`='2';
UPDATE `stp_education` SET `active_flag`=true WHERE `id`='3';
UPDATE `stp_education` SET `active_flag`=true WHERE `id`='4';
UPDATE `stp_education` SET `active_flag`=true WHERE `id`='11';

INSERT INTO `stp_common_period` (`name`, `special_flag`) VALUES ('Never', 'N');


ALTER TABLE `users` 
ADD COLUMN `sex_orientation_id` INT(2) NULL AFTER `sex_orientation_other`,
ADD INDEX `fk_user_sex_or_idx` (`sex_orientation_id` ASC);
ALTER TABLE `users` 
ADD CONSTRAINT `fk_user_sex_or`
  FOREIGN KEY (`sex_orientation_id`)
  REFERENCES `stp_sex_orientation` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


UPDATE`stp_gender` SET `active_flag`=true WHERE `id`='4';


ALTER TABLE `stp_sex_orientation` 
ADD COLUMN `specifical_flag` VARCHAR(4);

ALTER TABLE `stp_gender` 
ADD COLUMN `special_flag` VARCHAR(4);

UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='1';
UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='2';
UPDATE `stp_gender` SET `active_flag`=true, `special_flag`='PS' WHERE `id`='3';

INSERT INTO `stp_sex_orientation` (`name`, `specifical_flag`) VALUES ('Prefer Not To Respond', 'PS');
UPDATE `stp_sex_orientation` SET `specifical_flag`='APS' WHERE `id`='1';
UPDATE `stp_sex_orientation` SET `specifical_flag`='APS' WHERE `id`='2';
UPDATE `stp_sex_orientation` SET `specifical_flag`='APS' WHERE `id`='3';




CREATE TABLE `supervisor_term` (
  `supervisor_id` INT(11) NOT NULL,
  `c_position_period_id` INT(2) NULL,
  `p_position_period_id` INT(2) NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `term_id` SMALLINT(3) NULL,
  PRIMARY KEY (`id`, `supervisor_id`),
  INDEX `sup_term_idx` (`term_id` ASC),
  INDEX `sup_c_period_idx` (`c_position_period_id` ASC),
  INDEX `sup_p_period_idx` (`p_position_period_id` ASC),
  INDEX `sup_sup_term_idx` (`supervisor_id` ASC),
  UNIQUE INDEX `sup_term_unique` (`supervisor_id` ASC, `term_id` ASC),
  CONSTRAINT `sup_term`
    FOREIGN KEY (`term_id`)
    REFERENCES `term` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sup_c_period`
    FOREIGN KEY (`c_position_period_id`)
    REFERENCES `stp_common_period` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
      CONSTRAINT `sup_sup_term`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `partner_supervisor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sup_p_period`
    FOREIGN KEY (`p_position_period_id`)
    REFERENCES `stp_common_period` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    ALTER TABLE 
`supervisor_term` 
DROP FOREIGN KEY `sup_term`;
ALTER TABLE `supervisor_term` 
CHANGE COLUMN `term_id` `term_id` SMALLINT(3) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`);
ALTER TABLE `supervisor_term` 
ADD CONSTRAINT `sup_term`
  FOREIGN KEY (`term_id`)
  REFERENCES `term` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  ALTER TABLE `stp_sex_orientation` 
CHANGE COLUMN `specifical_flag` `special_flag` VARCHAR(4) NULL DEFAULT NULL ;

UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='5';
UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='4';

UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='5';
UPDATE `stp_gender` SET `special_flag`='APS' WHERE `id`='4';
INSERT INTO `stp_gender` (`name`, `code`, `active_flag`, `special_flag`) VALUES ('Non-binary / Third Gender', 'B', true, 'APS');
UPDATE `stp_gender` SET `active_flag`=false WHERE `id`='4';



ALTER TABLE `users` 
CHANGE COLUMN `disability_flag` `disability_flag` TINYINT(1) NULL DEFAULT '3' ,
CHANGE COLUMN `lgbtq_flag` `lgbtq_flag` TINYINT(1) NULL DEFAULT '3' ;

==================================== 07/07/18==============================================================
ALTER TABLE `supervisor_term` 
ADD COLUMN `created_at` DATETIME NULL AFTER `term_id`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;


ALTER TABLE `partner_supervisor` 
ADD COLUMN `c_position_period_id` INT(2) NULL AFTER `sf_ids`,
ADD COLUMN `p_position_period_id` INT(2) NULL AFTER `c_position_period_id`,
ADD INDEX `fk_sup_cPosition_idx` (`c_position_period_id` ASC),
ADD INDEX `fk_sup_pPostion_idx` (`p_position_period_id` ASC) ;
ALTER TABLE `partner_supervisor` 
ADD CONSTRAINT `fk_sup_cPosition`
  FOREIGN KEY (`c_position_period_id`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_sup_pPostion`
  FOREIGN KEY (`p_position_period_id`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


================================================07/08/18================================================================
UPDATE `stp_employ_status` SET `code`='EF', `special_flag`='EF' WHERE `id`='1';
UPDATE `stp_employ_status` SET `code`='EF', `special_flag`='EP' WHERE `id`='2';
UPDATE `stp_employ_status` SET `code`='UP', `special_flag`='U' WHERE `id`='3';

=================================================== 07/09/18=====================================================
INSERT INTO `atomic_access` (`code`, `name`) VALUES ('SGU', 'Search Users');


ALTER TABLE `job_objective_output` 
CHANGE COLUMN `job_objective_id` `job_objective_id` INT(11) NOT NULL ,
ADD INDEX `fk_joo1_idx` (`job_objective_id` ASC);
ALTER TABLE `job_objective_output` 
ADD CONSTRAINT `fk_joo_jo`
  FOREIGN KEY (`job_objective_id`)
  REFERENCES `job_objective` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `job_objective_output` 
ADD CONSTRAINT `fk_joo_outputmeasure`
  FOREIGN KEY (`output_measure_id`)
  REFERENCES `output_measure` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `job_objective_output` 
ADD UNIQUE INDEX `Unique joo1` (`output_measure_id` ASC, `job_objective_id` ASC);

==================================================== 07/17/18======================================================
ALTER TABLE `job` 
ADD COLUMN `partner_fee` DECIMAL(10,2) NULL;

ALTER TABLE `ally_profile` 
ADD COLUMN `anticipated_graduation_date` DATE NULL;

====================================================== 07/22/18=========================================
update activity_area set name = 'Program Development, Delivery and Evaluation' where id=9;
update activity_area set name = 'Volunteer Management ' where id=3;

================================================== 07/23/18==================================================
INSERT INTO `env_properties` (`keycode`, `keyValue`) VALUES ('SF_END_POINT', 'https://test.salesforce.com/services/Soap/u/42.0');
INSERT INTO `env_properties` (`keycode`, `keyValue`) VALUES ('SF_TOKEN', 'F2obdosJ9W6oAxY26b7JKjLsY');
INSERT INTO `env_properties` (`keycode`, `keyValue`) VALUES ('SF_PASSWORD', 'LetmeinSalesforce!1');
INSERT INTO `env_properties` (`keycode`, `keyValue`) VALUES ('SF_USERNAME', 'wilsakovi@gmail.com.design');

====================================================== 07/30/18 =======================================================
update document_type set active_flag = 1, sort_order = 99 where display_name  like '%other documents%';
ALTER TABLE `ally` ADD COLUMN `self_update_date` DATETIME NULL;
ALTER TABLE `partner_supervisor` ADD COLUMN `self_update_date` DATETIME NULL;

============================================= 08/04/18========================================
ALTER TABLE `acts_objective` 
ADD COLUMN `submitted_flag` BIT(1) NULL DEFAULT false AFTER `final_comment`;

=================================================== 08/11/18===================================================
ALTER TABLE `partner_supervisor` 
DROP FOREIGN KEY `fk_sup_pPostion`,
DROP FOREIGN KEY `fk_sup_cPosition`;
ALTER TABLE `partner_supervisor` 
CHANGE COLUMN `c_position_period_id` `c_position_period` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `p_position_period_id` `p_position_period` INT(2) NULL DEFAULT NULL ,
DROP INDEX `fk_sup_pPostion_idx` ,
DROP INDEX `fk_sup_cPosition_idx` ;


ALTER TABLE `supervisor_term` 
DROP FOREIGN KEY `sup_p_period`,
DROP FOREIGN KEY `sup_c_period`;
ALTER TABLE `supervisor_term` 
CHANGE COLUMN `c_position_period_id` `c_position_period` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `p_position_period_id` `p_position_period` INT(2) NULL DEFAULT NULL ,
DROP INDEX `sup_p_period_idx` ,
DROP INDEX `sup_c_period_idx` ;


ALTER TABLE `partner` ADD COLUMN `ein` VARCHAR(15) NULL default null;

ALTER TABLE `pay_period` DROP INDEX `UK2l61mac4qt49pqyxb9f8r01jh` ;


ALTER TABLE `users` 
ADD COLUMN `active_flag` BIT(1) NULL DEFAULT true ,
ADD COLUMN `acr_flag` BIT(1) NULL DEFAULT false;

UPDATE `ref_table_data` SET `name`='TSP - no Fundraising' WHERE `name`='TSP';
UPDATE `ref_table_data` SET `name`='Fundraising - no Fundraising' WHERE `name`='Fundraising';

ALTER TABLE `users` CHANGE COLUMN `active_flag` `active_login_flag` BIT(1) NULL DEFAULT true ;


============================================================= 08/12/18 ===================================
ALTER TABLE `acts_objective` 
CHANGE COLUMN `description` `description` TEXT NULL ,
CHANGE COLUMN `category_ids` `category_ids` JSON NULL ,
ADD COLUMN `job_objective_id` INT(11) NULL AFTER `submitted_flag`,
ADD INDEX `fk_job_objective_idx` (`job_objective_id` ASC);
ALTER TABLE `acts_objective` 
ADD CONSTRAINT `fk_job_objective`
  FOREIGN KEY (`job_objective_id`)
  REFERENCES `job_objective` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  ALTER TABLE `msr_job_objective` 
DROP FOREIGN KEY `fk_msr_job_objective_msr1`;
ALTER TABLE `msr_job_objective` 
DROP COLUMN `msr_id`,
ADD COLUMN `success_comment` TEXT NULL,
ADD COLUMN `leraning_comment` TEXT NULL,
DROP INDEX `fk_msr_job_objective_msr1` ,
DROP INDEX `msr_id` ;

ALTER TABLE `msr_job_objective` 
ADD COLUMN `act_report_id` INT(11) NULL ,
ADD INDEX `fk_msr_jj_act_report_idx` (`act_report_id` ASC);
ALTER TABLE `msr_job_objective` 
ADD CONSTRAINT `fk_msr_jj_act_report`
  FOREIGN KEY (`act_report_id`)
  REFERENCES `acts_report` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
UPDATE `ref_table_data` SET `name`='Placement - (No Fundraising)' WHERE `name`='Placement';
UPDATE `ref_table_data` SET `name`='TSP - (No Fundraising)' WHERE `name`='TSP - no Fundraising';
UPDATE `ref_table_data` SET `name`='Fundraising' WHERE `name`='Fundraising - no Fundraising';


UPDATE `stp_marital_status` SET `code`='SN' WHERE `id`='4';
UPDATE `stp_marital_status` SET `code`='MN' WHERE `id`='3';
UPDATE `stp_marital_status` SET `code`='SC' WHERE `id`='1';
UPDATE `stp_marital_status` SET `code`='MC' WHERE `id`='2';

ALTER TABLE `ally` ADD COLUMN `child_count` INT(3) NULL AFTER `self_update_date`;

ALTER TABLE `msr_job_objective` ADD COLUMN `msr_id` INT(11) NULL;
ALTER TABLE `msr_job_objective` 
ADD CONSTRAINT `fk_msr_msrobjective`
  FOREIGN KEY (`msr_id`)
  REFERENCES `msr` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `msr` CHANGE COLUMN `history_json` `history` JSON NULL DEFAULT NULL ;
ALTER TABLE `msr_pathways` ADD COLUMN `history` JSON NULL;
ALTER TABLE `msr_job_objective` ADD COLUMN `history` JSON NULL;

ALTER TABLE `msr` CHANGE COLUMN `is_approved` `is_approved` BIT(1) NULL DEFAULT false ;

==================================== 08/12/18==============================
insert into ally_exit_reason (name) values("Performance issues");
insert into ally_exit_reason (name) values("Personal issues");
insert into ally_exit_reason (name) values("Accepted a new job");
insert into ally_exit_reason (name) values("Attending school");
insert into ally_exit_reason (name) values("Loss of Partner Organization");
insert into ally_exit_reason (name) values("Member dissatisfaction with Partner Organization");
insert into ally_exit_reason (name) values("Member dissatisfaction with Public Allies");

=========================================08/15/18================================
UPDATE `env_properties` SET `keyValue`='DOC,DOCX,PDF,PPT,PPTX,PPS,TIF,CSV,XLS,XLSX,GIF,JPG,JPEG,PNG' WHERE keycode='FILE_EXTENSION';


===========================================08/18/18==============================================================================
ALTER TABLE `users` 
CHANGE COLUMN `address2` `address2` VARCHAR(25) NULL DEFAULT NULL ,
CHANGE COLUMN `perm_address_street` `perm_address_street` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `perm_address_street2` `perm_address_street2` VARCHAR(25) NULL DEFAULT NULL ;

================================================= 08/25/18 ==============================================================
ALTER TABLE `ally_profile_job_history` 
DROP COLUMN `end_date`,
DROP COLUMN `start_date`;

==================================================== 90/01/18=========================================================
ALTER TABLE `msr_output` CHANGE COLUMN `total_output` `total_output` INT NULL ;
ALTER TABLE `msr_job_objective` CHANGE COLUMN `leraning_comment` `learning_comment` TEXT NULL DEFAULT NULL ;

ALTER TABLE `msr_job_objective` 
DROP FOREIGN KEY `fk_msr_jj_act_report`;
ALTER TABLE `msr_job_objective` 
CHANGE COLUMN `act_report_id` `acts_report_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `msr_job_objective` 
ADD CONSTRAINT `fk_msr_jj_act_report`
  FOREIGN KEY (`acts_report_id`)
  REFERENCES `acts_report` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

============================================================ 09/02/18 ===================================================
CREATE TABLE `msr_partnership` (
  `id` INT(11) NOT NULL,
  `msr_id` INT(11) NOT NULL,
  `contact_name` VARCHAR(85) NULL,
  `organization` VARCHAR(150) NULL,
  `support_detail` TEXT NULL,
  `future_action` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `contact_personal_flag` BIT(1) NULL,
  `contact_org_falg` BIT(1) NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `msr_partnership`
  ADD CONSTRAINT `fk_msr_partnership`
  FOREIGN KEY (`msr_id`)
  REFERENCES `msr` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `msr_partnership` 
CHANGE COLUMN `contact_org_falg` `contact_org_flag` BIT(1) NULL DEFAULT NULL ;


ALTER TABLE `msr_partnership` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;



ALTER TABLE `msr_snapshot` ADD UNIQUE INDEX `msr_id_UNIQUE` (`msr_id` ASC);

ALTER TABLE `msr_snapshot` CHANGE COLUMN `ally_profile_id` `ally_profile_id` INT(11) NULL ;

ALTER TABLE `msr_volunteer` 
DROP COLUMN `percentage_local`,
DROP COLUMN `total_active_volunteer`,
DROP COLUMN `peope_served`,
DROP COLUMN `total_new_recruited`,
ADD COLUMN `volunteer_in_org` INT(8) NULL AFTER `old_id`,
ADD COLUMN `volunteer_out_org` INT(8) NULL AFTER `volunteer_in_org`;

CREATE TABLE `stp_training_type` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` CHAR(1) NULL,
  `active_flag` BIT(1) NULL DEFAULT true,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `msr_training` 
CHANGE COLUMN `training_type` `training_type` INT(2) NULL DEFAULT NULL ,
ADD INDEX `fk_training_type_idx` (`training_type` ASC);
ALTER TABLE `msr_training` 
ADD CONSTRAINT `fk_training_type`
  FOREIGN KEY (`training_type`)
  REFERENCES `stp_training_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `msr` 
ADD COLUMN `approved_pm_users_id` INT(11) NULL ,
ADD COLUMN `approved_pos_users_id` INT(11) NULL ;

  


ALTER TABLE `msr` 
CHANGE COLUMN `pos_approval_date` `pos_approved_date` DATETIME NULL DEFAULT NULL ,
CHANGE COLUMN `pm_approval_date` `pm_approved_date` DATETIME NULL DEFAULT NULL ;

ALTER TABLE `pay_period` 
DROP FOREIGN KEY `FKq4a80or4u6cfj7th7cwbh10w6`,
DROP FOREIGN KEY `FKoj4uagt5jafvghj6tfpqnwiwe`,
DROP FOREIGN KEY `FKltv9j1l6mtrws7wsi7pele3j8`,
DROP FOREIGN KEY `FKkcrejlhu3s9rxmu6rsn0ichb2`;

ALTER TABLE `pay_period` 
DROP COLUMN `pos_approval_status_id`,
DROP COLUMN `pm_approval_status_id`,
DROP COLUMN `pay_period_status_id`,
DROP COLUMN `ally_submit_status_id`,
DROP INDEX `FKltv9j1l6mtrws7wsi7pele3j8` ,
DROP INDEX `FKkcrejlhu3s9rxmu6rsn0ichb2` ,
DROP INDEX `FKoj4uagt5jafvghj6tfpqnwiwe` ,
DROP INDEX `FKq4a80or4u6cfj7th7cwbh10w6` ;

============================================================ 09/04/18======================================
update graduate_status set active_reporting_flag = 1 where id = 40;
ALTER TABLE `stp_training_type` CHANGE COLUMN `name` `name` VARCHAR(150) NULL DEFAULT NULL ;

insert into stp_training_type(name, code) values ('Leadership Action #1: Intro to Systemic Oppression', null);
insert into stp_training_type(name, code) values ('Leadership Action #2: Intro to Inclusive Spaces', null);
insert into stp_training_type(name, code) values ('Leadership Action #3: Intro to Constructive Engagement', null);
insert into stp_training_type(name, code) values ('Leadership Action #4: Intro to Accountability', null);
insert into stp_training_type(name, code) values ('Leadership Action #5: Intro to Catalyzing Strengths', null);
insert into stp_training_type(name, code) values ('Leadership Action #6: Intro to Collaboration', null);
insert into stp_training_type(name, code) values ('Leadership Action #7: Intro to Partnerships', null);
insert into stp_training_type(name, code) values ('Leadership Action #8: Intro to Continuous Learning', null);
insert into stp_training_type(name, code) values ('Leadership Action #9: Intro to Give and Receive Feedback', null);
insert into stp_training_type(name, code) values ('Leadership Action #10: Intro to Innovation', null);
insert into stp_training_type(name, code) values ('The +1: Self-Care', null);
insert into stp_training_type(name, code) values ('Other', 'O');

========================================================== 09/08/18 ===============================================

ALTER TABLE `msr_training` 
CHANGE COLUMN `understand_level` `understand_level` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `confidence_level` `confidence_level` INT(1) NULL DEFAULT NULL ;

ALTER TABLE `msr` 
ADD COLUMN `pa_satisfaction` VARCHAR(15) NULL AFTER `approved_pos_users_id`,
ADD COLUMN `org_satisfaction` VARCHAR(15) NULL AFTER `pa_satisfaction`;

ALTER TABLE `msr_training` 
DROP COLUMN `ally_profile_id`,
DROP COLUMN `activity_description`;

ALTER TABLE `msr` 
ADD COLUMN `final_comment` TEXT NULL AFTER `org_satisfaction`;

=================================================================== 09/09/18======================================
ALTER TABLE `msr_job_objective` 
ADD COLUMN `pos_comment` TEXT NULL,
ADD COLUMN `staff_comment` TEXT NULL,
ADD COLUMN `pos_user_id` INT(11) NULL,
ADD COLUMN `staff_user_id` INT(11) NULL,
ADD COLUMN `pos_comment_date` DATE NULL,
ADD COLUMN `staff_comment_date` DATE NULL;

ALTER TABLE `msr_training` 
ADD COLUMN `pos_comment` TEXT NULL,
ADD COLUMN `staff_comment` TEXT NULL,
ADD COLUMN `pos_user_id` INT(11) NULL,
ADD COLUMN `staff_user_id` INT(11) NULL,
ADD COLUMN `pos_comment_date` DATE NULL,
ADD COLUMN `staff_comment_date` DATE NULL;

ALTER TABLE `msr_snapshot` 
ADD COLUMN `pos_comment` TEXT NULL,
ADD COLUMN `staff_comment` TEXT NULL,
ADD COLUMN `pos_user_id` INT(11) NULL,
ADD COLUMN `staff_user_id` INT(11) NULL,
ADD COLUMN `pos_comment_date` DATE NULL,
ADD COLUMN `staff_comment_date` DATE NULL;

ALTER TABLE `msr_volunteer` 
ADD COLUMN `pos_comment` TEXT NULL,
ADD COLUMN `staff_comment` TEXT NULL,
ADD COLUMN `pos_user_id` INT(11) NULL,
ADD COLUMN `staff_user_id` INT(11) NULL,
ADD COLUMN `pos_comment_date` DATE NULL,
ADD COLUMN `staff_comment_date` DATE NULL;

ALTER TABLE `msr_pathways` 
ADD COLUMN `pos_comment` TEXT NULL,
ADD COLUMN `staff_comment` TEXT NULL,
ADD COLUMN `pos_user_id` INT(11) NULL,
ADD COLUMN `staff_user_id` INT(11) NULL,
ADD COLUMN `pos_comment_date` DATE NULL,
ADD COLUMN `staff_comment_date` DATE NULL;


ALTER TABLE `msr` 
ADD COLUMN `pos_final_comment` TEXT NULL AFTER `final_comment`,
ADD COLUMN `pm_final_comment` TEXT NULL AFTER `pos_final_comment`;

ALTER TABLE `msr` 
ADD COLUMN `pos_member_satisfaction` VARCHAR(15) NULL AFTER `pm_final_comment`;


ALTER TABLE `msr` 
CHANGE COLUMN `pm_final_comment` `staff_final_comment` TEXT NULL DEFAULT NULL ,
ADD COLUMN `pos_partnership_comment` TEXT NULL AFTER `pos_member_satisfaction`,
ADD COLUMN `staff_partnership_comment` TEXT NULL AFTER `pos_partnership_comment`,
ADD COLUMN `pos_training_comment` TEXT NULL AFTER `staff_partnership_comment`,
ADD COLUMN `staff_training_comment` TEXT NULL AFTER `pos_training_comment`,
ADD COLUMN `staff_pc_users_id` INT(11) NULL AFTER `staff_training_comment`,
ADD COLUMN `pos_pc_user_id` INT(11) NULL AFTER `staff_pc_users_id`,
ADD COLUMN `staf_training_user_id` INT(11) NULL AFTER `pos_pc_user_id`,
ADD COLUMN `pos_training_user_id` INT(11) NULL AFTER `staf_training_user_id`;

ALTER TABLE `msr_training` 
DROP COLUMN `staff_comment_date`,
DROP COLUMN `pos_comment_date`,
DROP COLUMN `staff_user_id`,
DROP COLUMN `pos_user_id`,
DROP COLUMN `staff_comment`,
DROP COLUMN `pos_comment`;


ALTER TABLE `msr` 
CHANGE COLUMN `staff_pc_users_id` `staff_pc_user_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `msr` 
CHANGE COLUMN `staf_training_user_id` `staff_training_user_id` INT(11) NULL DEFAULT NULL ;

================================================9/16/18========================================
ALTER TABLE `msr` 
ADD COLUMN `pos_approval_comment` TEXT NULL AFTER `pos_training_user_id`,
ADD COLUMN `staff_approval_comment` TEXT NULL AFTER `pos_approval_comment`;

CREATE TABLE `login_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `username` VARCHAR(100) NULL,
  `users_id` INT(11) NULL,
  `roles` VARCHAR(100) NULL,
  `resources` VARCHAR(200) NULL,
  `role_type` VARCHAR(20) NULL,
  denied int(1) default 1,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `login_log` 
ADD COLUMN `users_id` INT(11) NULL;


CREATE TABLE `stp_pathways_type` (
  `id` INT(1) NOT NULL,
  `code` CHAR(2) NULL,
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`id`));

  
INSERT INTO `stp_pathways_type` (`id`, `code`, `name`) VALUES ('1', 'ED', 'Pursue further education  at either a 2 or 4-year institution or a trade-school');
INSERT INTO `stp_pathways_type` (`id`, `code`, `name`) VALUES ('2', 'EP', 'Obtain employment aligned with your career aspirations');
INSERT INTO `stp_pathways_type` (`id`, `code`, `name`) VALUES ('3', 'DP', 'Both obtain employment aligned with your career aspiration & pursue further education - at either a 2 or 4 institution or trade-school');
INSERT INTO `stp_pathways_type` (`id`, `code`, `name`) VALUES ('4', 'NS', 'Complete another year of National Service');

ALTER TABLE `msr_pathways` 
ADD COLUMN `pathway_type_code` CHAR(2) NULL AFTER `staff_comment_date`;


========================================================== 09/17/18==================================================================================
ALTER TABLE `graduate_status` 
ADD COLUMN `active_flag` INT(1) NOT NULL DEFAULT 1;

UPDATE `graduate_status` SET `active_flag`='0' WHERE `id`=20;

=========================================09/21/18============================================================
ALTER TABLE `msr_pathways` CHANGE COLUMN `pathway_type_code` `pathway_type_code` CHAR(2) NOT NULL ;

CREATE TABLE `stp_position_type` (
  `id` INT(1) NOT NULL,
  `code` CHAR(2) NULL,
  `name` VARCHAR(180) NULL,
  PRIMARY KEY (`id`));

  
INSERT INTO `stp_position_type` (`id`, `code`, `name`) VALUES ('1', 'FB', 'Full-time with benefits (permanent position)');
INSERT INTO `stp_position_type` (`id`, `code`, `name`) VALUES ('2', 'FN', 'Full-time without benefits (permanent position)');
INSERT INTO `stp_position_type` (`id`, `code`, `name`) VALUES ('3', 'PB', 'Part-time with benefits (permanent position)');
INSERT INTO `stp_position_type` (`id`, `code`, `name`) VALUES ('4', 'PN', 'Part-time without benefits (permanent position)');
INSERT INTO `stp_position_type` (`id`, `code`, `name`) VALUES ('5', 'TS', 'Temporary / seasonal / contract');

ALTER TABLE `stp_position_type` 
CHANGE COLUMN `code` `code` CHAR(2) NOT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(80) NOT NULL ,
ADD UNIQUE INDEX `code_UNIQUE` (`code` ASC);

ALTER TABLE `stp_pathways_type` 
CHANGE COLUMN `code` `code` CHAR(2) NOT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(150) NOT NULL ,
ADD UNIQUE INDEX `code_UNIQUE` (`code` ASC),
ADD UNIQUE INDEX `name_UNIQUE` (`name` ASC);

ALTER TABLE `msr_pathways` 
CHANGE COLUMN `fafsa_completed` `fafsa_completed` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `college_appl_submitted` `college_appl_submit_count` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `college_accepted` `college_accepted` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `finaid_applied` `finaid_applied` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `college_regis_completed` `college_regis_completed` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `netevent_attended` `netevent_attended` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `resume_completed` `resume_completed` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `job_applied` `job_applied` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `job_interview` `job_interview` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `position_accepted` `position_accepted` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `position_type` `position_type_code` CHAR(2) NULL DEFAULT NULL ,
CHANGE COLUMN `position_withpo` `position_withpo` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `step_inline` `step_inline` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `national_service_applied` `national_service_applied` INT(2) NULL DEFAULT NULL ,
CHANGE COLUMN `past_pathways_id` `past_pathways_code` CHAR(2) NULL DEFAULT NULL ,
CHANGE COLUMN `pathways_same` `pathways_same` INT(1) NULL DEFAULT NULL ,
CHANGE COLUMN `current_pathways_id` `current_pathways_code` CHAR(2) NULL DEFAULT NULL ;

DROP TABLE `employees`;

DROP TABLE `hibernate_sequence`;


ALTER TABLE `msr_pathways` 
ADD COLUMN `taking_add_step` INT(1) NULL,
ADD COLUMN `additional_step` TEXT NULL,
ADD COLUMN `current_COnnection` VARCHAR(45);


ALTER TABLE `msr_pathways` 
CHANGE COLUMN `current_COnnection` `current_connection` VARCHAR(45) NULL;


ALTER TABLE `acts_commitment` 
DROP FOREIGN KEY `fk_action2_action`;
ALTER TABLE `acts_commitment` 
CHANGE COLUMN `objective_id` `objective_id` INT(11) NULL ,
ADD COLUMN `type` CHAR(2) NULL AFTER `init_report_id`,
ADD COLUMN `msr_id` INT(11) NULL AFTER `type`,
ADD COLUMN `job_objective_id` INT(11) NULL AFTER `msr_id`,
ADD INDEX `fk_job_objective_actm_idx` (`job_objective_id` ASC);
ALTER TABLE `acts_commitment` 
ADD CONSTRAINT `fk_action2_action`
  FOREIGN KEY (`objective_id`)
  REFERENCES `acts_objective` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_action_msr`
  FOREIGN KEY (`msr_id`)
  REFERENCES `msr`(`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_job_objective_actm`
  FOREIGN KEY (`job_objective_id`)
  REFERENCES `job_objective` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
==========================================================09/22/18==========================================
ALTER TABLE `msr_pathways` 
ADD COLUMN `created_at` DATETIME NULL AFTER `current_connection`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;

ALTER TABLE `acts_commitment` 
CHANGE COLUMN `type` `act_type` CHAR(2) NULL DEFAULT NULL ,
ADD COLUMN `pathways_id` INT(11) NULL AFTER `job_objective_id`;

ALTER TABLE `msr_pathways` 
CHANGE COLUMN `ally_profile_id` `ally_profile_id` INT(11) NULL ;

ALTER TABLE `acts_commitment` 
ADD CONSTRAINT `fk_action2_pathways`
  FOREIGN KEY (`pathways_id`)
  REFERENCES `msr_pathways` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `msr_pathways` 
CHANGE COLUMN `pathway_type_code` `pathway_type_code` CHAR(2) NULL ;


CREATE TABLE `ap_job_pathways` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ally_profile_id` INT(11) NOT NULL,
  `job_id` INT(11) NOT NULL,
  `pathways_type_id` INT(1) NOT NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_apjobpath` (`ally_profile_id` ASC, `job_id` ASC, `pathways_type_id` ASC),
  INDEX `apjobpath_ap_idx` (`pathways_type_id` ASC),
  CONSTRAINT `apjobpath_path`
    FOREIGN KEY (`pathways_type_id`)
    REFERENCES `stp_position_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    alter table `ap_job_pathways` add
    
      CONSTRAINT `apjobpath_ap`
    FOREIGN KEY (`ally_profile_id`)
    REFERENCES `ally_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
       
    alter table `ap_job_pathways` add
  CONSTRAINT `apjobpath_job`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
    
ALTER TABLE `acts_objective` 
ADD COLUMN `apjobpathways_id` INT(11) NULL AFTER `job_objective_id`,
ADD COLUMN `active_flag` INT(1) NULL DEFAULT 1 AFTER `apjobpathways_id`,
ADD INDEX `fk_actpathways_idx` (`apjobpathways_id` ASC);
ALTER TABLE `acts_objective` 
ADD CONSTRAINT `fk_actpathways`
  FOREIGN KEY (`apjobpathways_id`)
  REFERENCES `ap_job_pathways` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
    
 
  
  ALTER TABLE `acts_commitment` 
DROP FOREIGN KEY `fk_job_objective_actm`,
DROP FOREIGN KEY `fk_action_msr`,
DROP FOREIGN KEY `fk_action2_pathways`;
ALTER TABLE `acts_commitment` 
DROP COLUMN `pathways_id`,
DROP COLUMN `job_objective_id`,
DROP COLUMN `msr_id`,
DROP INDEX `fk_action2_pathways` ,
DROP INDEX `fk_action_msr` ,
DROP INDEX `fk_job_objective_actm_idx` ;


ALTER TABLE `acts_commitment` 
DROP FOREIGN KEY `fk_job_objective_actm`,
DROP FOREIGN KEY `fk_action_msr`,
DROP FOREIGN KEY `fk_action2_pathways`;
ALTER TABLE `acts_commitment` 
DROP COLUMN `pathways_id`,
DROP COLUMN `job_objective_id`,
DROP COLUMN `msr_id`,
DROP COLUMN `act_type`,
DROP INDEX `fk_action2_pathways` ,
DROP INDEX `fk_action_msr` ,
DROP INDEX `fk_job_objective_actm_idx` ;
    

ALTER TABLE `acts_objective` 
ADD COLUMN `objective_type` CHAR(3) NULL AFTER `active_flag`;

ALTER TABLE `msr_pathways` 
ADD COLUMN `acts_objective_id` INT(11) NULL AFTER `updated_at`,
ADD COLUMN `act_report_id` INT(11) NULL AFTER `acts_objective_id`;


ALTER TABLE `ap_job_pathways` 
DROP FOREIGN KEY `apjobpath_path`;
ALTER TABLE `ap_job_pathways` 
CHANGE COLUMN `pathways_type_id` `pathways_type_id` INT(1) NULL ;
ALTER TABLE `ap_job_pathways` 
ADD CONSTRAINT `apjobpath_path`
  FOREIGN KEY (`pathways_type_id`)
  REFERENCES `stp_position_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
   ALTER TABLE `acts_objective` 
DROP FOREIGN KEY `fk_actpathways`;
ALTER TABLE `acts_objective` 
DROP COLUMN `apjobpathways_id`,
ADD COLUMN `job_id` INT(11) NULL AFTER `objective_type`,
ADD INDEX `fk_job_act_commit_idx` (`job_id` ASC),
DROP INDEX `fk_actpathways_idx` ;
ALTER TABLE `acts_objective` 
ADD CONSTRAINT `fk_job_act_commit`
  FOREIGN KEY (`job_id`)
  REFERENCES `job` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  DROP TABLE `ap_job_pathways`;


ALTER TABLE `msr_pathways` 
CHANGE COLUMN `act_report_id` `acts_report_id` INT(11) NULL DEFAULT NULL ;

=====================================================09/29/18==================================================
ALTER TABLE `job` 
ADD COLUMN `active_flag` INT(1) NULL DEFAULT 1;

ALTER TABLE `pay_period` 
CHANGE COLUMN `active_flag` `active_flag` INT(1) NULL DEFAULT 1 ;

ALTER TABLE `msr` 
CHANGE COLUMN `active_flag` `active_flag` INT(1) NOT NULL DEFAULT 1 ;

ALTER TABLE `pay_period` 
DROP COLUMN `pos_approval_status`,
DROP COLUMN `pm_approval_status`,
DROP COLUMN `ally_submit_status`;

DROP TABLE `site_profile_slots`;

create view vw_ally_profile as select * from ally_profile where graduation_status_id = 10;


ALTER TABLE `pay_period` 
CHANGE COLUMN `training_total` `total_training` FLOAT(11,2) NOT NULL DEFAULT '0.00' ,
CHANGE COLUMN `service_total` `total_service` FLOAT(11,2) NOT NULL DEFAULT '0.00' ,
ADD COLUMN `total_placement` FLOAT(11,2) NOT NULL DEFAULT '0.00',
ADD COLUMN `total_fundraising` FLOAT(11,2) NOT NULL DEFAULT '0.00',
ADD COLUMN `total_tsp` FLOAT(11,2) NOT NULL DEFAULT '0.00';


   update pay_period p,
   (
   SELECT id, JSON_EXTRACT(additional_detail, '$[0].id') a1, JSON_EXTRACT(additional_detail, '$[0].totalHour') a2, JSON_EXTRACT(additional_detail, '$[1].id') b1, JSON_EXTRACT(additional_detail, '$[1].totalHour') b2, JSON_EXTRACT(additional_detail, '$[2].id') c1, JSON_EXTRACT(additional_detail, '$[2].totalHour') c2, JSON_EXTRACT(additional_detail, '$[3].id') d1, JSON_EXTRACT(additional_detail, '$[3].totalHour') d2 , JSON_EXTRACT(additional_detail, '$[4].id') e1, JSON_EXTRACT(additional_detail, '$[4].totalHour') e2  from pay_period
   ) u
   
   set  p.total_placement = u.a2,
   p.total_fundraising = u.b2,
   p.total_tsp = u.c2,
   p.total_service = u.d2,
   p.total_training = u.e2
   where p.id = u.id;

   
UPDATE `ref_table_data` SET `code`='PL' WHERE `id`='114';
UPDATE `ref_table_data` SET `code`='FF' WHERE `id`='115';
UPDATE `ref_table_data` SET `code`='TF' WHERE `id`='116';


ALTER TABLE `ally_profile` 
CHANGE COLUMN `refillment` `refillment` INT(1) NULL DEFAULT 0 ,
CHANGE COLUMN `refilled` `refilled` INT(1) NULL DEFAULT 0 ;
//
==============================================18/10/03===================================================
INSERT INTO `report_status` (`code`, `name`) VALUES ('NA', 'NA');

==================================================18/10/04==============================================
ALTER TABLE `ally` 
DROP FOREIGN KEY `fk_ally_unemply_period`;
ALTER TABLE `ally` 
ADD INDEX `fk_ally_unemply_period_idx` (`unemployment_period` ASC),
DROP INDEX `fk_ally_unemply_period_idx` ;
ALTER TABLE `ally` 
ADD CONSTRAINT `fk_ally_unemply_period`
  FOREIGN KEY (`unemployment_period`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ===========================================18/10/06/=========================================================
  CREATE TABLE `login_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `activity_type` varchar(25) DEFAULT NULL,
  `activity` text DEFAULT NULL,
  priority_level int(1) default 9,
  `status` int(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

INSERT INTO `atomic_user_role` (`code`, `name`, `role_type_id`, `active_flag`, `required_site_flag`) VALUES ('LM', 'Alumni', '91', 1,1);

ALTER TABLE `job_objective` 
ADD COLUMN `approved_flag` INT(1) NULL DEFAULT 0 ;

ALTER TABLE `job_objective_output` 
ADD COLUMN `approved_flag` INT(1) NULL DEFAULT 0 ;

update job_objective_output set approved_flag = 1 
where id in (

select q1.joo_id
from job_assessment ja
join 
(
select jo.job_id as job_id, joo.id as joo_id, joo.job_objective_id, joo.output_measure_id
from job_objective_output joo
join job_objective jo on (jo.id = joo.job_objective_id)
) q1 on (q1.output_measure_id = ja.output_measure_id and ja.job_id = q1.job_id)
);

update job_objective set approved_flag = 1
where job_id in (select job_id from job_assessment)
and id not in (select job_objective_id from job_objective_output where approved_flag is null or approved_flag != 1);


update job set approval_status='SB' 
where id in (select job_id from job_assessment)
and id in (select job_id from job_objective where approved_flag is null or approved_flag != 1);


========================================================18/10/18=========================================================================
CREATE TABLE `option_list` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `stp_data_type` (
  `id` INT(2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));

CREATE TABLE `option_list_option` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `display_text` VARCHAR(150) NOT NULL,
  `actual_value` VARCHAR(150) NOT NULL,
  `option_list_id` INT(11) NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_option_list_option_idx` (`option_list_id` ASC),
  CONSTRAINT `fk_option_list_option`
    FOREIGN KEY (`option_list_id`)
    REFERENCES `option_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    ALTER TABLE `option_list` 
ADD COLUMN `data_type_id` INT(2) NULL AFTER `active_flag`,
ADD INDEX `fk_option_list_data_type_idx` (`data_type_id` ASC);
ALTER TABLE `option_list` 
ADD CONSTRAINT `fk_option_list_data_type`
  FOREIGN KEY (`data_type_id`)
  REFERENCES `stp_data_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  CREATE TABLE `stp_field_type` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  `active_flag` INT(1) NULL,
  `description` VARCHAR(150) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  
  ALTER TABLE `stp_data_type` 
CHANGE COLUMN `name` `name` VARCHAR(15) NOT NULL ,
ADD COLUMN `description` VARCHAR(150) NULL AFTER `active_flag`;


CREATE TABLE `form_field` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(100) NULL,
  `label` TEXT NULL,
  `paceholder_text` VARCHAR(150) NULL,
  `textarea_rows` INT(2) NULL,
  `textarea_cols` INT(2) NULL,
  `required_flag` INT(1) NULL DEFAULT 0,
  `select_size` INT(1) NULL DEFAULT 1,
  `label_above_flag` INT(1) NULL DEFAULT 0,
  `glyphicon` TEXT(30) NULL,
  `instruction_text` TEXT NULL,
  `glyphicon_left` INT(1) NULL,
  `label_flex` INT(2) NULL,
  `field_flex` INT(2) NULL,
  `flex` INT(2) NULL DEFAULT 12,
  `field_type_id` INT(2) NOT NULL,
  `data_type_id` INT(2) NOT NULL,
  `minimum_value` DOUBLE NULL,
  `maximum_value` DOUBLE NULL,
  `maximum_length` INT(3) NULL,
  `option_list_id` INT(11) NULL,
  `default_value` VARCHAR(150) NULL,
  `active_flag(1)` INT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_field_option_list_idx` (`option_list_id` ASC),
  INDEX `fk_field_data_type_idx` (`data_type_id` ASC),
  INDEX `fk_field_field_type_idx` (`field_type_id` ASC),
  CONSTRAINT `fk_field_option_list`
    FOREIGN KEY (`option_list_id`)
    REFERENCES `option_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_field_data_type`
    FOREIGN KEY (`data_type_id`)
    REFERENCES `stp_data_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_field_field_type`
    FOREIGN KEY (`field_type_id`)
    REFERENCES `stp_field_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
    CREATE TABLE `survey` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  `instruction` TEXT NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`));

  
  ALTER TABLE `form_field` 
ADD COLUMN `survey_id` INT(11) NOT NULL AFTER `active_flag(1)`,
ADD COLUMN `field_order` INT(3) NULL AFTER `survey_id`,
ADD INDEX `fk_field_survey_idx` (`survey_id` ASC);
ALTER TABLE `form_field` 
ADD CONSTRAINT `fk_field_survey`
  FOREIGN KEY (`survey_id`)
  REFERENCES `survey` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  ================================================18/10/21=================================================================
  ALTER TABLE `msr_pathways` 
ADD COLUMN `submitted_fafsa_forms` INT(1) NULL AFTER `acts_report_id`;

ALTER TABLE `msr` 
CHANGE COLUMN `report_order` `report_order` INT(2) NULL DEFAULT '0' ;

ALTER TABLE `program` 
ADD COLUMN `msr_last_question_month` INT(2) NULL DEFAULT 8 ;

update program set msr_last_question_month = 3 where name like '%Leadership Academy%';

ALTER TABLE `msr_pathways` 
ADD COLUMN `coaching_session_pm` INT(1) NULL,
ADD COLUMN `coaching_session_pm_count` INT(3) NULL;

ALTER TABLE `form_field` 
CHANGE COLUMN `active_flag(1)` `active_flag` INT(1) NULL DEFAULT NULL ;


ALTER TABLE `msr_pathways` 
ADD COLUMN `pos_contribution_achieve` TEXT NULL ,
ADD COLUMN `staff_contribution_achieve` TEXT NULL ,
ADD COLUMN `pos_contributed_achieving` TEXT NULL,
ADD COLUMN `staff_contributed_achieving` TEXT NULL,
ADD COLUMN `staff_track_achievement` VARCHAR(45) NULL;

==========================================================18/10/22===============================================================
UPDATE `stp_pathways_type` SET `name`='Obtain employment or launch your own business / nonprofit aligned with your career aspirations' WHERE code='EP';
UPDATE `stp_pathways_type` SET `name`='Both obtain employment & pursue further education' WHERE code='DP';
UPDATE `stp_pathways_type` SET `name`='Complete another year of National Service or Fellowship' WHERE code='NS';

============================================================18/10/27===============================================================
CREATE TABLE`tsp` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `site_profile_id` INT(11) NULL,
  `staff_id` INT(11) NULL,
  `cncs_id` TINYINT(2) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `status` VARCHAR(3) NULL,
  `created_user_id` INT(11) NULL,
  `active_flag` INT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tsp_cncs_idx` (`cncs_id` ASC),
  INDEX `fk_tsp_sp_idx` (`site_profile_id` ASC),
  CONSTRAINT `fk_tsp_cncs`
    FOREIGN KEY (`cncs_id`)
    REFERENCES `cncs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
      CONSTRAINT `fk_tsp_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tsp_sp`
    FOREIGN KEY (`site_profile_id`)
    REFERENCES `site_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `tsp_ally_profile` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ally_profile_id` INT(11) NOT NULL,
  `tsp_id` INT(11) NOT NULL,
  `partial_creadit_flag` INT(1) NULL DEFAULT 0,
  `active_flag` INT(1) NULL DEFAULT 1,
  `add_detail` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `tsp` 
ADD COLUMN `history` JSON NULL ;

ALTER TABLE `tsp_ally_profile` 
ADD INDEX `fk_tsp_ap_tsp_idx` (`tsp_id` ASC);
ALTER TABLE`tsp_ally_profile` 
ADD CONSTRAINT `fk_tsp_ap_tsp`
  FOREIGN KEY (`tsp_id`)
  REFERENCES `tsp` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `tsp_ally_profile` 
ADD INDEX `fk_tsp_ap_ap_idx` (`ally_profile_id` ASC);
ALTER TABLE`tsp_ally_profile` 
ADD CONSTRAINT `fk_tsp_ap_ap`
  FOREIGN KEY (`ally_profile_id`)
  REFERENCES `ally_profile` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  CREATE TABLE `tsp_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tsp_id` int(11) NOT NULL,
  `due_date` date DEFAULT NULL,
  `report_date` datetime DEFAULT NULL,
  `achievement_desc` text,
  `result_desc` text,
  `five_core_desc` text,
  `volunteer_hours` float(6,2) DEFAULT NULL,
  `is_locked` int(1) DEFAULT 0,
  `locked_by_user_id` int(11) DEFAULT NULL,
  `locked_by_name` varchar(50) DEFAULT NULL,
  `status_code` char(2) DEFAULT null,
  `submit_date` datetime DEFAULT NULL,
  `submit_by_user_id` int(11) DEFAULT NULL,
  `approval_date` datetime DEFAULT NULL,
  `comment` varchar(250) DEFAULT NULL,
  `start_flag` int(1) DEFAULT 0,
  `allies_comment` text,
  `supervisor_comment` text,
  `is_final` int(1) DEFAULT 0,
  `ally_initial` varchar(3) DEFAULT NULL,
  `approver_initial` varchar(3) DEFAULT NULL,
  `approver_user_id` int(11) DEFAULT NULL,
  `locked_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tsp_id` (`tsp_id`,`due_date`),
  KEY `fk_tsp_report_tsp1` (`tsp_id`),
  CONSTRAINT `fk_tsp_report_tsp1` FOREIGN KEY (`tsp_id`) REFERENCES `tsp` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE `tsp_report_urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `tsp_report_id` int(11) NOT NULL,
  `created_at` DATETIME NULL,
`updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tsp_report_urls_tsp_report1` (`tsp_report_id`),
  CONSTRAINT `fk_tsp_report_urls_tsp_report1` FOREIGN KEY (`tsp_report_id`) REFERENCES `tsp_report` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE `tsp_report_upload_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_title` varchar(50) DEFAULT NULL,
  `file_location` varchar(100) DEFAULT NULL,
  `file_description` varchar(250) DEFAULT NULL,
  `active_flag` int(1) NOT NULL DEFAULT 1,
  `uploaded_by_user_id` int(11) DEFAULT NULL,
  `uploaded_by_name` varchar(50) DEFAULT NULL,
  `tsp_report_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tsp_report_upload_files_tsp_report1` (`tsp_report_id`),
  CONSTRAINT `fk_tsp_report_upload_files_tsp_report1` FOREIGN KEY (`tsp_report_id`) REFERENCES `tsp_report` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

ALTER TABLE `tsp_report` 
ADD COLUMN `history` JSON NULL ;

ALTER TABLE `tsp_report_upload_files` 
ADD COLUMN `created_at` DATETIME NULL AFTER `tsp_report_id`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;


=========================================== 11/3/18==============================================================================
ALTER TABLE `tsp_report` 
CHANGE COLUMN `is_final` `final_flag` INT(1) NULL DEFAULT 0 ,
ADD COLUMN `first_flag` INT(1) NULL DEFAULT 0 AFTER `final_flag`;

ALTER TABLE `tsp_report` 
ADD COLUMN `active_flag` INT(1) NULL DEFAULT 1;


=============================================11/4/18=========================================================================
ALTER TABLE `tsp` 
ADD COLUMN `desired_result` TEXT NULL AFTER `history`,
ADD COLUMN `challenge_evidence` TEXT NULL AFTER `desired_result`,
ADD COLUMN `communication_asset` TEXT NULL AFTER `challenge_evidence`,
ADD COLUMN `leadership_action` TEXT NULL AFTER `communication_asset`,
ADD COLUMN `team_member_role` TEXT NULL AFTER `leadership_action`,
ADD COLUMN `team_accountability` TEXT NULL AFTER `team_member_role`,
ADD COLUMN `success_completed` INT(1) NULL AFTER `team_accountability`,
ADD COLUMN `community_orgs` TEXT NULL AFTER `success_completed`,
ADD COLUMN `community_orgs_count` INT(3) NULL AFTER `community_orgs`,
ADD COLUMN `actual_result` TEXT NULL AFTER `community_orgs_count`,
ADD COLUMN `actual_leadership_action` TEXT NULL AFTER `actual_result`,
ADD COLUMN `actual_team_accountability` TEXT NULL AFTER `actual_leadership_action`,
ADD COLUMN `community_contributed` TEXT NULL AFTER `actual_team_accountability`,
ADD COLUMN `team_learning` TEXT NULL AFTER `community_contributed`,
ADD COLUMN `completed` INT(1) NULL DEFAULT 0 AFTER `team_learning`;


ALTER TABLE `tsp_ally_profile` 
ADD COLUMN `role_responsability` TEXT NULL AFTER `updated_at`,
ADD COLUMN `greatest_learning` TEXT NULL AFTER `role_responsability`;

ALTER TABLE `tsp_report` 
ADD COLUMN `project_status` VARCHAR(45) NULL AFTER `active_flag`,
ADD COLUMN `step_to_track` TEXT NULL AFTER `project_status`,
ADD COLUMN `achieving_status` TEXT NULL AFTER `step_to_track`,
ADD COLUMN `leadership_action_status` TEXT NULL AFTER `achieving_status`,
ADD COLUMN `acountability_status` TEXT NULL AFTER `leadership_action_status`,
ADD COLUMN `team_work_status` TEXT NULL AFTER `acountability_status`;

ALTER TABLE `tsp_ally_profile` 
ADD COLUMN `goals` TEXT NULL AFTER `greatest_learning`;

================================================================= 11/5/18=========================================================
ALTER TABLE `tsp_report_upload_files` 
CHANGE COLUMN `file_location` `file_location` VARCHAR(200) NULL DEFAULT NULL ,
CHANGE COLUMN `file_description` `file_description` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `uploaded_by_name` `uploaded_by_name` VARCHAR(200) NULL DEFAULT NULL ;

ALTER TABLE `tsp_report_upload_files` 
ADD COLUMN `history` JSON ;

=========================================================== 11/10/18======================================================
ALTER TABLE `msr_pathways` 
CHANGE COLUMN `college_name` `college_name` VARCHAR(150) NULL DEFAULT NULL ,
CHANGE COLUMN `company_name` `company_name` VARCHAR(150) NULL DEFAULT NULL ,
CHANGE COLUMN `position_title` `position_title` VARCHAR(150) NULL DEFAULT NULL ,
CHANGE COLUMN `current_connection` `current_connection` VARCHAR(150) NULL DEFAULT NULL ;


ALTER TABLE `tsp` 
ADD COLUMN `community_impact` TEXT NULL AFTER `completed`;

ALTER TABLE `tsp_ally_profile` 
ADD COLUMN `history` JSON NULL AFTER `goals`;
=========================================================== 11/11/18============================================================

ALTER TABLE `form_field` 
DROP FOREIGN KEY `fk_field_data_type`;
ALTER TABLE `form_field` 
DROP INDEX `fk_field_data_type_idx` ;

ALTER TABLE `option_list` 
DROP FOREIGN KEY `fk_option_list_data_type`;
ALTER TABLE `option_list` 
DROP INDEX `fk_option_list_data_type_idx` ;

ALTER TABLE `stp_data_type` 
CHANGE COLUMN `id` `id` INT(2) NOT NULL AUTO_INCREMENT ;


ALTER TABLE `option_list` 
ADD INDEX `fk_option_list_data_type_idx` (`data_type_id` ASC);
ALTER TABLE `option_list` 
ADD CONSTRAINT `fk_option_list_data_type`
  FOREIGN KEY (`data_type_id`)
  REFERENCES `stp_data_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `form_field` 
ADD INDEX `fk_form_flied_dataT_idx` (`data_type_id` ASC);
ALTER TABLE `form_field` 
ADD CONSTRAINT `fk_form_flied_dataT`
  FOREIGN KEY (`data_type_id`)
  REFERENCES `stp_data_type` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('TEXT', 'Text');
INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('INTEGER', 'Integer (Number without decimal place)');
INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('DECIMAL', 'Decimal (Number with 2 decimal place by default)');
INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('DATE', 'Date');
INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('TIME', 'Time');
INSERT INTO `stp_data_type` (`name`, `description`) VALUES ('DATETIME', 'Date and Time');

INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('INPUT_TEXT', 'Text input field');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('INPUT_NUMBER', 'Number input field');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('TEXTAREA', 'Textarea (multiple lines text input)');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('INPUT_DATE', 'Date input field');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('RADIO_BUTTON', 'Radio button');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('CHECKBOX', 'Checkbox');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('SELECT_SINGLE', 'Option list with one selection');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('SELECT_MULTLIPLE', 'Option list with multiple selection');
INSERT INTO `stp_field_type` (`name`, `description`) VALUES ('INPUT_HIDDEN', 'Input hidden');


======================================================= 11/18/18============================================================
INSERT INTO `atomic_user_role` (`code`, `name`, `role_type_id`, `active_flag`, `editable_flag`, `required_site_flag`) VALUES ('TP', 'TSP Limited', '92', 1, 0, 1);

====================================================== 11/23//18==============================================================
ALTER TABLE `option_list_option` 
ADD COLUMN `order_weight` INT(3) NULL AFTER `active_flag`,
ADD COLUMN `order_by` VARCHAR(45) NULL AFTER `order_weight`;

ALTER TABLE `form_field` 
ADD COLUMN `tooltip_text` TEXT NULL AFTER `field_order`,
ADD COLUMN `allow_futur_vaue` INT(1) NULL DEFAULT 2 AFTER `tooltip_text`,
ADD COLUMN `allow_past_value` INT(1) NULL DEFAULT 2 AFTER `allow_futur_vaue`;

ALTER TABLE `form_field` 
CHANGE COLUMN `paceholder_text` `placeholder_text` VARCHAR(150) NULL DEFAULT NULL;

ALTER TABLE `form_field` 
CHANGE COLUMN `allow_futur_vaue` `allow_future_vaue` INT(1) NULL DEFAULT '2' ;

ALTER TABLE `form_field` 
CHANGE COLUMN `allow_future_vaue` `allow_future_value` INT(1) NULL DEFAULT '2' ;

INSERT INTO `stp_field_type` (`name`) VALUES ('SELECT_MULTIPLE');
UPDATE `stp_field_type` SET `name`='RADIO' WHERE `id`='5';

ALTER TABLE `stp_field_type` 
CHANGE COLUMN `name` `name` VARCHAR(25) NOT NULL ;
INSERT INTO `stp_field_type` (`name`) VALUES ('INSTRUCTION_SEPARATOR');

CREATE TABLE `pa_form` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NULL,
  `description` TEXT NULL,
  `status` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `history` JSON NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `pa_form` 
CHANGE COLUMN `title` `title` VARCHAR(150) NOT NULL ,
ADD UNIQUE INDEX `title_UNIQUE` (`title` ASC);



ALTER TABLE `form_field` 
DROP FOREIGN KEY `fk_field_survey`;
ALTER TABLE `form_field` 
ADD COLUMN `form_id` INT(11) NULL AFTER `allow_past_value`,
DROP INDEX `fk_field_survey_idx` ;


ALTER TABLE `form_field` 
ADD CONSTRAINT `fk_form_fomrField`
  FOREIGN KEY (`form_id`)
  REFERENCES `pa_form` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `form_field` 
DROP COLUMN `survey_id`;

ALTER TABLE `form_field` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;


================================================================== 11/25/18====================================================
DROP TABLE `survey`;

CREATE TABLE `survey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `survey_id` varchar(256) DEFAULT NULL,
  `category` varchar(256) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `collector_id` varchar(45) DEFAULT NULL,
  `collector_type` varchar(45) DEFAULT NULL,
  `collector_status` varchar(45) DEFAULT NULL,
  `collector_end_date` datetime DEFAULT NULL,
  `collector_creation_date` datetime DEFAULT NULL,
  `collector_name` varchar(45) DEFAULT NULL,
  `redirect_url` varchar(1024) DEFAULT NULL,
  `collector_modification_date` datetime DEFAULT NULL,
  `is_collector_deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `survey_id_idx` (`survey_id`)
) ENGINE=InnoDB;


CREATE TABLE `survey_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `user_email` varchar(45) DEFAULT NULL,
  `survey_id` int(11) DEFAULT NULL,
  `survey_monkey_id` varchar(45) DEFAULT NULL,
  `collector_id` varchar(45) DEFAULT NULL,
  `response_id` varchar(45) DEFAULT NULL,
  `recipient_id` varchar(45) DEFAULT NULL,
  `response_status` varchar(45) DEFAULT NULL,
  `response_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id_fk_idx` (`survey_id`),
  KEY `user_id_fk_idx` (`user_id`),
  CONSTRAINT `survey_id_fk` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

ALTER TABLE `survey` 
CHANGE COLUMN `url` `url` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `survey_id` `sm_id` VARCHAR(256) NULL DEFAULT NULL ;


CREATE TABLE `survey_guest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `guest_code` varchar(30) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);


ALTER TABLE `survey_response` 
ADD COLUMN `guest_user_id` INT(11) NULL AFTER `response_date`,
ADD INDEX `fk_survey_guest_user_idx` (`guest_user_id` ASC);
ALTER TABLE `survey_response` 
ADD CONSTRAINT `fk_survey_guest_user`
  FOREIGN KEY (`guest_user_id`)
  REFERENCES `survey_guest` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
ALTER TABLE `survey_response` 
ADD COLUMN `user_type` VARCHAR(45) NULL AFTER `guest_user_id`;

ALTER TABLE `survey_guest` 
CHANGE COLUMN `email` `email` VARCHAR(150) NULL DEFAULT NULL ,
ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC);

=========================================================== 12/08/2018===========================================
ALTER TABLE `ally_profile_history` 
CHANGE COLUMN `created_by` `created_by` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `exit_reason` `exit_reason` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `notes` `notes` TEXT NULL DEFAULT NULL ;

ALTER TABLE `ally` 
DROP COLUMN `race_other`,
DROP COLUMN `raceIds`,
DROP COLUMN `other_race`,
DROP COLUMN `last_education2`,
DROP COLUMN `last_education1`;


DROP TABLE `users_race`;

ALTER TABLE `ally_profile` 
ADD COLUMN `demogramphic_snapshot` JSON NULL;

ALTER TABLE `ally` 
DROP FOREIGN KEY `fk_ally_unemply_period`;
ALTER TABLE `ally` 
ADD INDEX `fk_ally_unemply_period_idx` (`unemployment_period` ASC),
DROP INDEX `fk_ally_unemply_period_idx` ;
ALTER TABLE `ally` 
ADD CONSTRAINT `fk_ally_unemply_period`
  FOREIGN KEY (`unemployment_period`)
  REFERENCES `stp_common_period` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ===============================================================12/09/2018=========================================
  CREATE TABLE `demographic_snapshot` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ally_profile_id` int(10),
    gender_id int(1),
	gender_name varchar(100),
	gender_other  varchar(100),
	race_ids_json json,
	race_names_json json,
	race_other  varchar(100),
	higher_education_id int(2),
	higher_education_name  varchar(100),
	sex_orientation_id int(2),
	sex_oriantation_name  varchar(100),
	sex_orientation_other  varchar(100),
	dob date,
	
	prior_americorp varchar(15),
	age_entering_program int(3),
	last_education  varchar(100),
	first_member_college varchar(15),
	poverty_flag  varchar(15),
	received_gov_assist  varchar(15),
	social_assists_json json,
	applied_gov_assist  varchar(15),
	current_receive_gov_assist  varchar(15),
	parent_graduate_college  varchar(15),
	taxable_earn_income decimal(12,2),
	employment_status_id int(2),
	employment_status_name  varchar(150),
	employment_title   varchar(150),
	employer_name   varchar(150),
	unemployment_period_id int(2),
	unemployment_period_name   varchar(100),
	worked_professional_flag  varchar(15),
	employed_npo_flag  varchar(15),
	received_social_assist  varchar(15),
	convicted_flag  varchar(15),
	enrolled24college_flag  varchar(15),
	enrolled_college_period int(2),
	enrolled_college_period_name   varchar(100),
	enrolled_college_period_flag  varchar(15),
	emploment_period_id int(2),
	employment_period_name   varchar(100),
	military_veteran  varchar(15),
	 marital_status_id int(2),
	marital_status_name   varchar(100),
	lgbtq_flag  varchar(15),
	disability_flag  varchar(15),
	disability_desc   varchar(150),
	
	child_count int(3),
	 PRIMARY KEY (`id`)
	);
	
ALTER TABLE `demographic_snapshot` 
CHANGE COLUMN `ally_profile_id` `ally_profile_id` INT(11) NOT NULL ,
ADD UNIQUE INDEX `ally_profile_id_UNIQUE` (`ally_profile_id` ASC);
ALTER TABLE `demographic_snapshot` 
ADD CONSTRAINT `fk_demographic_ap`
  FOREIGN KEY (ally_profile_id)
  REFERENCES `ally_profile` (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `ally` 
CHANGE COLUMN `age_entering_program` `age_entering_program` INT(3) NULL DEFAULT NULL;


ALTER TABLE `demographic_snapshot` 
CHANGE COLUMN `sex_oriantation_name` `sex_orientation_name` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `demographic_snapshot` 
ADD COLUMN `created_at` DATETIME NULL AFTER `child_count`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;



ALTER TABLE `demographic_snapshot` 
CHANGE COLUMN `emploment_period_id` `employment_period_id` INT(2) NULL DEFAULT NULL ;


==========================================12/24/18==========================================
ALTER TABLE `survey_response` 
ADD COLUMN `guest_flag` INT(1) NOT NULL AFTER `user_type`;


ALTER TABLE `survey` 
DROP COLUMN `redirect_url`,
DROP COLUMN `collector_name`,
DROP COLUMN `collector_creation_date`,
DROP COLUMN `collector_end_date`,
DROP COLUMN `collector_status`,
DROP COLUMN `collector_type`,
DROP COLUMN `collector_id`,
DROP COLUMN `is_collector_deleted`,
DROP COLUMN `creation_date`,
DROP COLUMN `last_edit_time`,
CHANGE COLUMN `name` `name` TEXT NULL AFTER `sm_id`,
ADD COLUMN `nickname` TINYTEXT NULL AFTER `name`,
ADD COLUMN `response_count` INT(8) NULL AFTER `nickname`,
ADD COLUMN `page_count` INT(11) NULL AFTER `response_count`,
ADD COLUMN `question_count` INT(5) NULL AFTER `page_count`,
ADD COLUMN `analyze_url` TEXT NULL AFTER `question_count`,
ADD COLUMN `summary_url` TEXT NULL AFTER `analyze_url`,
ADD COLUMN `collect_url` TEXT NULL AFTER `summary_url`,
ADD COLUMN `edit_url` TEXT NULL AFTER `collect_url`,
ADD COLUMN `sm_created_date` DATE NULL AFTER `edit_url`,
ADD COLUMN `sm_modified_date` DATE NULL AFTER `sm_created_date`,
ADD COLUMN `created_at` DATETIME NULL DEFAULT NULL ,
ADD COLUMN `updated_at` DATETIME NULL DEFAULT NULL ,
ADD COLUMN `deleted_flag` int(1) not NULL DEFAULT 0;



CREATE TABLE `survey_collector` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` TINYTEXT NULL,
  `status` VARCHAR(100) NULL,
  `redirect_url` TINYTEXT NULL,
  `thanks_msg` TEXT NULL,
  `response_cout` INT(8) NULL,
  `closed_msg` TEXT NULL,
  `url` TEXT NULL,
  `survey_id` INT(11) NOT NULL,
  `href` TEXT NULL,
  `close_date` DATE NULL,
  `type` VARCHAR(100) NULL,
  `sm_created_date` DATE NULL,
  `sm_modified_date` DATE NULL,
  `sm_id` VARCHAR(45) NULL,
  `multiple_response_flag` INT(1) NULL,
  deleted_flag int(1) not null default 0,
  PRIMARY KEY (`id`),
  INDEX `survey_collector_survey_idx` (`survey_id` ASC),
  CONSTRAINT `survey_collector_survey`
    FOREIGN KEY (`survey_id`)
    REFERENCES `survey` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ALTER TABLE `survey` 
CHANGE COLUMN `url` `href` TEXT NULL DEFAULT NULL after name;

ALTER TABLE `survey` 
ADD COLUMN `preview_url` TEXT NULL AFTER `deleted_flag`;

===============================================12/26/18=============================================
ALTER TABLE `survey_collector` 
ADD COLUMN `created_at` DATETIME NULL AFTER `deleted_flag`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;

ALTER TABLE `survey_collector` 
CHANGE COLUMN `response_cout` `response_count` INT(8) NULL DEFAULT NULL;

ALTER TABLE `survey` DROP COLUMN `is_deleted`;

============================================== 12/27/18================================================

DROP TABLE `survey_response`;

CREATE TABLE `survey_response` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `lj_code` VARCHAR(45) NOT NULL,
  `target_id` INT(11) NULL COMMENT 'allyId for ally, staffId for staffs, posId for supervisor, guestId for guests',
  `target_type` ENUM('ALLY') NOT NULL,
  `survey_id` INT(11) NULL,
  `collector_id` INT(11) NULL,
  `respondent_id` INT(11) NULL COMMENT 'allyId for ally, staffId for staffs, posId for supervisor, guestId for guests',
  `repondent_type` ENUM('SELF', 'POS', 'PM', 'STAFF') NOT NULL,
  `submission_date` DATE NULL,
  `submitted_flag` INT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME NULL,
  `updated_at` DATE NULL,
  `deleted_flag` INT(1) NOT NULL DEFAULT 0,
  `response` JSON NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `lj_code_UNIQUE` (`lj_code` ASC));
  
  
  CREATE TABLE `survey_guest_ally_profile` (
  `id` INT(11) NOT NULL,
  `guest_id` INT(11) NULL,
  `ally_profile_id` INT(11) NULL,
  `created_at` DATE NULL,
  `updated_at` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `gs_ap_idx` (`guest_id` ASC),
  CONSTRAINT `gs_guest`
    FOREIGN KEY (`guest_id`)
    REFERENCES `survey_guest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `gs_ap`
    FOREIGN KEY (`ally_profile_id`)
    REFERENCES `ally_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    
    );

  
  
  ALTER TABLE `survey` 
ADD COLUMN `custom_variables` JSON NULL AFTER `preview_url`;

CREATE TABLE `stp_survey_rtype` (
  `id` INT(2) NOT NULL,
  `code` VARCHAR(10) NULL,
  `name` VARCHAR(45) NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`));


INSERT INTO `stp_survey_rtype` (id, `code`, `name`) VALUES (1, 'ALLY', 'Ally');
INSERT INTO `stp_survey_rtype` (id, `code`, `name`) VALUES (2, 'PM', 'PM');
INSERT INTO `stp_survey_rtype` (id, `code`, `name`) VALUES (3, 'STAFF', 'STAFF');
INSERT INTO `stp_survey_rtype` (id, `code`, `name`) VALUES (4, 'POS', 'Supervisor');
INSERT INTO `stp_survey_rtype` (id, `code`, `name`) VALUES (5, 'GUEST', 'Guest');

CREATE TABLE `site_profile_survey` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `survey_id` INT(11) NULL,
  `collector_id` INT(11) NULL,
  `recipient_group_id` INT(2) NULL,
  `due_date` DATE NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `sps_collector_idx` (`collector_id` ASC),
  INDEX `sps_group_idx` (`recipient_group_id` ASC),
  UNIQUE INDEX `sps_unique` (`survey_id` ASC, `collector_id` ASC, `recipient_group_id` ASC),
  CONSTRAINT `sps_survey`
    FOREIGN KEY (`survey_id`)
    REFERENCES survey (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sps_collector`
    FOREIGN KEY (`collector_id`)
    REFERENCES `survey_collector` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sps_group`
    FOREIGN KEY (`recipient_group_id`)
    REFERENCES `stp_survey_rtype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


ALTER TABLE `survey_collector` 
CHANGE COLUMN `sm_id` `sm_id` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `deleted_flag` `active_flag` INT(1) NOT NULL DEFAULT 1 ,
ADD UNIQUE INDEX `sm_id_UNIQUE` (`sm_id` ASC);


ALTER TABLE `survey` 
CHANGE COLUMN `sm_id` `sm_id` VARCHAR(256) NOT NULL ,
CHANGE COLUMN `name` `name` TEXT NOT NULL ,
CHANGE COLUMN `deleted_flag` `active_flag` INT(1) NOT NULL DEFAULT 1 ,
ADD UNIQUE INDEX `sm_id_UNIQUE` (`sm_id` ASC);

ALTER TABLE `survey_guest` 
CHANGE COLUMN `email` `email` VARCHAR(150) NOT NULL ,
ADD COLUMN `user_id` INT(11) NULL AFTER `updated_at`,
ADD UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC);

ALTER TABLE `survey_response` 
CHANGE COLUMN `deleted_flag` `active_flag` INT(1) NOT NULL DEFAULT 1 ;


ALTER TABLE `survey_response` 
CHANGE COLUMN `repondent_type` `repondent_type_id` INT(2) NOT NULL ,
ADD INDEX `sr_rept_idx` (`repondent_type_id` ASC);
ALTER TABLE `survey_response` 
ADD CONSTRAINT `sr_rept`
  FOREIGN KEY (`repondent_type_id`)
  REFERENCES `stp_survey_rtype` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `site_profile_survey` 
RENAME TO  `survey_site_profile` ;

=================================================12/28/18======================================
ALTER TABLE `survey_site_profile` 
ADD COLUMN `site_profile_id` INT(11) NOT NULL AFTER `active_flag`,
ADD INDEX `sps_sp_idx` (`site_profile_id` ASC),
ADD UNIQUE INDEX `sps_unique2` (`survey_id` ASC, `collector_id` ASC, `recipient_group_id` ASC, `site_profile_id` ASC),
DROP INDEX `sps_unique` ;
ALTER TABLE `survey_site_profile` 
ADD CONSTRAINT `sps_sp`
  FOREIGN KEY (`site_profile_id`)
  REFERENCES `site_profile` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `survey_site_profile` 
DROP FOREIGN KEY `sps_group`;
ALTER TABLE `survey_site_profile` 
CHANGE COLUMN `recipient_group_id` `respondent_group_id` INT(2) NULL DEFAULT NULL ;
ALTER TABLE `survey_site_profile` 
ADD CONSTRAINT `sps_group`
  FOREIGN KEY (`respondent_group_id`)
  REFERENCES `stp_survey_rtype` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `survey_site_profile` 
ADD COLUMN `created_at` DATETIME NULL AFTER `site_profile_id`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;

ALTER TABLE `survey_site_profile` 
ADD COLUMN `created_by_user_id` INT(11) NULL AFTER `updated_at`;

==========================================================12/29/18==============================================
ALTER TABLE `survey_guest` ADD COLUMN `relationship` VARCHAR(100) NULL AFTER `user_id`;

ALTER TABLE `survey_guest` ADD COLUMN `title` VARCHAR(20) NULL AFTER `relationship`;

ALTER TABLE `survey_guest_ally_profile` CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `survey_guest_ally_profile` 
ADD COLUMN `collector_id` INT(11) NOT NULL AFTER `updated_at`,
ADD INDEX `gs_collecotr_idx` (`collector_id` ASC);
ALTER TABLE `survey_guest_ally_profile` ADD CONSTRAINT `gs_collecotr`   FOREIGN KEY (`collector_id`)  REFERENCES `survey_guest` (`id`)  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `survey_guest_ally_profile` 
ADD UNIQUE INDEX `gs_col_unique` (`guest_id` ASC, `ally_profile_id` ASC, `collector_id` ASC);

ALTER TABLE `survey_response` 
CHANGE COLUMN `target_id` `target_id` INT(11) NULL DEFAULT NULL COMMENT 'alyProfileId for ally, staffId for staffs, posId for supervisor, guestId for guests' ,
ADD COLUMN `invitation_sent_flag` INT(1) NOT NULL DEFAULT 0 AFTER `response`,
ADD COLUMN `reminders` JSON NULL AFTER `invitation_sent_flag`,
ADD COLUMN `invitaion_sent_date` DATETIME NULL AFTER `reminders`;

ALTER TABLE `survey_site_profile` 
ADD COLUMN `ally_allies_flag` INT(1) NOT NULL,
ADD COLUMN `hard_due_date_flag` INT(1) NOT NULL AFTER `created_by_user_id`,
ADD COLUMN `due_date_trigger` ENUM('ALLY_START_DATE', 'ALLY_END_DATE') NULL AFTER `hard_due_date_flag`,
ADD COLUMN `days_to_due_date` INT(3) NULL AFTER `due_date_trigger`,
ADD COLUMN `to_due_date_direction` ENUM('BEFORE', 'AFTER') NULL AFTER `days_to_due_date`,
ADD COLUMN `history` JSON NULL AFTER `to_due_date_direction`;

ALTER TABLE `survey_site_profile` 
ADD COLUMN `hard_start_date_flag` INT(1) NOT NULL AFTER `ally_allies_flag`,
ADD COLUMN `start_date_trigger` ENUM('ALLY_START_DATE', 'ALLY_END_DATE') NULL AFTER `hard_start_date_flag`,
ADD COLUMN `days_to_start_date` INT(2) NULL AFTER `start_date_trigger`,
ADD COLUMN `to_start_date_direction` ENUM('BEFORE', 'AFTER') NULL AFTER `days_to_start_date`,
ADD COLUMN `start_date` DATE NULL AFTER `to_start_date_direction`,
ADD COLUMN `deployed_flag` INT(1) NOT NULL DEFAULT 0 AFTER `start_date`;

ALTER TABLE `survey_response` 
ADD COLUMN `survey_site_id` INT(11) NOT NULL AFTER `invitaion_sent_date`,
ADD COLUMN `started_flag` INT(1) NOT NULL DEFAULT 0 AFTER `survey_site_id`,
ADD COLUMN `closed_flag` INT(1) NOT NULL DEFAULT 0 AFTER `started_flag`,
ADD UNIQUE INDEX `sresponse_unique2` (`target_id` ASC, `target_type` ASC, `collector_id` ASC, `respondent_id` ASC, `repondent_type_id` ASC, `survey_id` ASC),
ADD CONSTRAINT `sresponse_sr`
  FOREIGN KEY (`survey_site_id`)
  REFERENCES `survey_site_profile` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `survey_site_profile` 
CHANGE COLUMN `ally_allies_flag` `all_allies_flag` INT(1) NOT NULL ;


ALTER TABLE `survey_site_profile` 
ADD COLUMN `apIds` JSON NULL AFTER `deployed_flag`;

============================================== 12/30/18==========================================================================
ALTER TABLE `ally_profile` ADD COLUMN `assigned_survey_site` JSON NULL AFTER `demogramphic_snapshot`;

CREATE TABLE `stp_survey_guest_type` (
  `id` INT(2) NOT NULL,
  `code` VARCHAR(10) NULL,
  `name` VARCHAR(45) NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`));
  
INSERT INTO `stp_survey_guest_type` (`id`, `code`, `name`) VALUES ('1', 'ST', 'Public Allies Staff');
INSERT INTO `stp_survey_guest_type` (`id`, `code`, `name`) VALUES ('2', 'AL', 'Public Allies Member');
INSERT INTO `stp_survey_guest_type` (`id`, `code`, `name`) VALUES ('3', 'OT', 'Others');
ALTER TABLE `survey_response` 
ADD COLUMN `target_id_type` ENUM('AP', 'AL', 'ST', 'SP', 'US', 'GS') NOT NULL AFTER `closed_flag`,
ADD COLUMN `respondent_id_type` ENUM('AP', 'AL', 'ST', 'SP', 'US', 'GS') NOT NULL AFTER `target_id_type`;


ALTER TABLE`survey_response` 
DROP FOREIGN KEY `sresponse_sr`;
ALTER TABLE `survey_response` 
ADD COLUMN `relation_to_member` VARCHAR(45) NOT NULL AFTER `collector_id`,
CHANGE COLUMN `created_at` `created_at` DATETIME NULL DEFAULT NULL AFTER `relation_to_member`,
CHANGE COLUMN `updated_at` `updated_at` DATE NULL DEFAULT NULL AFTER `created_at`,
CHANGE COLUMN `survey_site_id` `survey_site_id` INT(11) NULL ,
ADD COLUMN `start_date` DATE NOT NULL AFTER `respondent_id_type`,
ADD COLUMN `end_date` DATE NULL AFTER `start_date`,
ADD INDEX `sr_collector_idx` (`collector_id` ASC);
ALTER TABLE `survey_response` 
ADD CONSTRAINT `sresponse_sr`
  FOREIGN KEY (`survey_site_id`)
  REFERENCES `survey_site_profile` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `sr_collector`
  FOREIGN KEY (`collector_id`)
  REFERENCES `survey_collector` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `survey_response` 
CHANGE COLUMN `invitaion_sent_date` `invitation_sent_date` DATETIME NULL DEFAULT NULL ;

ALTER TABLE `survey_response` 
DROP FOREIGN KEY `sr_rept`;
ALTER TABLE `survey_response` 
CHANGE COLUMN `repondent_type_id` `respondent_type_id` INT(2) NOT NULL ;
ALTER TABLE `survey_response` 
ADD CONSTRAINT `sr_rept`
  FOREIGN KEY (`respondent_type_id`)
  REFERENCES `stp_survey_rtype` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `survey_response` 
DROP INDEX `sresponse_unique2` ,
ADD UNIQUE INDEX `sresponse_unique2` (`target_id` ASC, `target_type` ASC, `collector_id` ASC, `respondent_id` ASC, `respondent_type_id` ASC, `survey_id` ASC, `respondent_id_type` ASC, `target_id_type` ASC, `survey_site_id` ASC);


insert into env_properties(keycode, keyvalue) values ('APP_BASE_URL', env here) ;


==================================== 01/14/19===================================================
ALTER TABLE `survey_response` 
ADD COLUMN `sm_response_id` VARCHAR(45) NULL AFTER `end_date`,
ADD COLUMN `sm_url` VARCHAR(150) NULL AFTER `sm_response_id`,
ADD COLUMN `completion_time` INT(6) NULL AFTER `sm_url`;


sql_mode = "change mysql mode to STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" in my.cnf


=================================== 01/19/19===========================================
UPDATE   `stp_survey_rtype` SET `name`='Assigned PM' WHERE `id`='2';
DELETE FROM `stp_survey_rtype` WHERE `id`='3';


UPDATE `stp_survey_guest_type` SET `name`='Other Public Allies Staff' WHERE `id`='1';

ALTER TABLE `survey_response` 
ADD COLUMN `locked_flag` INT(1) NOT NULL DEFAULT 0 AFTER `completion_time`;


============================ 01/30/19===================================

ALTER TABLE `job` 
ADD COLUMN `reports_flag` INT(1) NOT NULL DEFAULT 0 AFTER `active_flag`;

ALTER TABLE `survey_response` 
ADD COLUMN `last_reminder_sent_date` DATE NULL DEFAULT NULL AFTER `locked_flag`;

ALTER TABLE `job` CHANGE COLUMN `reports_flag` `enforce_dates` INT(1) NOT NULL DEFAULT 0 ;


================================ 19/02/16===========================================================
CREATE TABLE `survey_question` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `sm_id` VARCHAR(45) NULL,
  `position` INT(3) NULL,
  `href` VARCHAR(100) NULL,
  `heading` TEXT NULL,
  `answer_json` JSON NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`));
  
ALTER TABLE `survey_question` 
CHANGE COLUMN `sm_id` `sm_id` VARCHAR(45) NOT NULL ,
ADD COLUMN `survey_id` INT(11) NULL AFTER `active_flag`,
ADD UNIQUE INDEX `sm_id_UNIQUE` (`sm_id` ASC),
ADD CONSTRAINT `sq_survey`
  FOREIGN KEY (`survey_id`)
  REFERENCES `survey` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `survey_response` ADD COLUMN `responseJson` JSON;



ALTER TABLE `site_profile` ADD COLUMN `survey_results` TEXT NULL AFTER `src_fund_id`;
ALTER TABLE `site_profile` CHANGE COLUMN `survey_results` `additional_info` TEXT NULL DEFAULT NULL ;



ALTER TABLE `msr_training` CHANGE COLUMN `activity_title` `activity_title` VARCHAR(150) NULL DEFAULT NULL ;


ALTER TABLE `job_assessment` ADD COLUMN `post_rank` FLOAT(2,1) NULL DEFAULT NULL AFTER `rank`;


CREATE TABLE `job_ey_assessement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT(11) NOT NULL,
  `ally_statisfaction` VARCHAR(45) NULL,
  `ally_complete_assess` INT(1) NULL DEFAULT 2,
  `ally_statisfaction_comment` TEXT NULL,
  `personal_growth` VARCHAR(45) NULL,
  `professional_growth` VARCHAR(45) NULL,
  `development_growth` VARCHAR(45) NULL,
  `asking_feedback` VARCHAR(45) NULL,
  `engaging_community` VARCHAR(45) NULL,
  `practicing_inclusion` VARCHAR(45) NULL,
  `initiative` VARCHAR(45) NULL,
  `personal_accountabitity` VARCHAR(45) NULL,
  `personal_responsability` VARCHAR(45) NULL,
  `team_work` VARCHAR(45) NULL,
  `org_increased` INT(1) NULL DEFAULT 2,
  `org_increased_benefit` TEXT NULL,
  `additional_sustainable` TEXT NULL,
  `work_leverage` TEXT NULL,
  `cap_increase_exp_id` INT(1) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `job_id_UNIQUE` (`job_id` ASC),
  UNIQUE INDEX `org_increased_UNIQUE` (`org_increased` ASC),
  UNIQUE INDEX `ally_complete_assess_UNIQUE` (`ally_complete_assess` ASC));
  
  ALTER TABLE `job` 
DROP COLUMN `position_population_served8_other`,
DROP COLUMN `position_population_served8`,
DROP COLUMN `position_population_served7`,
DROP COLUMN `position_population_served6`,
DROP COLUMN `position_population_served5`,
DROP COLUMN `position_population_served4`,
DROP COLUMN `position_population_served3`,
DROP COLUMN `position_population_served2`,
DROP COLUMN `position_population_served1`;

ALTER TABLE `job_assessment` 
CHANGE COLUMN `rank` `pre_assess_rank` FLOAT(2,1) NULL DEFAULT NULL ,
CHANGE COLUMN `post_rank` `post_assess_rank` FLOAT(2,1) NULL DEFAULT NULL ;


CREATE TABLE `stp_cap_increase_exp` (
  `id` INT(1) NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NULL,
  `name` VARCHAR(150) NULL,
  `active_flag` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC));

  
  ALTER TABLE `job_ey_assessement` 
ADD INDEX `fk_jeya_stpcap_idx` (`cap_increase_exp_id` ASC);
ALTER TABLE `job_ey_assessement` 
ADD CONSTRAINT `fk_jeya_stpcap`
  FOREIGN KEY (`cap_increase_exp_id`)
  REFERENCES `stp_cap_increase_exp` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
    ALTER TABLE `job_ey_assessement` 
ADD INDEX `fk_jeya_job_idx` (`job_id` ASC);
ALTER TABLE `job_ey_assessement` 
ADD CONSTRAINT `fk_jeya_job`
  FOREIGN KEY (`job_id`)
  REFERENCES `job` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


INSERT INTO `stp_cap_increase_exp` (`code`, `name`) VALUES ('IN', 'Increased number of people served at your organization');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`) VALUES ('IL', 'Improved level and/or quality of services at your organization');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`) VALUES ('SP', 'Started a new project/program at your organization');
INSERT INTO `stp_cap_increase_exp` (`code`, `name`) VALUES ('NC', 'No capacity increase experienced');

ALTER TABLE `job_ey_assessement` 
DROP FOREIGN KEY `fk_jeya_stpcap`;
ALTER TABLE `job_ey_assessement` 
CHANGE COLUMN `cap_increase_exp_id` `cap_increase_exp_ids` JSON NULL DEFAULT NULL ,
ADD COLUMN `msrId` INT(11) NULL AFTER `cap_increase_exp_ids`,
DROP INDEX `fk_jeya_stpcap_idx` ;

    ALTER TABLE `job_ey_assessement` 
ADD INDEX `fk_jeya_msr_idx` (`job_id` ASC);

ALTER TABLE `job_ey_assessement` 
CHANGE COLUMN `msrId` `msr_id` INT(11) NULL DEFAULT NULL ,
DROP INDEX `fk_jeya_msr_idx` ,
ADD INDEX `fk_jeya_msr_idx` (`msr_id` ASC);

ALTER TABLE `job_ey_assessement` 
ADD CONSTRAINT `fk_jeya_msr`
  FOREIGN KEY (`msr_id`)
  REFERENCES `msr` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `job_objective` 
DROP COLUMN `performance_standard_comments`,
DROP COLUMN `performance_standard`,
DROP COLUMN `performance_timeframe`,
CHANGE COLUMN `objective_assessment` `objective_assessment` VARCHAR(45) NULL DEFAULT NULL ;


ALTER TABLE `job_ey_assessement` 
ADD COLUMN `created_at` DATETIME NULL AFTER `msr_id`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`;

ALTER TABLE `job_ey_assessement` RENAME TO  `job_ey_assessment` ;

ALTER TABLE `msr` CHANGE COLUMN `has_pos_assessment` `has_pos_assessment` INT(1) NULL DEFAULT '0' ;

ALTER TABLE `job_ey_assessment` ADD COLUMN `submitted_user_id` INT(11) NULL AFTER `updated_at`;



ALTER TABLE `acts_progress` 
DROP FOREIGN KEY `action3_commit`;

ALTER TABLE `acts_progress` 
ADD CONSTRAINT `action3_commit`
  FOREIGN KEY (`commitment_id`)
  REFERENCES `acts_commitment` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  



================5/30/2019===========================================================================
ALTER TABLE document 
ADD staff_id INT(11) NULL DEFAULT NULL;

ALTER TABLE `document` 
ADD CONSTRAINT `document_ibfk_1`
  FOREIGN KEY (`staff_id`)
  REFERENCES `staff` (`id`);


========================================== 7/15/19====================================================
ALTER TABLE `job_objective` DROP COLUMN `assessment_date`;

===================================08/05/19=========================================================
UPDATE `graduate_status` SET `active_flag`='0' WHERE `id`='15';
UPDATE `stp_gender` SET `active_flag`=0 WHERE `code`='O';
UPDATE `stp_sex_orientation` SET `active_flag`=0 WHERE special_flag='PS';


=============================== 08/20/19====================================================
CREATE TABLE `change_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pk_id` INT NULL,
  `prior_json` JSON NULL,
  `after_json` JSON NULL,
  `by_users_id` INT NULL,
  `action_comment` TINYTEXT NULL,
  `object_name` VARCHAR(80) NULL,
  `created_at` DATETIME,
  PRIMARY KEY (`id`));
  
ALTER TABLE `ally` 
ADD COLUMN `created_at` DATETIME NULL AFTER `child_count`,
ADD COLUMN `modified_at` DATETIME NULL AFTER `created_at`,
ADD COLUMN `history` JSON NULL AFTER `modified_at`,
ADD COLUMN last_modified_users_id int NULL,
ADD COLUMN `sf_failed_flag` INT(1) NULL DEFAULT 0 AFTER `history`;

ALTER TABLE `users` 
ADD COLUMN last_updated_users_id int NULL,
ADD COLUMN `sf_failed_flag` INT(1) NULL DEFAULT 0 ;

ALTER TABLE `ally_profile` 
ADD COLUMN last_updated_users_id int NULL,
ADD COLUMN `sf_failed_flag` INT(1) NULL DEFAULT 0 ;


ALTER TABLE `ally` 
CHANGE COLUMN `modified_at` `updated_at` DATETIME NULL DEFAULT NULL ;

ALTER TABLE `ally` 
CHANGE COLUMN `updated_at` `updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP ;

ALTER TABLE `ally_profile` 
CHANGE COLUMN `updated_at` `updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP ;

ALTER TABLE `users` 
CHANGE COLUMN `updated_at` `updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP ;

CREATE TABLE `sf_failure_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sf_id` VARCHAR(45) NULL,
  `lj_objects` JSON NULL,
  `error` TEXT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));
  
ALTER TABLE `sf_failure_log` 
ADD COLUMN sf_object varchar(60)  ;


ALTER TABLE `staff` 
ADD COLUMN `last_modified_users_id` INT NULL AFTER `sf_ids`,
ADD COLUMN `created_at` DATETIME NULL AFTER `last_modified_users_id`,
ADD COLUMN `updated_at` DATETIME NULL AFTER `created_at`,
ADD COLUMN `history` JSON NULL AFTER `updated_at`;

ALTER TABLE `partner_supervisor` 
ADD COLUMN `last_modified_users_id` INT NULL AFTER `self_update_date`,
ADD COLUMN `history` JSON NULL AFTER `last_modified_users_id`;

ALTER TABLE `partner` 
ADD COLUMN `last_modified_users_id` INT NULL AFTER `ein`,
ADD COLUMN `history` JSON NULL AFTER `last_modified_users_id`;


ALTER TABLE `job` 
ADD COLUMN `last_modified_users_id` INT NULL AFTER `enforce_dates`;

ALTER TABLE `staff` 
ADD COLUMN `sf_failed_flag` INT NULL DEFAULT 0 AFTER `history`;

ALTER TABLE `partner_supervisor` 
ADD COLUMN `sf_failed_flag` INT NULL DEFAULT 0;

ALTER TABLE `partner` 
ADD COLUMN `sf_failed_flag` INT NULL DEFAULT 0;

ALTER TABLE `staff` 
CHANGE COLUMN `last_modified_users_id` `last_updated_users_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `job` 
CHANGE COLUMN `last_modified_users_id` `last_updated_users_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `partner` 
CHANGE COLUMN `last_modified_users_id` `last_updated_users_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `partner_supervisor` 
CHANGE COLUMN `last_modified_users_id` `last_updated_users_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `contact` ADD COLUMN `sf_failed_flag` INT(1) NULL DEFAULT 0 AFTER `sf_id`;

ALTER TABLE `ally` 
CHANGE COLUMN `last_modified_users_id` `last_updated_users_id` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `change_history` 
ADD COLUMN `change_diff` TEXT NULL AFTER `created_at`;

ALTER TABLE `ally` CHANGE COLUMN `updated_at` `updated_at` DATETIME NULL ;
ALTER TABLE `ally_profile` CHANGE COLUMN `updated_at` `updated_at` DATETIME NULL ;
ALTER TABLE `users` CHANGE COLUMN `updated_at` `updated_at` DATETIME NULL ;



ALTER TABLE `login_log` 
ADD COLUMN `ip` VARCHAR(45) NULL AFTER `users_id`,
ADD COLUMN `client` VARCHAR(100) NULL AFTER `ip`;
ALTER TABLE `login_log` 
CHANGE COLUMN `client` `client` VARCHAR(150) NULL DEFAULT NULL ;

CREATE TABLE `stp_http_client` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(5) NULL,
  `name` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `login_log` DROP COLUMN `client`;

ALTER TABLE `pay_period` 
ADD COLUMN `ally_submitted_from_ip` VARCHAR(45) NULL AFTER `total_tsp`,
ADD COLUMN `pos_approved_from_ip` VARCHAR(45) NULL AFTER `ally_submitted_from_ip`,
ADD COLUMN `pm_approved_from_ip` VARCHAR(45) NULL AFTER `pos_approved_from_ip`;

ALTER TABLE `login_log` 
ADD COLUMN `client_id` INT(11) NULL AFTER `ip`,
ADD INDEX `fk_ll_client_idx` (`client_id` ASC);
ALTER TABLE `login_log` 
ADD CONSTRAINT `fk_ll_client`
  FOREIGN KEY (`client_id`)
  REFERENCES `stp_http_client` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
 ===================== 10/06/19========================================================

ALTER TABLE `users` 
ADD COLUMN `default_term_id` SMALLINT(3) NULL ,
ADD INDEX `fk_users_term_idx` (`default_term_id` ASC);
ALTER TABLE `users` 
ADD CONSTRAINT `fk_users_term`
  FOREIGN KEY (`default_term_id`)
  REFERENCES `term` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `ally` DROP COLUMN `enrolled_college_period_flag`;
  ALTER TABLE `demographic_snapshot` DROP COLUMN `enrolled_college_period_flag`;
  update ally set enrolled_college_period = null where enrolled_24college_flag = 1;
  
  ALTER TABLE `ally_profile` 
DROP FOREIGN KEY `FKsy0e1ex9w3lmc1o4765jw44rv`,
DROP FOREIGN KEY `FKla1pp86fbeq23a5xflr7obesj`,
DROP FOREIGN KEY `FKiogn3rykxoba9920l3u3ecj8w`,
DROP FOREIGN KEY `FK3iciqmselafc4ddrwgghq14m8`;
ALTER TABLE `ally_profile` 
DROP INDEX `UKbuvh0ei8xn512tabnrn17asrn` ,
DROP INDEX `FKla1pp86fbeq23a5xflr7obesj`
;

ALTER TABLE `ally_profile` 
DROP INDEX `UKbuvh0ei8xn512tabnrn17asrn` ;

update ally set employment_title = null, employer_name = null, employment_period = null 
where employment_status_id is null or employment_status_id in (select id from stp_employ_status where code ='UP');

update ally set unemployment_period = null 
where employment_status_id is null or employment_status_id not in (select id from stp_employ_status where code ='UP');

DROP TABLE `users_role_history`;
DROP TABLE `users_role`;



======================================= 10/20/19===========================================================
ALTER TABLE `job` 
ADD COLUMN `sf_id` VARCHAR(45) NULL AFTER `last_updated_users_id`;

ALTER TABLE `partner_supervisor` 
DROP COLUMN `old_id`;

CREATE TABLE `lj_task` (
  `id` INT(11) NOT NULL,
  `title` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `assigned_role` VARCHAR(10) NULL,
  `assigned_users_id` INT(11) NULL,
  `assigned_site_id` SMALLINT(3) NULL,
  `status_code` VARCHAR(2) NOT NULL,
  `lj_table` VARCHAR(45) NULL,
  `lj_pk_id` INT(11) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `history` JSON NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `sf_failure_log` 
ADD COLUMN `task_id` INT(11) NULL AFTER `sf_object`;


CREATE TABLE `saved_qb` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `qb_state` JSON NULL,
  `saved_by_users_id` INT(11) NULL,
  `shared_with_users_id` INT(11) NULL,
  `shared_with_users_groups` JSON NULL,
  `title` VARCHAR(150) NOT NULL,
  `run_count` INT(5) NULL,
  `created_at` DATETIME NULL,
  `shared_with_site_id` SMALLINT(3) NULL,
  `schedule` VARCHAR(50) NULL,
  `scheduled_users_ids` JSON NULL,
  `schedule_run_users` JSON NULL,
  `schedule_run_flag` INT(1) NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `job` 
ADD COLUMN `sf_failed_flag` INT(1) NULL DEFAULT 0 AFTER `sf_id`;


  ALTER TABLE `ally` 
CHANGE COLUMN `employer_name` `employer_name` VARCHAR(120) NULL DEFAULT NULL ;


  ALTER TABLE `saved_qb` 
DROP COLUMN `schedule_run_flag`,
DROP COLUMN `schedule_run_users`,
DROP COLUMN `scheduled_users_ids`,
DROP COLUMN `schedule`,
DROP COLUMN `shared_with_site_id`,
DROP COLUMN `shared_with_users_id`,
CHANGE COLUMN `shared_with_users_groups` `shared_site_ids` JSON NULL DEFAULT NULL ,
ADD COLUMN `shared_flag` INT(1) NOT NULL DEFAULT 0 AFTER `created_at`;

  
  ALTER TABLE `saved_qb` 
ADD COLUMN `shared_role_codes` JSON NULL AFTER `shared_flag`,
ADD COLUMN `saved_by_user_role_code` CHAR(3) NULL AFTER `shared_role_codes`,
ADD COLUMN `description` TEXT NULL AFTER `saved_by_user_role_code`;


  
  ================================11/17/19==========================================
  update ally_profile set report_excluded_flag = 0 where report_excluded_flag is null;
  
  ALTER TABLE `ally_profile` 
CHANGE COLUMN `report_excluded_flag` `report_excluded_flag` INT(1) NOT NULL DEFAULT 0 ;

  
================================12/16/19==========================================
update graduate_status set active_flag= 0 where id in (15,20); 

===========================12/26/19==============================================
update ally_profile_history aph, ally_profile ap
set aph.ally_exit_reason_id = ap.ally_exit_reason_id
where aph.ally_profile_id = ap.id and aph.graduate_status_id in (20,25,35,40);

ALTER TABLE `ally_profile_history` DROP COLUMN `exit_reason`;

ALTER TABLE `ally_profile_history` 
DROP COLUMN `old_id`,
DROP COLUMN `created_by`,
ADD COLUMN `updated_by` VARCHAR(100) NULL AFTER `status_end_date`,
DROP INDEX `old_id_UNIQUE` ;

ALTER TABLE `ally_profile_history` 
CHANGE COLUMN `updated_by` `updated_by_user_id` INT(11) NULL DEFAULT NULL ;

============================ 01/19/20===================================================
ALTER TABLE `job` 
DROP COLUMN `cap_type_id`,
DROP COLUMN `job_status_id`,
DROP COLUMN `secondary_issue_area`,
DROP COLUMN `primary_issue_area`,
DROP COLUMN `description`,
DROP COLUMN `ally_id`,
DROP COLUMN `site_id`,
DROP COLUMN `term_id`;

ALTER TABLE `job_objective` 
DROP COLUMN `ally_id`,
DROP COLUMN `partner_supervisor_id`,
DROP COLUMN `partner_profile_id`,
DROP COLUMN `partner_id`,
DROP COLUMN `site_profile_id`,
DROP COLUMN `site_id`,
DROP COLUMN `term_id`;

ALTER TABLE `survey_site_profile` 
ADD COLUMN `ally_program_status_flag` INT(1) NULL,
ADD COLUMN `graduate_status_ids` JSON NULL;



update `survey_site_profile` set ally_program_status_flag = 0 where id > 0;

ALTER TABLE `survey_site_profile` 
CHANGE COLUMN `ally_program_status_flag` `ally_program_status_flag` INT(1) NOT NULL ;

ALTER TABLE `survey_site_profile` 
CHANGE COLUMN `ally_program_status_flag` `ally_program_status_flag` INT(1)  NULL ;


  
  update survey_site_profile set `ally_program_status_flag` = 1, `graduate_status_ids` = '[10,15,30]' where all_allies_flag = 1;

  update `survey_site_profile` set ally_program_status_flag = 0 where all_allies_flag = 0;
  
ALTER TABLE `survey_site_profile` CHANGE COLUMN `ally_program_status_flag` `ally_program_status_flag` INT(1) NOT NULL ;
  
  ALTER TABLE `survey_site_profile` CHANGE COLUMN `all_allies_flag` `all_allies_flag` INT(1) NULL ;

   update ally_profile set 
 assigned_survey_site = "[]"
  where graduation_status_id not in (10,15,30);
  
  update ally_profile uap,
  (
  select ap.id, GROUP_CONCAT(distinct sp.id separator ',') as js from ally_profile ap, survey_site_profile sp
  where sp.ally_program_status_flag = 0 and 
  JSON_CONTAINS(sp.apIds, CAST(ap.id as JSON), '$')
  group by ap.id) sq
  set uap.assigned_survey_site = concat("[", sq.js, "]")
  where uap.id = sq.id and uap.graduation_status_id not in (10,15,30);

  
  delete from 
survey_response 
where
submitted_flag != 1
and target_id in 
(select id from ally_profile where graduation_status_id not in (10,15,30))
and survey_site_id in (select id from survey_site_profile where ally_program_status_flag = 1);

// VIEW vw_ap_tl_approval has been updated


 ====================== 02/23/2020========================================= 
  CREATE TABLE `sp_demographic_snapshot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_supervisor_id` int(11) NOT NULL,
  `term_id` smallint(3) NOT NULL,
  `gender_id` int(1) DEFAULT NULL,
  `gender_name` varchar(100) DEFAULT NULL,
  `gender_other` varchar(100) DEFAULT NULL,
  `race_ids_json` json DEFAULT NULL,
  `race_names_json` json DEFAULT NULL,
  `race_other` varchar(100) DEFAULT NULL,
  `higher_education_id` int(2) DEFAULT NULL,
  `higher_education_name` varchar(100) DEFAULT NULL,
  `sex_orientation_id` int(2) DEFAULT NULL,
  `sex_orientation_name` varchar(100) DEFAULT NULL,
  `sex_orientation_other` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `lgbtq_flag` varchar(15) DEFAULT NULL,
  `p_position_period` int(2) DEFAULT NULL,
  `c_position_period` int(2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sp_demo_snapshot_id_UNIQUE` (`partner_supervisor_id`, term_id),
  CONSTRAINT `fk_sp_demo_sp` FOREIGN KEY (`partner_supervisor_id`) REFERENCES `partner_supervisor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sp_demo_term` FOREIGN KEY (`term_id`) REFERENCES `term` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB   CHARSET=latin1;


ALTER TABLE `survey_site_profile` 
CHANGE COLUMN `due_date_trigger` `due_date_trigger` ENUM('ALLY_START_DATE', 'ALLY_END_DATE', 'ALLY_PROGRAM_STATUS_EFFECTIVE_DATE') NULL DEFAULT NULL ,
CHANGE COLUMN `start_date_trigger` `start_date_trigger` ENUM('ALLY_START_DATE', 'ALLY_END_DATE', 'ALLY_PROGRAM_STATUS_EFFECTIVE_DATE') NULL DEFAULT NULL ;

  /////// APPLIED DEV and PROD

============================ 04/08/20=====================================================================
ALTER TABLE `ally_exit_reason` ADD COLUMN `cpc_exit_only_flag` INT(1) NOT NULL DEFAULT 0 AFTER `old_id`;

// In prod// INSERT INTO `ally_exit_reason` (`id`, `name`, `cpc_exit_only_flag`) VALUES ('8', 'COVID-19 / Coronavirus', '1');

ALTER TABLE `ally_exit_reason` DROP COLUMN `old_id`;


===============================================  04/18/2020 ==================================================
CREATE TABLE `hst_pay_period` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pay_period_id` INT NULL,
  `system_flag` INT(1) NOT NULL,
  `users_id` INT NULL,
  `action_description` TEXT NULL,
  `created_at` DATETIME NULL,
  CONSTRAINT `fk_hst_pp_pp` FOREIGN KEY (`pay_period_id`) REFERENCES `pay_period` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hst_pp_usr` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  PRIMARY KEY (`id`));
  
  
    CREATE TABLE `stp_timesheet_elt` (
  `id` INT(3) NOT NULL,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`));
  
  insert into stp_timesheet_elt (id, name) select id, name from ref_table_data where ref_table_code = 'TRC';
  
  ALTER TABLE `time_sheet` 
DROP FOREIGN KEY `FKtfo76mjn9xcg7yfw7fmff8tuc`,
DROP FOREIGN KEY `FKn8xpbbp0b45vmoqq90dnphmih`;

ALTER TABLE `time_sheet` 
DROP COLUMN `old_id`,
DROP COLUMN `notes`,
DROP COLUMN `time_sheet_day`,
DROP COLUMN `ally_profile_id`,
DROP COLUMN `program_year_id`,
DROP INDEX `FKtfo76mjn9xcg7yfw7fmff8tuc` ,
DROP INDEX `FKn8xpbbp0b45vmoqq90dnphmih` ;
;

ALTER TABLE `pay_period` 
DROP FOREIGN KEY `FKs2hhyroaem9o92gnwgvp59cvx`,
DROP FOREIGN KEY `FKbtpyp9qqfwj1c0vai5hiw4fhd`,
DROP FOREIGN KEY `fk_payP_siteP`,
DROP FOREIGN KEY `fk_payP_Py`;

ALTER TABLE `pay_period` 
DROP COLUMN `program_year_id`,
DROP COLUMN `old_id`,
DROP COLUMN `site_profile_id`,
DROP INDEX `fk_payP_Py_idx` ,
DROP INDEX `fk_payP_siteP` ;

ALTER TABLE `hst_pay_period` 
ADD COLUMN `old_full_name` VARCHAR(100) NULL AFTER `created_at`;


// vw_ap_tl_approval has been updated.
// Run the process fix url

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







