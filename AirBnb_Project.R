library(ggplot2)

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
  scale_color_brewer(palette = "Dark2")

# Price 

price_nyc <- nyc_dataset[nyc_dataset[,"price"] < 300,]
ggplot(price_nyc, aes(x=room_type, y=price)) + 
  geom_boxplot() + ggtitle('Price per room type NYC')

ggplot(nyc_dataset, aes(x=latitude, y = longitude)) + 
  geom_point() + ggtitle('Map of the NYC listings')

ggplot(price_nyc, aes(x=latitude, y=longitude, color=price)) +
  geom_point() + ggtitle('Map by price NYC listing')
