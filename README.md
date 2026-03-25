# DermAI Diagnostics Skin Lesion Analysis in SQL

## Overview

This project analyzes clinical and lesion-level skin lesion data in SQL to identify demographic, environmental, and lesion-specific patterns associated with different diagnoses. The work involved joining patient and lesion tables, validating database structure, exploring clinically relevant risk factors, and preparing a machine-learning-ready dataset for future predictive analysis.

## Business Problem

Skin cancer detection can be delayed by incomplete risk assessment and limited ability to connect patient background information with lesion characteristics. The goal of this project was to use SQL to transform linked clinical data into structured, analysis-ready outputs that support earlier insight, better risk evaluation, and future AI-driven applications.

## Tools Used

- SQL
- Table Joins
- Data Validation
- Exploratory Data Analysis
- Aggregation Queries
- Risk Factor Analysis
- Feature Selection
- Dataset Preparation for Machine Learning

## Dataset Overview

The project uses two related tables:

- A patient-level table containing demographic, behavioral, environmental, and clinical-history variables
- A lesion-level table containing lesion characteristics, symptoms, biopsy status, and diagnosis

These tables were joined using `patient_id` so lesion records could be analyzed together with relevant patient background information.

## Project Workflow

- Joined the patient and lesion tables using `patient_id`
- Validated record counts, identifier behavior, and missingness in key columns
- Explored diagnosis patterns across demographic and environmental variables such as gender, age, smoking status, pesticide exposure, and skin cancer history
- Analyzed lesion characteristics including body region, lesion size, growth, visible change, bleeding, and biopsy status
- Created a cleaned machine-learning-ready dataset for future predictive analysis

## Key Insights

- Older age groups showed higher concentration for several diagnoses, making age an important contextual factor in lesion assessment
- Prior skin cancer history and pesticide exposure showed meaningful diagnostic patterns, especially for more clinically concerning lesion types
- Larger average lesion diameters were observed for diagnoses such as MEL, SCC, and BCC
- Growth, visible change, bleeding, and biopsy status emerged as useful signals when examining lesion severity and diagnosis patterns
- The final joined dataset created a structured foundation for future machine learning and predictive modeling work

## Recommendations

- Prioritize age, skin cancer history, and pesticide exposure as important contextual variables in future risk assessment and predictive modeling workflows
- Retain lesion size, lesion growth, visible change, bleeding, and body region as key analytical features because they showed meaningful diagnostic patterns
- Interpret imbalanced binary variables carefully by comparing within-group proportions rather than relying only on raw counts
- Preserve and extend the final integrated SQL dataset as the foundation for future classification, risk prediction, and early detection modeling

## Files Included

- `README.md`
- `DermAI_Diagnostics_Project_Overview.docx`
- `DermAI_Diagnostics_SQL_Analysis_Presentation.pptx`
- `SQL-queries-image-1.jpg`
- `SQL-queries-image-2.jpg`
- `SQL-queries-image-3.jpg`
- `SQL-queries-image-4.jpg`
- `SQL-queries-image-5.jpg`
- `SQL-queries-image-6.jpg`
- `SQL-queries-image-7.jpg`
- `SQL-queries-image-8.jpg`
- `SQL-queries-image-9.jpg`

## What This Project Demonstrates

This project demonstrates my ability to work with relational health data in SQL, validate database structure, join and analyze linked tables, identify clinically relevant risk patterns, and prepare structured datasets for future machine learning and predictive analytics work.
