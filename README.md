# Understanding and Predicting Customer Loan Acceptance Behavior for a Retail Bank

## Goal
Understand and predict which customer deetails influence personal loan acceptance, enabling targeted marketing and improved loan uptake 

## Data Source
**Bank_Loan_modelling [Kaggle](https://www.kaggle.com/datasets/itsmesunil/bank-loan-modelling)** - By Sunil Jacob

---

## Business Questions

1. Which customer segments are most likely to accept a person loan?
2. How does housing exposure or mortgage ownership affect loan acceptance?
3. How does average credit card spending and credit_utilization relate to loan acceptance?
4. Are customers with more bank products amore likely to accept a personal loan?
5. How does income relative to financial obligations affect willingness to take a personal loan?
6. Which features most strongly differentiate loan accepters vs non-accepters?

---

## Tools & Skills Utilized

- **SQL**: Data extraction and cleaning
- **Excel**: Exploratory data analysis and reporting
- **Power BI**: Professional business dashboard
- **Python**: Feature engineerin and predictive model development
- **Business Communication**: Storytelling through insights

---

## Recommendations for Personal Loan Marketing Strategy

1. **Target High Income, High Spending Customers**
   - Customers with income > $100K and high credit card activity are most likely to accept loans.
   - **Action**: Focus marketing campaigns and pre-approved offers on this segment,
  
2. **Prioritize Financially Stable Customers**
   - Loan acceptance strongest amon customers with low to medium housing-to-income ratios.
   - **Action**: Prioritize clients who can comfortably take additional credit.
  
3. **Leverage Customer Profile & Product Ownership**
   - Customers with 3 bank products and medium-size households (3-4) members show highest acceptance.
   - **Action**: Bundle offers or cross-sell loans to these segments.

4. **Education and Age as Secondary Segmentation Factors**
   - Higher education slightly improves acceptance; older, high-income customers show higher receptivity.
   - **Action**: Use age and education as supporting segmentation factors.
  
---

## Analysis & Reports

- `notebooks/Predictive_Model_Development.ipynb` - Exploratory analysis, featuring engineering, model development and training, and model deployment.
- `reports/Excel_Analysis.xlsx` - Excel-based analysis.
- `reports/Loan_Accepted_Insights_Dashboard.pbix` - Interactive Power BI dashboard.
- `reports/Loan_Accepted_Insights_Dashboard_Preview.png` - Screenshot of dashboard.

---

## Model Performance Summary

| Stage               | Top Model        | F1-Score (Loan Accepted = 1)  | ROC-AUC | Accuracy |
|--------------------|-------------------|-------------------------------|---------|----------|
| 0 Baseline         | Random Forest     | 0.952                         | 0.998   | 0.991    |
| 1 After Balancing  | Random Forest     | 0.952                         | 0.998   | 0.991    |
| 2 After Tuning     | Random Forest     | 0.929                         | 0.997   | 0.986    |

**Key Observations:**
- Random Forest consistently top performer across all stages.
- Strong balance between recall and precision for accepted (1) and non-accepted (0) classes.
- 5-fold cross-validation shows low variance:
  - Mean F1-score (Loan Accepted = 1): 0.888 ± 0.040
  - Mean ROC-AUC: 0.995 ± 0.003
- Feature importance:
  - Income: 47%
  - Credit Card Average Spend: 19%
  - Education (Undergrad): 12%
  - Mortgage: 3%
  - cd account: 2%
  - Age: 2%
- Confusion Matrix Highlights:
  - True Negatives: 985
  - True Positives: 91
  - False Negatives: 5
  - False Positives: 9
 
**Runner-up:** Gradient Boosting
  - F1-Score: 0.866, ROC-AUC: 0.997, Accuracy: 0.971
  - Underperformed Random Forest in prediction stability
 
---

## Business Interpretation of Model

- Random Forest provides reliable forecasting of loan acceptance.
- Allows targeted marketing for high likelihood customers.
- Reduces campaign costs and optimizes resource allocations.
- Income, credit card spend, and education are strong indicators of acceptance.

---

## Model Details

- **Final Chosen Mode;:** Random Forest (After Tuning)
- **Features used:** age, experience, income, cc_avg, mortgage, securities_account,	cd_account,	online_banking,	credit_card, education_Professional,	education_Undergrad,	family_Size_2,	family_Size_3,	family_Size_4.
- **Scaler:** StandardScaler applied to numeric features.
- **Saved Model & Scaler:** `Loan-Acceptance-Project/Loan_Acceptance_Project/src/models/Personal_loan_acceptance_Prediction_Model.pkl` and `Loan-Acceptance-Project/Loan_Acceptance_Project/src/models/Model_scaler.pkl`

---

## How to Use the Steamlit App
