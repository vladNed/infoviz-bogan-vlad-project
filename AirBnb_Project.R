# Importing the data
nyc_path = "datasets/NYC_AIRBNB.csv"
boston_path = "datasets/BOSTON_LISTING.csv"

nyc_dataset = read.csv(nyc_path, header = TRUE)
boston_dataset = read.csv(boston_path, header = TRUE)

# Dataset cleaning
# From NYC Dropping the name column because we think the name of the listing is not yet important
nyc_dataset = subset(nyc_dataset, select = -c(2))
names(nyc_dataset)