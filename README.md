# Predicting SME Export Status in East African Community 

## Thesis Topic

**Predicting SME Export Readiness in East African Community : A Machine Learning Approach Benchmarked Against a European Firm-Level Model**

## Overview

This repository contains the data, notebooks, scripts, modelling outputs, results, and supporting materials for this Master's thesis.

The study investigates SME export behaviour and examines whether firm-level characteristics can be used to identify and predict firms' export participation. The study applies machine learning methods to firm-level survey data and evaluates model performance across selected East African countries.

The empirical analysis focuses on:

- Kenya
- Tanzania
- Uganda

## Research Context

Small and medium-sized enterprises (SMEs) play an important role in economic development, employment and international trade. However, many SMEs face barriers to entering export markets.

This research examines the firm-level characteristics associated with export participation and evaluates whether machine learning can improve the identification and prediction of SME exporters.

## Data Source

The primary data used in this research are obtained from the **World Bank Enterprise Surveys (WBES)**.

The original datasets are preserved in:

`Data/raw/`

The raw datasets are kept unchanged as the starting point of the research workflow.

Source:

**World Bank Enterprise Surveys**

https://www.enterprisesurveys.org/

## Countries

The analysis covers three East African countries:

- Kenya
- Tanzania
- Uganda

## Research Methodology

The research follows a structured machine learning workflow:

1. Acquisition of the original survey datasets
2. Preservation of the raw datasets
3. Data cleaning and preparation
4. Variable selection and preparation
5. Exploratory and descriptive analysis
6. Missing-data assessment
7. Training and testing data preparation
8. Treatment of class imbalance using SMOTE where appropriate
9. Model training
10. Cross-validation
11. Model evaluation and comparison
12. Model interpretation
13. Country-level analysis
14. Comparison of model performance

## Machine Learning

The project uses machine learning methods to investigate SME export behaviour.

The repository contains model training data, validation data, model comparison results and BART-MIA analyses for Kenya, Tanzania and Uganda.

Model outputs and evaluation results are stored in:

`results/`

## Data Structure

### Raw Data

`Data/raw/`

Contains the original datasets obtained from the World Bank Enterprise Surveys.

These files are retained as the original starting point for the analysis.

### Clean Data

`Data/clean/`

Contains datasets after data cleaning and preparation.

Examples include:

- `Kenya_clean.csv`
- `Tanzania_clean.csv`
- `Uganda_clean.csv`

### Modelling Data

`Data/model/`

Contains datasets prepared for machine learning, including:

- Training datasets
- Testing datasets
- Predictor variables (X)
- Target variables (y)
- SMOTE training datasets
- Modelling specifications
- Country-specific modelling datasets

## Repository Structure

```text
SME_Export_Thesis/
│
├── Data/
│   ├── raw/
│   │   ├── Kenya-2023-full-data.dta
│   │   ├── Tanzania-2023-full-data.dta
│   │   └── Uganda-2023-full-data.dta
│   │
│   ├── clean/
│   │   ├── Kenya_clean.csv
│   │   ├── Tanzania_clean.csv
│   │   └── Uganda_clean.csv
│   │
│   └── model/
│       ├── Kenya_X_train.csv
│       ├── Kenya_X_test.csv
│       ├── Kenya_y_train.csv
│       ├── Kenya_y_test.csv
│       ├── Kenya_train_smote.csv
│       ├── Tanzania_X_train.csv
│       ├── Tanzania_X_test.csv
│       ├── Tanzania_y_train.csv
│       ├── Tanzania_y_test.csv
│       ├── Tanzania_train_smote.csv
│       ├── Uganda_X_train.csv
│       ├── Uganda_X_test.csv
│       ├── Uganda_y_train.csv
│       ├── Uganda_y_test.csv
│       └── Uganda_train_smote.csv
│
├── notebooks/
│
├── scripts/
│
├── results/
│   ├── figures/
│   ├── models/
│   ├── tables/
│   └── training/
│
├── .gitignore
│
└── README.md



Results

The results/ directory contains the outputs generated during the analysis.

Figures

results/figures/

Contains visualisations including model evaluation and comparison figures.

Tables

results/tables/

Contains analytical tables such as:

* Descriptive statistics
* Exporter comparisons
* Exporter validation
* Missingness assessment
* Group difference tests
* Model comparisons

Models

results/models/

Contains saved model outputs where applicable, including BART-MIA models.

Training

results/training/

Contains model training, validation and comparison outputs.

Reproducibility

The repository is organised to maintain a clear separation between:

Raw data → Clean data → Modelling data → Analysis → Results

The original raw datasets are preserved separately from the processed datasets. The notebooks and scripts document the analytical and modelling workflow used in the research.

Data Provenance

The original survey datasets were obtained from the World Bank Enterprise Surveys.

The Data/raw/ folder contains the original datasets used as the starting point for the research.

The processed datasets in Data/clean/ and Data/model/ were generated during the research workflow.

Academic Purpose

This repository is maintained as a supporting research repository for the Master’s thesis. It provides transparency regarding the data, analytical workflow, modelling process and empirical results.

Author

Eddie Best

Master’s Thesis
