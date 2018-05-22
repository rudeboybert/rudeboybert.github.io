# Load fivethirtyeight and other needed packages
library(fivethirtyeight)
library(dplyr)
library(ggformula)
library(ggplot2)
library(maps)


# Ex 1: US Births ---------------------------------------------------
View(US_births_1994_2003)
?US_births_1994_2003

# Use filter command from dplyr package for data wrangling
US_births_1999 <- US_births_1994_2003 %>%
  filter(year == 1999)
View(US_births_1999)

# Plot time series via base R:
plot(x = US_births_1999$date, y = US_births_1999$births, type = "l")


# Ex 2: Hate crimes -------------------------------------------------
View(hate_crimes)
?hate_crimes

# Create scatterplot & regression line via ggformula package
gf_point(hate_crimes_per_100k_splc ~ share_vote_trump, data = hate_crimes) %>%
  gf_lm()


# Ex 3: Campaign stops of last 10 weeks of 2016 US election ---------
View(pres_2016_trail)
?pres_2016_trail

# Create map of Clinton vs Trump campaing stops via ggplot2 package and using
# preloaded map_data of US states in maps package
ggplot(data = pres_2016_trail, aes(x = lng, y = lat)) +
  facet_wrap(~candidate) +
  geom_point(col = "black", size = 3) + 
  coord_map() + 
  geom_path(data = map_data("state"), aes(x = long, y = lat, group = group), size = 0.1)
