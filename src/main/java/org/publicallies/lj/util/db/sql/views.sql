DROP FUNCTION IF EXISTS getFullAddress;
DELIMITER $$
create function getFullAddress(address1 varchar(200), address2 varchar(200), city varchar(200), state varchar(30), zip varchar(20)) returns varchar(500)
DETERMINISTIC
begin
  return CONCAT(IFNULL(address1, ''), ' ' ,  IFNULL(address2, '') , ' ' ,   IFNULL(city, ''), ' ',   IFNULL(state, '') , ', ' ,   IFNULL(zip, ''));
end;  
$$
DROP FUNCTION IF EXISTS getFullName 
$$
create function getFullName(first_name varchar(200), middle_name varchar(200), last_name varchar(200)) returns varchar(500)
DETERMINISTIC
begin
  return CONCAT(IFNULL(first_name, ''), ' ',  IFNULL(middle_name, ''), ' ',   IFNULL(last_name, ''));
end;  
$$

DROP FUNCTION IF EXISTS getUsDate 
$$
create function getUsDate(inDate date) returns varchar(12)
DETERMINISTIC
begin
  return IFNULL(DATE_FORMAT(inDate, "%m/%d/%Y"), '') ;
end;  
$$

DELIMITER $$
DROP FUNCTION IF EXISTS toYesNo $$
create function toYesNo(inVal varchar(3)) returns varchar(12)
DETERMINISTIC
begin
	declare result varchar(12);
	if inVal = '1' then set result = 'Yes';
	elseif  inVal = '0' then set result = 'No';
	else set result = '';
	end if;
	
  return result;
end;  
$$

DROP FUNCTION IF EXISTS toYesNoUnsure $$
create function toYesNoUnsure(inVal varchar(3)) returns varchar(12)
DETERMINISTIC
begin
	declare result varchar(12);
	if inVal = '1' then set result = 'Yes';
	elseif  inVal = '0' then set result = 'No';
	elseif  inVal = '2' then set result = 'Unsure';
	else set result = '';
	end if;
	
  return result;
end;  
$$

DELIMITER ;


create or replace view report_ally_profile
as
select * from ally_profile where report_excluded_flag != 1;

 create or replace view vw_time_log_summary
 as
  select 
 ally_profile_id,
 month(period_end_date) as period_month,
 year(period_end_date) as period_year,
 job_id,
 sum(grand_total) pps_grand_total, 
 sum(total_placement) pps_total_placement,
 sum(total_fundraising) pps_total_fundraising,
 sum(total_tsp) pps_total_tsp,
 sum(total_service) pps_total_service,
 sum(total_training) pps_total_training
 from pay_period
 where pm_approval_status_code ='AP'
 group by ally_profile_id, job_id, period_month, period_year;
 
 
 
 create or replace view vw_ally_profile as   
 select 
ap.id as ap_id,
ap.refilled,
ap.refillment,
ap.status_effective_date,
ap.refilled_ally_profile_id,
(select pathway_type_code from msr_pathways join msr on (msr.id = msr_pathways.msr_id) where msr.ally_profile_id = ap.id and  msr.ally_submit_status_code = 'SB' order by msr.start_date desc limit 1) as pathways_code,
 u.id as u_id,
 u.first_name,
 u.middle_name,
 u.last_name,
 gs.name as gs_name,
 st.name as st_name,
 sp.id as sp_id,
 ap.graduation_status_id,
 sp.slot_type_id,
 IFNULL(st.max_hours, 0) slot_max_hours,
 IFNULL(pps.pps_grand_total, 0) pps_grand_total,  
 IFNULL(pps.pps_total_placement, 0) pps_total_placement,
 IFNULL(pps.pps_total_fundraising, 0) pps_total_fundraising,
 IFNULL(pps.pps_total_tsp, 0) pps_total_tsp,
 IFNULL(pps.pps_total_service, 0) pps_total_service,
 IFNULL(pps.pps_total_training, 0) pps_total_training,
IFNULL(pps_grand_total, 0)/ st.max_hours as ratioHoursCompleted

from report_ally_profile ap
join graduate_status gs on (gs.id = ap.graduation_status_id)
join ally a on (a.id = ap.ally_id)
join users u on (u.id = a.users_id)
join site_profile sp on (ap.site_profile_id = sp.id)
join slot_type st on (st.id = sp.slot_type_id)
left join 

