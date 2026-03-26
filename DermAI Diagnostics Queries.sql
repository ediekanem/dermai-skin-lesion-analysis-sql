-- 1. JOIN CLINICAL AND LESION DATA FOR EFFECTIVE ANALYSIS.

-- 1a. Join the patient and lesion tables.
select *
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id;

-- 1b. How many records are in the patient table?
select count(*)
from table1;

-- 1c. How many records are in the lesion table?
select count(*)
from table2;

-- 1d. How many records are returned after joining both tables on patient_id?
select count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id;

-- 1e. Is patient_id unique in table1?
select patient_id, count(*)
from table1
group by patient_id
having count(*) > 1;

-- 1f. (i) Is lesion_id unique in table2?
select lesion_id, count(*)
from table2
group by lesion_id
having count(*) > 1;

--(ii) Inspection of repeated lesion records.
select *
from table2
where lesion_id in (
    select lesion_id
    from table2
    group by lesion_id
    having count(*) > 1
)
order by lesion_id;

--(iii) Is the lesion_id–patient_id combination unique in table2?
select lesion_id, patient_id, count(*)
from table2
group by lesion_id, patient_id
having count(*) > 1;

-- 1g. Are there missing values in key analytical columns in either table?
--(i) Check for missing values in key columns in table1.
select
count(*) as total_records,
count(patient_id) as patient_id_count,
count(age) as age_count,
count(gender) as gender_count
from table1;

--(ii) Check for missing values in key columns in table2.
select
count(*) as total_records,
count(lesion_id) as lesion_id_count,
count(patient_id) as patient_id_count,
count(diagnostic) as diagnostic_count,
count(region) as region_count
from table2;


-- 2. IDENTIFY ENVIRONMENTAL AND DEMOGRAPHIC RISK FACTORS.

-- 2a. Which lesion diagnoses are most common overall?
select diagnostic, count(*)
from table2
group by diagnostic
order by count(*) desc;

-- 2b. How are lesion diagnoses distributed by gender?
select t1.gender, t2.diagnostic, count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id
group by t1.gender, t2.diagnostic
order by count(*) desc;

-- 2c. How are lesion diagnoses distributed by age group?
select
case
	when t1.age < 30 then 'Under 30'
	when t1.age between 30 and 49 then '30-49'
	when t1.age between 50 and 69 then '50-69'
	else '70+'
end as age_group,
t2.diagnostic,
count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id
group by age_group, t2.diagnostic
order by count(*) desc;

-- 2d. (i) Is smoking associated with certain lesion diagnoses?
select
case
	when t1.smoke = true then 'Smoker'
	else 'Non-Smoker'
end as smoking_status,
t2.diagnostic, 
count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id
group by t1.smoke, t2.diagnostic
order by count(*) desc;

--(ii) What is the number of patients in each smoking category?
select
case
	when smoke = true then 'Smoker'
	else 'Non-Smoker'
end as smoking_status,
count(*)
from table1
group by smoking_status;

-- 2e. (i) Is pesticide exposure associated with certain lesion diagnoses?
select
case
	when t1.pesticide = true then 'Exposed to Pesticide'
	else 'Not Exposed to Pesticide'
end as pesticide_exposure,
t2.diagnostic, 
count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id
group by t1.pesticide, t2.diagnostic
order by count(*) desc;

--(ii) What is the overall distribution of pesticide exposure in the patient table (table1)?
select
case
	when pesticide = true then 'Exposed to Pesticide'
	else 'Not Exposed to Pesticide'
end as pesticide_exposure,
count(*)
from table1
group by pesticide_exposure;

-- 2f. (i) Do patients with prior skin cancer history show different diagnosis patterns?
select
case
	when t1.skin_cancer_history = true then 'History of Skin Cancer'
	else 'No History of Skin Cancer'
end as skin_cancer_history_status,
t2.diagnostic, 
count(*)
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id
group by t1.skin_cancer_history, t2.diagnostic
order by count(*) desc;

--(ii) What is the overall distribution of patients with and without prior skin cancer history?
select
case
	when skin_cancer_history = true then 'History of Skin Cancer'
	else 'No History of Skin Cancer'
end as skin_cancer_history_status,
count(*)
from table1
group by skin_cancer_history_status;


-- 3. ANALYZE LESION CHARACTERISTICS TO FIND CANCEROUS VS BENIGN PATTERNS.

-- 3a. Which diagnoses are most common by body region?
select region, diagnostic, count(*)
from table2
group by region, diagnostic
order by count(*) desc;

-- 3b. Do some diagnoses have larger average lesion sizes than others?
select diagnostic,
avg(diameter_1) as avg_diameter_1,
avg(diameter_2) as avg_diameter_2
from table2
group by diagnostic
order by avg(diameter_1) desc;

-- 3c. Are symptoms like growth, change, or bleeding more common in certain diagnoses?
--(i) Count diagnoses by growth status.
select
case
	when grew = true then 'Growth Present'
	else 'No Growth'
end as growth_status,
diagnostic,
count(*)
from table2
group by growth_status, diagnostic
order by count(*) desc;

--(ii) Count diagnoses by lesion change status.
select
case
	when changed = true then 'Change Present'
	else 'No Change'
end as change_status,
diagnostic,
count(*)
from table2
group by change_status, diagnostic
order by count(*) desc;

--(iii) Count diagnoses by bleeding status.
select
case
	when bleed = true then 'Bleeding Present'
	else 'No Bleeding'
end as bleeding_status,
diagnostic,
count(*)
from table2
group by bleeding_status, diagnostic
order by count(*) desc;

-- 3d. Which diagnoses are more likely to be biopsy-confirmed?
select
case
	when biopsed = true then 'Biopsied'
	else 'Not Biopsied'
end as biopsy_status,
diagnostic,
count(*)
from table2
group by biopsy_status, diagnostic
order by count(*) desc;


-- 4. CREATE A CLEANED MACHINE-LEARNING-READY DATASET.
select
t1.patient_id,
t2.lesion_id,
t1.age,
t1.gender,
t1.smoke as smoking_status,
t1.drink as alcohol_use,
t1.pesticide as pesticide_exposure,
t1.skin_cancer_history,
t1.cancer_history,
t1.has_piped_water,
t1.has_sewage_system,
t2.fitspatrick,
t2.region,
t2.diameter_1,
t2.diameter_2,
t2.itch,
t2.grew as growth_present,
t2.hurt as pain_present,
t2.changed as change_present,
t2.bleed as bleeding_present,
t2.elevation,
t2.biopsed as biopsy_status,
t2.diagnostic
from table1 t1
join table2 t2
on t1.patient_id = t2.patient_id;
