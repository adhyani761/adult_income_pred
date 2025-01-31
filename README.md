Adult Income Prediction
This project predicts income levels (<=50K or >50K) based on demographic and employment data using machine learning techniques. It involves data cleaning, exploratory data analysis (EDA), and model training with R.

Project Workflow
Load Raw Data
The raw data (adult.csv) is loaded and preprocessed to remove duplicates, handle missing values, and normalize numerical features.

Data Cleaning:
The cleaning process includes:
Removing duplicate rows.
Handling missing values (?).
Removing outliers.
Label encoding categorical variables.
Normalizing numerical variables.

Exploratory Data Analysis (EDA):
Key insights into the data are generated through visualizations and statistical summaries. This includes:
Distribution analysis of features.
Correlation analysis between features and target variables.
Visualization of income distribution across demographics.

Model Training and Evaluation:
A logistic regression model is trained to predict income levels.
Performance is evaluated using metrics like accuracy, precision, recall, and a confusion matrix.
Model results and visualizations are saved for further analysis.

Folder Structure
/data: Contains the raw dataset (adult.csv).
/scripts: R scripts for data processing, EDA, and model training:
data_cleaning.R: Handles data preprocessing.
EDA.R: Functions for exploratory data analysis.
modeling.R: Functions for training and evaluating the model.
setup.R:Function to download the necessary packages
/output: Stores results, including:
Cleaned data (cleaned_data.csv).
EDA plots (/output/plots/).
Trained model (model_logistic_regression.rds).
/test: Unit tests to ensure the correctness of the R scripts.
How to Run the Project

1)Clone the repository:

bash

git clone git@github.com:adhyani761/adult_income_pred.git
cd adult_income_pred

2)Install the required R packages:
(Script provided in main.R)

install.packages(c("targets", "dplyr", "ggplot2", "caret", "reshape2"))

OR

Use renv::restore() and accept the installation and after that just run the script 

3)Run the pipeline in main.R
The main.R script is the entry point for the project. It sources all necessary R scripts, defines the drake pipeline, and runs the workflow from loading the data to training the model. Here’s a brief overview of what happens in main.R:

Libraries: The required libraries (drake, dplyr, ggplot2, caret, etc.) are loaded.
Script Sourcing: The data cleaning, EDA, and modeling scripts are sourced.
Drake Plan: The drake plan is defined, which outlines the tasks (data loading, cleaning, EDA, modeling) and their dependencies.
Run the Pipeline: The make(plan) function executes the pipeline, performing all tasks in sequence.
Save Outputs: The output, including cleaned data, plots, and the trained model, is saved to the output directory.


Access results:

Cleaned data: output/cleaned_data.csv
EDA plots: output/plots/
Trained model: output/model_logistic_regression.rds
Key Results
EDA Highlights:
Visualizations revealing trends and relationships in the dataset.

Model Performance:

Accuracy: ~85%
Precision/Recall metrics provided in the confusion matrix.
Future Improvements
Use other machine learning models like random forests or gradient boosting for comparison.
Hyperparameter tuning for better model performance.
Add additional feature engineering steps.
Author
Apoorv Dhyani

