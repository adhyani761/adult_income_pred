library(targets)
library(dplyr)
library(ggplot2)

# Source your scripts (like data cleaning and EDA)
source("scripts/data_cleaning.R")
source("scripts/eda.R")  # Make sure to source your EDA script

# Define the pipeline
tar_option_set(packages = c("dplyr", "ggplot2"))

# Define the drake plan
plan <- drake_plan(
  raw_data = load_raw_data("data/adult.csv"),  # Load the raw data
  cleaned_data = clean_data(raw_data),          # Clean the data
  # Run EDA after data is cleaned
  perform_eda(cleaned_data = cleaned_data)     # Perform EDA and save plots
)

# Run the pipeline
make(plan)

cleaned_data <- readd(cleaned_data)

# Now save the cleaned data to the output folder
write.csv(cleaned_data, "output/cleaned_data.csv", row.names = FALSE)