(
 select 
 ally_profile_id,
 sum(pps_grand_total) pps_grand_total, 
 sum(pps_total_placement) pps_total_placement,
 sum(pps_total_fundraising) pps_total_fundraising,
 sum(pps_total_tsp) pps_total_tsp,
 sum(pps_total_service) pps_total_service,
 sum(pps_total_training) pps_total_training
 from vw_time_log_summary
 group by ally_profile_id
 ) pps
 on (pps.ally_profile_id = ap.id);
 
 
 
 create or replace VIEW vw_site_refillment AS
 SELECT 
b.sp_id AS sp_id,
b.slots_granted AS slots_granted,
b.slots_used AS slots_used,
COALESCE(a.refillment_flag, 0) AS available_refillments
FROM
(vw_site_profile b
LEFT JOIN (SELECT 
vw_ally_profile.sp_id AS sp_id,
COUNT(vw_ally_profile.sp_id) AS refillment_flag
FROM
vw_ally_profile
WHERE
((vw_ally_profile.graduation_status_id = 35)
AND (vw_ally_profile.ratioHoursCompleted < 0.3)
AND (vw_ally_profile.refilled <> 1))
GROUP BY vw_ally_profile.sp_id) a ON ((a.sp_id = b.sp_id)));
        
        

CREATE or replace VIEW vw_site_profile AS
SELECT 
sp.id AS sp_id,
sp.slots_granted AS slots_granted,
COALESCE(sq1.total, 0) AS slots_used
FROM
(site_profile sp
LEFT JOIN (SELECT 
ally_profile.site_profile_id AS site_profile_id,
COUNT(DISTINCT ally_profile.id) AS total
FROM
ally_profile
WHERE
((ISNULL(ally_profile.refilled)
OR (ally_profile.refilled <> 1))
AND (ally_profile.graduation_status_id = 10))
GROUP BY ally_profile.site_profile_id) sq1 ON ((sq1.site_profile_id = sp.id)));   


CREATE or replace VIEW vw_ap_tl_approval AS
SELECT ap.id,  sq.* 
FROM ally_profile ap 
LEFT JOIN (
	SELECT p.ally_profile_id as ally_profile_id, 
	       month(p.period_end_date) as period_month,
           year(p.period_end_date) as period_year,
			COUNT(p.id) as total_generated, 
			 sum(IF(p.pm_approval_status_code = 'AP', grand_total, 0)) grand_total, 
			 sum(IF(p.pm_approval_status_code = 'AP', total_placement, 0)) total_placement,
			 sum(IF(p.pm_approval_status_code = 'AP', total_fundraising, 0)) total_fundraising,
			 sum(IF(p.pm_approval_status_code = 'AP', total_tsp, 0)) total_tsp,
			 sum(IF(p.pm_approval_status_code = 'AP', total_service, 0)) total_service,
			 sum(IF(p.pm_approval_status_code = 'AP', total_training, 0)) total_training,
			SUM(IF(p.ally_submit_status_code = 'SB', 1, 0)) AS ally_sb_total,
			SUM(IF(p.ally_submit_status_code = 'SB', grand_total, 0)) AS ally_sb_total_hours, 
			SUM(IF(p.pos_approval_status_code = 'AP', 1, 0)) AS pos_ap_total,
			SUM(IF(p.pos_approval_status_code = 'AP', grand_total, 0)) AS pos_ap_total_hours,
			SUM(IF(p.pm_approval_status_code = 'AP', 1, 0)) AS pm_ap_total,
			SUM(IF(p.pm_approval_status_code = 'AP', grand_total, 0)) AS pm_ap_total_hours,
		    SUM(IF(p.pm_approval_status_code = 'AP' AND to_days(p.pm_approved_date) <= to_days(p.period_end_date) + 10, 1, 0)) AS approved_10_total,
		    SUM(IF(p.pm_approval_status_code = 'AP' AND to_days(p.pm_approved_date) <= to_days(p.period_end_date) + 10, grand_total, 0)) AS approved_10_total_hours,
		    SUM(IF(p.pm_approval_status_code = 'AP' AND to_days(p.pm_approved_date) > to_days(p.period_end_date) + 10, grand_total, 0)) AS approved_outside_10_total_hours
	FROM pay_period p
	GROUP BY p.ally_profile_id, period_month, period_year
	) sq on (ap.id = sq.ally_profile_id);
	

