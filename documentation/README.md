# Project Documentation

This document summarizes the key steps, tools, and techniques used throughout the Student Performance analysis project, including regression and classification tasks.

## 📌 Objective

To analyze a student performance dataset in order to:
- Predict final exam scores using regression models.
- Classify students into performance categories using classification models.
- Evaluate and visualize model performance using Power BI.

---

## 🔧 Tools Used

- **SQL Server**: For data import, transformation, and aggregation.
- **Python (Jupyter Notebook)**: For machine learning models and metrics export.
- **Power BI**: For creating the final report and visual analytics.
- **GitHub**: For project version control and documentation.

---

## 🔄 Workflow Summary

### 1. **Data Import and SQL Transformation**
- Raw CSV imported into SQL Server.
- Created cleaned and transformed views:
  - One for regression (numerical prediction of final scores).
  - One for classification (categorical performance labels).
- Prepared yearly comparison views (simulated) for multi-year analysis.

### 2. **Machine Learning (Python Notebook)**
- Loaded cleaned data from SQL Server.
- Applied encoding and preprocessing.
- Trained multiple regression models (Linear, Ridge, Lasso).
- Trained classification models (Logistic Regression, Decision Tree, Random Forest).
- Evaluated using R², RMSE, Accuracy, F1-score, etc.
- Exported results (model metrics, confusion matrix) back to SQL.

### 3. **Power BI Reporting**
- Connected to SQL Server for metrics and results.
- Created visual dashboards:
  - KPIs and scatterplots for regression.
  - Confusion matrix heatmaps and radar charts for classification.
- Included slicers and navigation buttons for user interaction.
- Summarized key findings in conclusion text boxes.

---

## ✅ Output

- Final .pbix report with interactive analysis of both ML tasks.
- All source code and assets organized and versioned in this repository.

