USE loan_analysis;

-- Categorizing numeric columns for easier analysis
SET SQL_SAFE_UPDATES = 0;

-- Categorizing age column
ALTER TABLE bank_loans ADD COLUMN age_bracket VARCHAR(10);
UPDATE bank_loans
SET age_bracket = CASE
	WHEN age BETWEEN 20 AND 30 THEN '20-30'
    WHEN age BETWEEN 31 AND 40 THEN '31-40'
    WHEN age BETWEEN 41 AND 50 THEN '41-50'
    WHEN age BETWEEN 51 AND 60 THEN '51-60'
    WHEN age > 60 THEN 'over 60'
END;

-- Categorizing income column
ALTER TABLE bank_loans ADD COLUMN income_group VARCHAR(10);
UPDATE bank_loans
SET income_group = CASE
	WHEN income < 56.6 THEN 'Low'
    WHEN income BETWEEN 56.6 AND 169.8 THEN 'Medium'
    ELSE 'High'
END;

-- Categorizing cc_avg column
ALTER TABLE bank_loans ADD COLUMN cc_avg_group VARCHAR(10);
UPDATE bank_loans
SET cc_avg_group = CASE
	WHEN cc_avg = 0 THEN 'None'
	WHEN cc_avg <= 2 THEN 'Low'
    WHEN cc_avg BETWEEN 2.1 AND 5 THEN 'Medium'
    ELSE 'High'
END;

-- Categorizing education column
ALTER TABLE bank_loans ADD COLUMN education_level VARCHAR(25);
UPDATE bank_loans
SET education_level = CASE
	WHEN education = 1 THEN 'Undergrad'
    WHEN education = 2 THEN 'Graduate'
    WHEN education = 3 THEN 'Advanced/Professional'
END;

-- Categorizing mortgage column
ALTER TABLE bank_loans ADD COLUMN mortgage_group VARCHAR(10);
UPDATE bank_loans
SET mortgage_group = CASE
	WHEN mortgage = 0 THEN 'None'
	WHEN mortgage BETWEEN 1 AND 100 THEN 'Low'
    WHEN mortgage BETWEEN 100.001 AND 300 THEN 'Medium'
    ELSE 'High'
END;

SET SQL_SAFE_UPDATES = 1;

-- Confirming new table structure with accurately entered data
SELECT * FROM bank_loans LIMIT 10;

-- Feature engineering for easier analysis
SET SQL_SAFE_UPDATES = 0;

-- Introducing housing-to-income ratio
ALTER TABLE bank_loans ADD COLUMN housing_to_income_group VARCHAR(10);
UPDATE bank_loans
SET housing_to_income_group = CASE
	WHEN mortgage = 0 THEN 'None'
    WHEN mortgage/income <= 2 THEN 'Low'
    WHEN mortgage/income <= 4 THEN 'Medium'
    ELSE 'High'
END;

-- Introducing field for customer engagement with the bank
ALTER TABLE bank_loans ADD COLUMN total_customer_products INT;
UPDATE bank_loans
SET total_customer_products = securities_account + cd_account + online_banking + credit_card;

-- Introducing field credit_card usage to income ratio
ALTER TABLE bank_loans ADD COLUMN cc_to_income_group VARCHAR(15);
UPDATE bank_loans
SET cc_to_income_group = CASE
	WHEN cc_avg = 0 THEN 'None'
    WHEN (cc_avg * 12) / income <= 0.20 THEN 'Low'
    WHEN (cc_avg * 12) / income <= 0.50 THEN 'Moderate'
    WHEN (cc_avg * 12) / income <= 1.0 THEN 'High'
    ELSE 'Critical'
END;

-- Introducing field to calculate the ratio of income spend on each family member (in thoery)
ALTER TABLE bank_loans ADD COLUMN income_per_family_member_group VARCHAR(15);
UPDATE bank_loans
SET income_per_family_member_group = CASE
	WHEN income/family <= 25 THEN 'Low'
    WHEN income/family <= 50 THEN 'Medium'
    WHEN income/family <= 100 THEN 'High'
    ELSE 'Very High'
END;

SET SQL_SAFE_UPDATES = 1;

-- Confirming new table structure with accurately entered data
SELECT * FROM bank_loans;
-- Exported table results into a csv file for analysis