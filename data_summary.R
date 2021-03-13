library(ggplot2)
library(dplyr)
library(ggmap)
library(mapproj)

#host, country (DONE), collection date (DONE), genome length
dat <- read.csv("./input/info.csv")

dat$length <- as.factor(dat$length)
dat <- mutate(dat, host = gsub("([A-Z].*) .*", "\\1", dat$host))
dat <- mutate(dat, release_year = gsub("(\\d+)-.*", "\\1", dat$release_date))


country_df <- data.frame(table(dat$country))
rownames(country_df) <- country_df$Var1
country_df$region <- rownames(country_df)

world_map <- map_data("world")
collection_map <- left_join(world_map, country_df, by = "region")

# Create the map
ggplot(collection_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Freq), color = "white") +
  scale_fill_viridis_c(option = "C")

ggplot(country_df, aes(x = region, y = Freq)) + geom_col()

ggplot(dat, aes(x = as.numeric(release_year))) + geom_bar() +
  scale_x_continuous(breaks = seq(1999, 2015, by = 1))

ggplot(count.data, aes(x = "", y = prop, fill = class)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+
  geom_text(aes(y = lab.ypos, label = prop), color = "white")+
  scale_fill_manual(values = mycols) +
  theme_void()
