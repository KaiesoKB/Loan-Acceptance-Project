import pandas as pd
import numpy as np
import streamlit as st
import pickle

with open("Model_scaler.pkl", "rb") as f:
    scaler = pickle.load(f)

with open("Personal_loan_acceptance_Prediction_Model.pkl", "rb") as f:
    model = pickle.load(f)

st.title("Personal Loan Acceptance Predictor")
st.markdown("""This app predicts the likelihood of a customer accepting a personal loan offer.
                Please input the customer details below.
            """)

age = st.number_input("Age", min_value = 18, max_value = 100, value = 35, help = "Enter an age between 18 to 100")
experience = st.number_input("Years of Professional Experience", min_value = 0, max_value = 80, value = 10, help = "Enter the number of years of work experience.")

income = st.number_input("Yearly Income ($)", min_value = 0.0, value = 50000.0, help = "Enter full yearly income in dollars. Example: $120,000 -> Enter 120000") / 1000
cc_avg = st.number_input("Average Monthly Credit Card Spending ($)", min_value = 0.0, value = 3500.0, help = "Enter Average monthly credit card spending in dollars. Example: $3,500 -> Enter 3500") / 1000
mortgage = st.number_input("Mortgage ($)", min_value = 0.0, value = 200000.0, help = "Enter full mortgage income in dollars. Example: $150,000 -> Enter 150000") / 1000

securities_account = 1 if st.checkbox("Has Securities Account?") else 0
cd_account = 1 if st.checkbox("Has Certificate of Deposit Account?") else 0
online_banking = 1 if st.checkbox("Uses Online Banking?") else 0
credit_card = 1 if st.checkbox("Has Credit Card?") else 0

education = st.selectbox("Education Level", options = ["Undergrad", "Graduate", "Advanced/Professional"])
education_Undergrad = 1 if education == "Undergrad" else 0
education_Professional = 1 if education == "Advanced/Professional" else 0

family_Size = st.selectbox("Family Size", options = [1, 2, 3, 4])
family_Size_2 = 1 if family_Size == 2 else 0
family_Size_3 = 1 if family_Size == 3 else 0
family_Size_4 = 1 if family_Size == 4 else 0

input_features_df = pd.DataFrame([[age, experience, income, cc_avg, mortgage, securities_account, cd_account, online_banking,
                                   credit_card, education_Professional, education_Undergrad, family_Size_2, family_Size_3,
                                   family_Size_4]],
                                columns = model.feature_names_in_)
numeric_cols = ['age', 'experience', 'income', 'cc_avg', 'mortgage']
input_features_df[numeric_cols] = scaler.transform(input_features_df[numeric_cols])


if st.button("Predict Loan Acceptance"):
    pred_class = model.predict(input_features_df)[0]
    pred_prob = model.predict_proba(input_features_df)[0][1]
    
    st.success(f"Prediction of Accepting Personal Loan Offer: {'☑️Yes' if pred_class == 1 else '✖️No'}")
    st.info(f"Probability of Accepting Personal Loan Offer: {pred_prob:.4f}")
