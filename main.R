install.packages(c("targets", "dplyr", "ggplot2", "caret", "reshape2", "drake"))

# Load the required libraries
library(targets)
library(dplyr)
library(ggplot2)
library(caret)
library(reshape2)
library(drake)



source("scripts/data_cleaning.R")
source("scripts/EDA.R")  # Ensure this file includes the necessary EDA functions
source("scripts/modeling.R")  # Source your modeling script (train_and_evaluate_model function)

# Define the pipeline
tar_option_set(packages = c("dplyr", "ggplot2", "caret"))  # Include 'caret' for model evaluation

# Define the drake plan
plan <- drake_plan(
  raw_data = load_raw_data("data/adult.csv"),  # Load the raw data
  cleaned_data = clean_data(raw_data),          # Clean the data
  # Run EDA after data is cleaned
  perform_eda(cleaned_data = cleaned_data),    # Perform EDA and save plots
  
  # Train the model and evaluate its performance
  model_results = train_and_evaluate_model(cleaned_data)  # This calls your new train_and_evaluate_model function
)

# Run the pipeline
make(plan)

# Now you can access the trained model and confusion matrix:
model_results <- readd(model_results)  # This is how you access the results from the plan

# Access the trained model and confusion matrix
model <- model_results$model
conf_matrix <- model_results$confusion_matrix

# Save the trained model for future use
saveRDS(model, "output/model_logistic_regression.rds")
