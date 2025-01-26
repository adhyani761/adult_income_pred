test_clean_data <- function() {
  # Create a mock dataset with "?" values
  raw_data <- data.frame(
    age = c(25, 30, 35, 40, 1000),  # Includes an extreme value
    income = c("<=50K", ">50K", "?", "<=50K", ">50K"),  # Includes "?"
    stringsAsFactors = FALSE
  )
  
  # Clean the data
  cleaned <- clean_data(raw_data)
  
  # Verify rows with "?" are removed
  stopifnot(nrow(cleaned) == 3)  # Should retain 4 rows
  
  # Verify normalization: age should be between 0 and 1
  stopifnot(all(cleaned$age >= 0 & cleaned$age <= 1))
  
  # Verify categorical encoding
  stopifnot(is.numeric(cleaned$income))
  
  print("Cleaned Data:")
  print(cleaned)
  print("Test for clean_data() passed!")
}

