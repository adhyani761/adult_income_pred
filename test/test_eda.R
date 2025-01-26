test_eda <- function() {
  cleaned_data <- data.frame(
    age = runif(100, 20, 60),  # Generate mock data
    hours.per.week = runif(100, 20, 60),
    income = sample(c(1, 2), 100, replace = TRUE)
  )
  
  perform_eda(cleaned_data, output_dir = "output/plots_test")
  stopifnot(file.exists("output/plots_test/income_class_distribution.png"))
  stopifnot(file.exists("output/plots_test/correlation_heatmap.png"))
  
  print("Test for perform_eda() passed!")
}