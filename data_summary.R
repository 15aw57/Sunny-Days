library(ggplot2)
library(dplyr)
library(ggmap)
library(mapproj)

#host, country (DONE), release year (DONE), genome length (DONE)
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

# release year
ggplot(dat, aes(x = as.numeric(release_year))) + geom_bar() +
  scale_x_continuous(name = "Collection date", breaks = seq(1999, 2015, by = 2))

# genome length
ggplot(dat, aes(x = "", y = length, fill = length)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start = 0) + theme_void() + ggtitle("Genome Length")

# host
host_count <- count(dat, host)
common_name <- c("Unknown", "Mosquito (Aedes)", "Bird", "Crow", "Mosquito (Culex)", 
                 "Mosquito (Cuclicidae)", "Mosquito (Culiseta)", "Ticks (Dermacentor)", "Horse",
                 "Human", "Ticks (Hyalomma)", "Oriolus (Bird)", "Ticks (Ornithodoros)", "Fruit bat",
                 "Tissue culture")
species <- c("Unknown", "Mosquito", "Bird", "Bird", "Mosquito", "Mosquito", "Mosquito", "Ticks",
             "Horse", "Human", "Ticks", "Bird", "Ticks", "Bat", "Tissue")

host_count <- cbind(host_count, common_name, Species = as.factor(species))

host_count %>% ggplot(aes(x = reorder(common_name, n), y = n, fill = Species)) + 
  geom_col() + coord_flip() + 
  scale_x_discrete(name = "Species") + scale_y_continuous(name = "Count")
