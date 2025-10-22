USE loan_analysis;

-- Understanding the table
SELECT COUNT(*) FROM bank_loans;
SELECT * FROM bank_loans LIMIT 10;

-- renaming online banking usage binary column to an appropriate title 
ALTER TABLE bank_loans
RENAME COLUMN online_status TO online_banking;

-- Identifying missing/null values
SELECT 
	SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS missing_id,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN experience IS NULL THEN 1 ELSE 0 END) AS missing_experience,
    SUM(CASE WHEN income IS NULL THEN 1 ELSE 0 END) AS missing_income,
    SUM(CASE WHEN zip_code IS NULL THEN 1 ELSE 0 END) AS missing_zip_code,
    SUM(CASE WHEN family IS NULL THEN 1 ELSE 0 END) AS missing_family,
    SUM(CASE WHEN cc_avg IS NULL THEN 1 ELSE 0 END) AS missing_cc_avg,
    SUM(CASE WHEN education IS NULL THEN 1 ELSE 0 END) AS missing_education,
    SUM(CASE WHEN mortgage IS NULL THEN 1 ELSE 0 END) AS missing_mortgage,
    SUM(CASE WHEN personal_loan IS NULL THEN 1 ELSE 0 END) AS missing_personal_loan,
    SUM(CASE WHEN securities_account IS NULL THEN 1 ELSE 0 END) AS missing_securities_account,
    SUM(CASE WHEN cd_account IS NULL THEN 1 ELSE 0 END) AS missing_cd_account,
    SUM(CASE WHEN online_banking IS NULL THEN 1 ELSE 0 END) AS missing_online_banking,
    SUM(CASE WHEN credit_card IS NULL THEN 1 ELSE 0 END) AS missing_credit_card
FROM bank_loans;
-- There are no missing/null values  

-- Identifying and duplicate rows
SELECT id, COUNT(*) as row_freq
FROM bank_loans
GROUP BY id
HAVING COUNT(*) > 1;
-- There are no rows with the same customer ID (different customers can have identical features -> even for all other characteristics/columns)

-- Identifying any invalid data in numeric columns
SELECT COUNT(*) AS invalid_values
FROM bank_loans
WHERE age < 0 OR experience < 0 OR income < 0 OR family < 0 OR cc_avg < 0 OR education < 0 OR mortgage < 0;
-- Noticed only the experience column has invalid values

SELECT *
FROM bank_loans
WHERE age < 0 OR experience < 0 OR income < 0 OR family < 0 OR cc_avg < 0 OR education < 0 OR mortgage < 0
ORDER BY experience;

SELECT COUNT(*) AS invalid_experience_values
FROM bank_loans
WHERE experience < 0;

-- Computing the average experience value of valid rows 
SELECT ROUND(AVG(experience)) INTO @avg_experience
FROM bank_loans
WHERE EXPERIENCE >= 0;

-- Updating the invalid rows with the average value
SET SQL_SAFE_UPDATES = 0;
UPDATE bank_loans
SET experience = @avg_experience
WHERE experience < 0;
SET SQL_SAFE_UPDATES = 1;

-- Confirming values in experience were updated
SELECT COUNT(*) AS invalid_experience_values
FROM bank_loans
WHERE experience < 0;

-- Identifying any invalid data in binary columns
SELECT COUNT(*) AS invalid_values
FROM bank_loans
WHERE personal_loan NOT IN (0,1) OR securities_account NOT IN (0,1) OR cd_account NOT IN (0,1) OR online_banking NOT IN (0,1) OR credit_card NOT IN (0,1);

-- Identifying any invalid data in zip_code 
SELECT *
FROM bank_loans
WHERE zip_code <= 0;

SELECT MIN(zip_code) AS min_zip, MAX(zip_code) AS max_zip
FROM bank_loans;
-- Noticed min zip_code had 4 digits
-- Checking to see if there are more zip_code values with 4 digits
SELECT *
FROM bank_loans
WHERE zip_code < 10000;
-- Only 1 row had a zip_code value with 4 digits 

SET SQL_SAFE_UPDATES = 0;
UPDATE bank_loans
SET zip_code = NULL
WHERE zip_code = 9307;
SET SQL_SAFE_UPDATES = 1;
-- Set to NULL due to missing information

-- Confirming validity of data in zip_code column
SELECT MIN(zip_code) AS min_zip, MAX(zip_code) AS max_zip
FROM bank_loans;

-- Identifying any outlier data in numeric columns
SELECT MIN(age) AS min_age, MAX(age) AS max_age,
	   MIN(experience) AS min_experience, MAX(experience) AS max_experience,
       MIN(income) AS min_income, MAX(income) AS max_income,
       MIN(family) AS min_family, MAX(family) AS max_family,
       MIN(cc_avg) AS min_cc_avg, MAX(cc_avg) AS max_cc_avg,
       MIN(education) AS min_education, MAX(education) AS max_education,
       MIN(mortgage) AS min_mortgage, MAX(mortgage) AS max_mortgage
FROM bank_loans;
-- All values are within a reasonable/logical range 