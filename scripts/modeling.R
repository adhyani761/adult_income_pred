library(dplyr)
library(caret)
library(ggplot2)
library(pROC)

train_and_evaluate_model <- function(cleaned_data) {
  
  # Ensure the target variable is a factor
  cleaned_data$income <- as.factor(cleaned_data$income)
  
  # Split the data into training and testing sets
  set.seed(42)  # For reproducibility
  train_index <- createDataPartition(cleaned_data$income, p = 0.8, list = FALSE)
  train_data <- cleaned_data[train_index, ]
  test_data <- cleaned_data[-train_index, ]
  
  # Train logistic regression model
  model <- glm(income ~ ., data = train_data, family = binomial)
  
  # Summary of the model
  print(summary(model))
  
  # Make predictions on the test set
  test_predictions <- predict(model, test_data, type = "response")
  
  # Convert predicted probabilities to class labels using threshold
  threshold <- 0.5
  test_predictions_class <- ifelse(test_predictions > threshold, "2", "1")  # Using "1" and "2" for class labels
  
  # Convert predictions to a factor with the same levels as the actual outcome (test_data$income)
  test_predictions_class <- factor(test_predictions_class, levels = levels(test_data$income))
  
  # Confusion Matrix to evaluate the model
  conf_matrix <- confusionMatrix(test_predictions_class, test_data$income)
  
  # Print Confusion Matrix
  print("Confusion Matrix:")
  print(conf_matrix)
  
  # Return the model and the confusion matrix as a list
  return(list(
    model = model,
    confusion_matrix = conf_matrix
  ))
}
