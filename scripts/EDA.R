# Load required libraries
library(ggplot2)
library(dplyr)
library(reshape2)

# Function for Exploratory Data Analysis (EDA)
perform_eda <- function(cleaned_data, output_dir = "output/plots") {
  
  # Create the output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  }
  
  # Summary statistics of the dataset
  print("Summary statistics of the dataset:")
  print(summary(cleaned_data))
  
  # Income distribution plot
  income_plot <- ggplot(cleaned_data, aes(x = factor(income))) +
    geom_bar(fill = c("skyblue", "lightgreen")) +
    labs(title = "Income Class Distribution", x = "Income (1: <=50K, 2: >50K)", y = "Count") +
    theme_minimal()
  ggsave(paste(output_dir, "/income_class_distribution.png", sep = ""), income_plot)
  
  # Correlation matrix plot
  numeric_columns <- names(cleaned_data)[sapply(cleaned_data, is.numeric)]
  correlation_matrix <- cor(cleaned_data[, numeric_columns])
  
  # Heatmap of correlation matrix
  correlation_data <- melt(correlation_matrix)
  correlation_plot <- ggplot(data = correlation_data, aes(Var1, Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
    theme_minimal() +
    labs(title = "Correlation Heatmap", x = "", y = "")
  ggsave(paste(output_dir, "/correlation_heatmap.png", sep = ""), correlation_plot)
  
  # Variables sorted by descending absolute correlation with income
  correlations <- sapply(cleaned_data[, numeric_columns], function(col) cor(col, cleaned_data$income, use = "complete.obs"))
  
  correlation_df <- data.frame(
    Variable = names(correlations),
    Correlation = correlations
  )
  
  correlation_df <- correlation_df %>%
    mutate(AbsCorrelation = abs(Correlation)) %>%
    arrange(desc(AbsCorrelation))
  
  print("Variables sorted by descending absolute correlation with income:")
  print(correlation_df)
  
  # Boxplot: Age distribution by Income
  age_income_plot <- ggplot(cleaned_data, aes(x = factor(income), y = age)) +
    geom_boxplot() +
    labs(title = "Age Distribution by Income", x = "Income", y = "Age") +
    theme_minimal()
  ggsave(paste(output_dir, "/age_distribution_by_income.png", sep = ""), age_income_plot)
  
  # Bar plot: Relationship Status by Income
  relationship_income_plot <- ggplot(cleaned_data, aes(x = relationship, fill = factor(income))) +
    geom_bar(position = "dodge") +
    labs(title = "Relationship Status by Income", x = "Relationship", y = "Count") +
    theme_minimal()
  ggsave(paste(output_dir, "/relationship_status_by_income.png", sep = ""), relationship_income_plot)
  
  # Income Proportion by Marital Status
  marital_status_income_plot <- cleaned_data %>%
    group_by(marital.status, income) %>%
    summarize(Count = n()) %>%
    mutate(Proportion = Count / sum(Count)) %>%
    ggplot(aes(x = marital.status, y = Proportion, fill = factor(income))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Income Proportion by Marital Status", x = "Marital Status", y = "Proportion") +
    theme_minimal()
  ggsave(paste(output_dir, "/income_proportion_by_marital_status.png", sep = ""), marital_status_income_plot)
  
  # Scatter plot: Age vs Hours per Week by Income
  age_hours_income_plot <- ggplot(cleaned_data, aes(x = age, y = hours.per.week, color = factor(income))) +
    geom_point(alpha = 0.5) +
    labs(title = "Age vs Hours per Week by Income", x = "Age", y = "Hours per Week") +
    theme_minimal()
  ggsave(paste(output_dir, "/age_vs_hours_per_week_by_income.png", sep = ""), age_hours_income_plot)
  
  print("EDA plots have been saved to the specified directory.")
}