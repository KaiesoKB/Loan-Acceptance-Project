CREATE DATABASE loan_analysis;
USE loan_analysis;

CREATE TABLE bank_loans (
	id INT PRIMARY KEY,
    age INT,
    experience INT,
    income DECIMAL(12, 2),
    zip_code CHAR(5),
    family TINYINT,
    cc_avg DECIMAL(12, 2),
    education TINYINT,
    mortgage DECIMAL(12, 2),
    personal_loan TINYINT(1),
    securities_account TINYINT(1),
    cd_account TINYINT(1),
    online_status TINYINT(1),
    credit_card TINYINT(1)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/kylan/OneDrive/Documents/DATA PROJECTS/Loan_Default_Risk_Analysis_&_Credit_Strategy/Bank_Personal_Loan_Modelling.csv'
INTO TABLE bank_loans
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, age, experience, income, zip_code, family, cc_avg, education, mortgage, personal_loan, securities_account, cd_account, online_status, credit_card);