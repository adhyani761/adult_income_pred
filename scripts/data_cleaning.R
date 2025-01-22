# Define the clean_data function
clean_data <- function(raw_data) {
  # Remove duplicate rows
  raw_data <- raw_data[!duplicated(raw_data), ]
  print("Duplicate rows removed.")
  
  # Remove rows with "?" values
  raw_data <- raw_data[!apply(raw_data == "?", 1, any), ]
  print("Rows with '?' values removed.")
  
  # Remove specific columns
  raw_data <- raw_data[, !(names(raw_data) %in% c("capital.gain", "capital.loss"))]
  print("'capital.gain' and 'capital.loss' columns removed.")
  
  # Remove outliers using IQR
  remove_outliers <- function(data, column_name, multiplier = 1.5) {
    Q1 <- quantile(data[[column_name]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[column_name]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - multiplier * IQR
    upper_bound <- Q3 + multiplier * IQR
    data <- data[data[[column_name]] >= lower_bound & data[[column_name]] <= upper_bound, ]
    return(data)
  }
  numeric_columns <- names(raw_data)[sapply(raw_data, is.numeric)]
  for (col in numeric_columns) {
    raw_data <- remove_outliers(raw_data, col)
  }
  print("Outliers removed from numeric columns.")
  
  # Normalize numeric columns
  normalize <- function(x) {
    (x - min(x)) / (max(x) - min(x))
  }
  raw_data[numeric_columns] <- lapply(raw_data[numeric_columns], normalize)
  print("Numeric columns normalized.")
  
  # Apply label encoding to categorical columns
  categorical_columns <- setdiff(names(raw_data), numeric_columns)
  raw_data[categorical_columns] <- lapply(raw_data[categorical_columns], function(x) as.numeric(factor(x)))
  print("Categorical columns label-encoded.")
  
  # Return the cleaned data
  print("Data cleaned and transformed.")
  return(raw_data)
}