CREATE or replace VIEW vw_users AS
	select u.*, s.id as staff_id, pos.id as pos_id, a.id as ally_id, '' as ro_workaround
	from users u
	left join staff s on (s.users_id = u.id)
	left join partner_supervisor pos on (pos.users_id = u.id)
	left join ally a on (a.users_id = u.id);
	
create or replace view vw_ally_profile_jassess
 as	
  select j.ally_profile_id, sum(ja.post_assess_rank - ja.pre_assess_rank) as increased 
  from job_assessment ja
  join job j on (j.id = ja.job_id)
 join job_ey_assessment jea on (j.id = jea.job_id)
 join msr on (msr.id = jea.msr_id and msr.pos_approval_status_code = 'AP')
 where ja.pre_assess_rank is not null and ja.post_assess_rank is not null
 group by j.ally_profile_id;
 
 create or replace view vw_ap_pos_jassess
 as	
 select j.ally_profile_id, j.partner_supervisor_id, (ja.post_assess_rank - ja.pre_assess_rank) as increased 
 from job_assessment ja
 join job j on (j.id = ja.job_id)
 join job_ey_assessment jea on (jea.job_id = ja.job_id)
 join msr on (msr.id = jea.msr_id and msr.pos_approval_status_code = 'AP')
 where ja.pre_assess_rank is not null and ja.post_assess_rank is not null
 group by j.ally_profile_id, j.partner_supervisor_id;
 
 create or replace view vw_pos_jassess
 as	
 select ap.site_profile_id, vap.partner_supervisor_id, sum(vap.increased)  as increased
 from vw_ap_pos_jassess vap
 inner join ally_profile ap on (ap.id = vap.ally_profile_id)
 group by site_profile_id, partner_supervisor_id;
 


create or replace view vw_job_assess
 as	
  select j.id as job_id, sum(ja.post_assess_rank - ja.pre_assess_rank) as increased 
  from job_assessment ja
  join job j on (j.id = ja.job_id)
 join job_ey_assessment jea on (j.id = jea.job_id)
 join msr on (msr.id = jea.msr_id and msr.pos_approval_status_code = 'AP')
 where ja.pre_assess_rank is not null and ja.post_assess_rank is not null
 group by j.id;
 

create or replace view vw_site_profile_name as 
select sp.*, s.name as site_name, py.title as py_title, pgm.name as program_name
from site_profile sp 
join site s on (s.id = sp.site_id)
join program_year py on (py.id = sp.program_year_id)
join program pgm on (pgm.id = py.program_id);

 
create or replace view vw_ally as 
select 
a.*,
u.first_name,
u.last_name,
u.middle_name,
state.code as address_state_code,
u.address1,
u.address2,
u.city,
u.zip,
u.phone_home,
u.phone_cell,
u.email,
u.dob,
REPLACE(gd.name, 'Prefer to Self-Describe', ifnull(u.gender_other, '')) as gd_name,
u.gender_id,
seo.name as seo_name,
u.sex_orientation_other,
u.id as u_id,
u.sf_id as u_sf_id,
edu.name as edu_name,
scpedu.name as last_college_period_name,
scpep.name as employment_period_name,
scpup.name as unemployment_period_name,
u.lgbtq_flag,
REPLACE(( SELECT GROUP_CONCAT(stp_race.name, '  ') FROM stp_race where JSON_CONTAINS(u.race_ids, CAST(id as JSON), '$')), 'Other Race', ifnull(u.race_other, ' ')) as race_names,
REPLACE(( SELECT GROUP_CONCAT(stp_social_assist.name, '  ') FROM stp_social_assist where JSON_CONTAINS(a.social_assists, CAST(id as JSON), '$')), 'None of the above options', '') as social_assist_name,
toYesNo(cast(a.convicted_flag as  char(3))) as convicted_flag_yn,
toYesNo(cast(a.enrolled_24college_flag as  char(3))) as enrolled_24college_flag_yn,
toYesNo(cast(a.parent_graduate_college as  char(3))) as parent_graduate_college_yn,
toYesNo(cast(a.military_veteran as  char(3))) as military_veteran_yn,
toYesNo(cast(u.lgbtq_flag as  char(3))) as lgbtq_flag_yn,
toYesNo(cast(u.disability_flag as  char(3))) as disability_flag_yn,
toYesNoUnsure(cast(a.received_gov_assist as  char(3))) as received_gov_assist_yn,
toYesNoUnsure(cast(a.applied_gov_assist as  char(3))) as applied_gov_assist_yn,
toYesNoUnsure(cast(a.current_receive_gov_assist as  char(3))) as current_receive_gov_assist_yn,
(
    case 
      when u.disability_flag is not null and u.disability_flag = 1 then u.disability_desc
      else ''
     end
) as disability_name,
u.sex_orientation_id,
sor.name as sex_orientation_name,
u.race_ids,
u.higher_education_id,
ses.name as employ_status_name,
u.disability_desc
from ally a
inner join vw_users u on (u.id = a.users_id)
left join stp_gender gd on (gd.id = u.gender_id)
left join stp_sex_orientation seo on (seo.id = u.sex_orientation_id)
left join stp_education edu on (edu.id = u.higher_education_id)
left join state on (state.id = u.state_id)
left join stp_sex_orientation sor on (sor.id = u.sex_orientation_id)
left join stp_employ_status ses on (ses.id = a.employment_status_id )
left join stp_common_period scpedu on (scpedu.id = a.enrolled_college_period)
left join stp_common_period scpep on (scpep.id = a.employment_period)
left join stp_common_period scpup on (scpup.id = a.unemployment_period)
;


