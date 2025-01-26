test_modeling <- function() {
  cleaned_data <- data.frame(
    age = runif(100, 0, 1),  # Mock normalized data
    hours.per.week = runif(100, 0, 1),
    income = sample(c(1, 2), 100, replace = TRUE)
  )
  
  results <- train_and_evaluate_model(cleaned_data)
  stopifnot(!is.null(results$model))
  stopifnot("confusionMatrix" %in% class(results$confusion_matrix))
  
  print("Test for train_and_evaluate_model() passed!")
}