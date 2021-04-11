install.packages("corrplot")
library(ggplot2)
library(corrplot)

# Importing the data
nyc_path = "clean_datasets/NYC_CLEAN.csv"
boston_path = "clean_datasets/BOSTON_CLEAN.csv"

nyc_dataset <- read.csv(nyc_path, header = TRUE)
boston_dataset <- read.csv(boston_path, header = TRUE)


# Room type counts

all <- rbind(data.frame(fill = "NYC", room_types= nyc_dataset$room_type),
             data.frame(fill = "Boston", room_types= boston_dataset$room_type))

ggplot(nyc_dataset, aes(x = room_type,  fill = room_type)) + 
  geom_bar() + ggtitle('Room count NYC listing')

ggplot(boston_dataset, aes(x = room_type, fill = room_type)) + 
  geom_bar() + ggtitle('Room count Boston listing')

ggplot(all, aes(x = room_types, fill = fill)) + 
  geom_bar() + ggtitle('Room count Boston listing')

ggplot(nyc_dataset, aes(x=latitude, y=longitude, color=room_type)) +
  geom_point() + ggtitle('Map/room type NYC listing') +
  scale_color_brewer(palette = "Dark2")

ggplot(boston_dataset, aes(x=latitude, y=longitude, color=room_type)) +
  geom_point() + ggtitle('Map/room type Boston listing') +
  scale_color_brewer

ggplot(nyc_dataset, aes(x=neighbourhood_group, fill=room_type)) +
  geom_bar()

# Price 

price_nyc <- nyc_dataset[nyc_dataset$price < 300]
ggplot(price_nyc, aes(x=room_type, y=price)) + 
  geom_boxplot() + ggtitle('Price per room type NYC')

ggplot(nyc_dataset, aes(x=latitude, y = longitude)) + 
  geom_point() + ggtitle('Map of the NYC listings')

ggplot(price_nyc, aes(x=latitude, y=longitude, color=price)) +
  geom_point() + ggtitle('Map by price NYC listing')

# Price per neighbourhood

ggplot(price_nyc, aes(x=number_of_reviews, y=price, color=neighbourhood_group)) +
  geom_point(alpha=.5) +
  scale_color_brewer(palette = 'Dark2')

min_night_vs_price <- subset(nyc_dataset, minimum_nights < 30 & price < 300)
ggplot(min_night_vs_price, aes(x=minimum_nights, y=price, color=room_type)) +
  geom_point(alpha=.1) +
  scale_color_brewer(palette = 'Dark2')

# Boston exploration

boston_dataset

ggplot(boston_dataset, aes(x=property_type, fill=room_type)) +
  geom_bar() + ggtitle("Apr type in property")

aprt_features <- subset(boston_dataset, select=c("accommodates","beds", "bathrooms", "bedrooms",
                                                "cleaning_fee", "minimum_nights",
                                                "availability_30", "review_scores_rating"))
corr_aprt_features <- cor(aprt_features, method=c('spearman'))  

corrplot(corr_aprt_features)


