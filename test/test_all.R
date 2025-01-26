source("scripts/data_cleaning.R")
source("scripts/EDA.R")
source("scripts/modeling.R")

source("test/test_clean_data.R")
source("test/test_modeling.R")

test_clean_data()
test_modeling()

print("All tests passed!")