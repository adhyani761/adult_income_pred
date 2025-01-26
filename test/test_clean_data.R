test_clean_data <- function() {
  raw_data <- data.frame(
    age = c(25, 30, 35, NA, 1000),  # Includes missing and extreme value
    income = c("<=50K", ">50K", "?", "<=50K", ">50K"),  # Includes "?"
    stringsAsFactors = FALSE
  )
  
  # Clean the data
  cleaned <- clean_data(raw_data)
  
  # Assert missing and extreme values are removed
  stopifnot(nrow(cleaned) == 2)  # Should only retain valid rows
  
  # Print the cleaned data to inspect
  print(cleaned)
  
  # Assert normalization works: age should be between 0 and 1
  stopifnot(all(cleaned$age >= 0 & cleaned$age <= 1))
  
  print("Test for clean_data() passed!")
}