create or replace view vw_qb as
select 
py.title as py_title,
py.id as py_id,
pgm.name as pgm_name,
st.name as st_name,
st.id as st_id,
getFullName(vuf.first_name, vuf.middle_name, vuf.last_name) as pm_name,
va.first_name as a_first_name,
va.last_name as a_last_name,
va.gd_name as a_gender_name,
va.gender_id as a_gender_id,
j.id as j_id,
j.title as j_title,
p.organization_name as p_organization_name,
p.id as p_id, p.sf_id as p_sf_id,
getFullName(vup.first_name, vup.middle_name, vup.last_name) as pos_name,
vup.sf_id as pos_u_sf_id,
vup.email as pos_email,
vup.phone_cell as pos_phone_cell,
vup.phone_office as pos_phone_office,
vup.phone_office_ext as pos_phone_office_ext,
vup.pos_id as pos_id,
vapj.increased as vapj_increased,
vpj.increased as vpj_increased,
va.edu_name as a_edu_name,
vap.gs_name as a_gs_name,
va.email as a_email,
va.phone_home as a_phone_home,
va.phone_cell as a_phone_cell,
va.address1 as a_address1,
va.address2 as a_address2,
va.city as a_city,
va.zip as a_zip,
va.address_state_code as a_address_state_code,
va.race_names as a_race_names,
va.race_ids as a_race_ids,
va.sex_orientation_id as a_sex_orientation_id,
va.sex_orientation_name as a_sex_orientation_name,
va.u_sf_id as a_sf_id,
va.alumni_sfId as a_alumni_sf_id,
getUsDate(va.dob) as a_dob,
va.employ_status_name as a_employ_status_name,
va.employment_status_id as a_employment_status_id,
date(ap.ally_start_date) as a_ally_start_date,
date(ap.anticipated_graduation_date) as a_anticipated_graduation_date,
toYesNo(cast(j.enforce_dates as char(3))) as j_dates_enforced,
va.lgbtq_flag_yn as a_lgbtq_flag,
va.disability_flag_yn as a_disability_flag,
va.disability_name as a_disability_desc,
REPLACE(j.approval_status, 'AP', 'Approved') as j_approved,
date(j.start_date) as j_start_date,
date(j.end_date) as j_end_date,
vap.pathways_code as ap_pathways_code,
ap.graduation_status_id as ap_graduation_status_id,
sp.slot_type_id as sp_slot_type_id,
slot_type.name as slot_type_name,
spt.name as spt_name,
ap.id as ap_id,
ap.sf_id as ap_sf_id,
va.id as a_id,
ap.pos_approves_pisd_flag as ap_pos_approves_pisd_flag,
toYesNo(ap.pos_approves_pisd_flag) as ap_pos_approves_pisd_flag_yn,
va.lgbtq_flag as a_lgbtq_flag_id,
va.higher_education_id as a_higher_education_id,
va.convicted_flag_yn as a_convicted_flag,
va.enrolled_24college_flag_yn as a_enrolled_24college_flag,
va.parent_graduate_college_yn as a_parent_graduate_college,
va.military_veteran_yn as a_military_veteran,
FORMAT(taxable_earn_income, 2) as a_taxable_earn_income,
FORMAT(pps_grand_total, 2) as ap_pps_grand_total,
FORMAT(pps_total_placement, 2) as ap_pps_total_placement,
FORMAT(pps_total_fundraising, 2) as ap_pps_total_fundraising,
FORMAT(pps_total_tsp, 2) as ap_pps_total_tsp,
FORMAT(pps_total_service, 2) as ap_pps_total_service,
FORMAT(pps_total_training, 2) as ap_pps_total_training,
concat(FORMAT(100*ratioHoursCompleted, 2), '%') as ap_ratioHoursCompleted,
p.ein as p_ein,
p.mission as p_mission,
sms.name as a_mariatl_status,
va.received_gov_assist_yn as a_received_gov_assist,
va.applied_gov_assist_yn  as a_applied_gov_assist,
va.current_receive_gov_assist_yn as a_current_receive_gov_assist,
va.social_assist_name as a_social_assist_name,
va.child_count as a_child_count,
FORMAT(ap.stipend_amount, 2) as ap_stipend_amount,
date(ap.status_effective_date) as ap_status_effective_date,
FORMAT(j.partner_fee,2) as j_partner_fee,
stp_partner_type.name as p_partner_type_name, 
p.address1 as p_address1,
p.address2 as p_address2,
p.city as p_city,
p.zip as p_zip,
pstate.code as p_address_state_code,
p.phone_office as p_phone_office,
p.phone_office_ext as p_phone_office_ext,
p.fax as p_fax,
p.website as p_website,
va.last_college_period_name as a_last_college_period_name,
aer.name as ap_ally_exit_reason_name,
va.employment_title as a_employment_title,
va.employer_name as a_employer_name,
va.unemployment_period_name as a_unemployment_period_name,
va.employment_period_name as a_employment_period_name,
(select group_concat(concat_ws(' ', graduate_status.name, getUsDate(aph.graduate_status_date), aph.notes )  SEPARATOR '; ') from ally_profile_history aph join graduate_status on (graduate_status.id = aph.graduate_status_id) where aph.ally_profile_id = ap.id) as ap_status_history,
concat_ws(' ', pgen_contact.first_name, pgen_contact.last_name, 'Email:', pgen_contact.email, 'Phone: ', pgen_contact.phone_office, 'Ext: ', pgen_contact.phone_office_ext)  as p_general_contact,
concat_ws(' ', pfin_contact.first_name, pfin_contact.last_name, 'Email:', pfin_contact.email, 'Phone: ', pfin_contact.phone_office, 'Ext: ', pfin_contact.phone_office_ext)  as p_financial_contact,
concat_ws(' ', pexec_contact.first_name, pexec_contact.last_name, 'Email:', pexec_contact.email, 'Phone: ', pexec_contact.phone_office, 'Ext: ', pexec_contact.phone_office_ext)  as p_executive_contact
from report_ally_profile ap
join vw_ally va on (va.id = ap.ally_id)
left join vw_ally_profile vap on (ap.id = vap.ap_id)
left join site_profile sp on (sp.id = ap.site_profile_id)
left join site st on (st.id = sp.site_id)
left join program_year py on (py.id = sp.program_year_id)
left join program pgm on (pgm.id = py.program_id)
left join vw_users vuf on (vuf.staff_id = ap.program_manager_id)
left join job j on (j.ally_profile_id = ap.id)
left join partner_supervisor pos on (pos.id  = j.partner_supervisor_id)
left join vw_users vup on (vup.pos_id = pos.id)
left join partner p on (p.id = j.partner_id)
left join vw_ally_profile_jassess vapj on (vapj.ally_profile_id = ap.id)
left join vw_pos_jassess vpj on (vpj.partner_supervisor_id = j.partner_supervisor_id and vpj.site_profile_id = j.site_profile_id)
left join slot_type on (slot_type.id = sp.slot_type_id)
left join stp_pathways_type spt on (spt.code = vap.pathways_code)
left join stp_marital_status sms on (sms.id = va.marital_status_id)
left join stp_partner_type  on (stp_partner_type.id = p.organization_type_id)
left join state pstate on (pstate.id = p.state_id)
left join contact as pgen_contact on (pgen_contact.id = p.contact_gen_id)
left join contact as pfin_contact on (pfin_contact.id = p.contact_finance_id)
left join contact as pexec_contact on (pexec_contact.id = p.contact_exec_id)
left join ally_exit_reason aer on (aer.id = ap.ally_exit_reason_id)
;





        