# Install required packages for the project
required_packages <- c("dplyr", "ggplot2", "caret", "pROC", "yaml", "testthat","reshape2","targets")

# Check for missing packages and install them
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]

if (length(missing_packages)) {
  install.packages(missing_packages)
}

# Print a message indicating setup completion
cat("Setup completed. All required packages are installed.\n")
