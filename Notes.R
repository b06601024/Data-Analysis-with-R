quater_sales1 <- 3700
quater_sales2 <- 1300
midyear_sales <- quater_sales1 + quater_sales2
endyear_sales <- midyear_sales * 2



#Logical Operator
Solar.R > 150 & Wind > 10
Solar.R > 150 | Wind > 10
ds_airquality <- !(Solar.R > 150 | Wind > 10)
colnames(airquality)
head(airquality)
glimpse(airquality)
str(airquality)


#Lesson 3: R Sandbox Activity"

#練習一些基本且一定要會的function,選定diamonds的dataset做練習
library(tidyverse)

#要preview dataset 的話可以用head()來看，會出現column的名字和幾行
head(diamonds)

#如果要看完整的dataset 可以用View()
View(diamonds)

#利用str(dataset_name)或glimpse(dataset_name)來看dataset 的summary
str(diamonds)
glimpse(diamonds)

#利用colnames()來看dataset的column名字
colnames(diamonds)

#如果要換column的名字換成我們想要名字，可以用rename(dataset_name, new_name = original_name)
a <- rename(diamonds, price_new = price)
colnames(a) #檢查

#也可以更換多過一個column的名字
a <- rename(diamonds, price_new = price, cut_new = cut)
colnames(a)

#也可以簡單知道整個dataset的某個column的平均 etc.
summarize(diamonds, mean_price = mean(price))


#diamons dataset 是ggplot2 package 裡面的dataset, 當我們用了tidyverse的就會納入ggplot2的東西

#Data Visualization using ggplot2
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()

ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point()

ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_wrap(~cut)

install.packages("tidyverse")
library("tidyverse")
# There are 8 core tidyverse packages which is ggplot2, tibble, tidyr, readr, purr, dplyr, stringr, forcats
# browseVignettes(“packagename”) 
# A vignette shares details about the problem that the package is designed to solve and how the included functions can help you solve it. 
browseVignettes("ggplot2")
 

# Working with pipes
install.packages("dplyr")
library(dplyr)
data("ToothGrowth")
View(ToothGrowth)

filtered_tg <- filter(ToothGrowth, dose == 0.5)
View(filtered_tg)

arrange(filtered_tg, len) #Ascending ordered by len

#Nested
arrange(filter(ToothGrowth, dose == 0.5), len)

#Use pipe
filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose == 0.5) %>% 
  arrange(len)
View(filtered_toothgrowth)

library("ggplot2")
library("dplyr")
library("tidyverse")
head(diamonds)
str(diamonds)
colnames(diamonds)
name_changed <- rename(diamonds, colour = color)
colnames(name_changed)
new_column_diamonds <- diamonds %>% 
  rename(colour = color) %>% 
  mutate(carat_2 = carat * 2)
head(new_column_diamonds)


# Creating data frame
names <- c("Ali","Abu","Ah kau")
age <- c(18,19,20)
people <- data.frame(names, age)
head(people)
mutate(people, age_plus_20 = age +20)
head(mutate(people, age_plus_20 = age +20))

### 新知識點：mutate()可以新增variable, rename()則是換名

fruits <- c("Apple", "Orange", "Mango", "Papaya", "Banana")
scores <- c(2,1,4,5,3)
fruit_ranks <- data.frame(fruits, scores)
head(fruit_ranks)
Sorted_fruit_ranks <- fruit_ranks %>% 
  arrange(scores)
head(Sorted_fruit_ranks)
# understanding how to create and work with data frames is an important first step to analyzing data.  

as_tibble(Sorted_fruit_ranks)
as_tibble(diamonds)


# Data-import basics
data()

readr_example()
read_csv(readr_example("mtcars.csv"))

# Optional: the readxl package, to import spreadsheet
library(readxl)
readxl_example()
read_excel(readxl_example("type-me.xlsx" ))
excel_sheets(readxl_example("type-me.xlsx" )) #Return the names of individual sheets
read_excel(readxl_example("type-me.xlsx"), sheet = "numeric_coercion") # specify a sheet by name or number


# Hands-On Activity: Importing and working with data
install.packages("tidyverse")
library("tidyverse")

#注意：可以在每次開始新的session後，set working directory, 才讀檔案
bookings_df <- read_csv("hotel_bookings.csv")
head(bookings_df)
colnames(bookings_df)
str(bookings_df)
glimpse(bookings_df)
#如果只要幾個column做分析，可以用select搬去新的dataframe來做分析
new_df <- select(bookings_df, adr, adults)
counted_df <- new_df %>% 
  rename(average_daily_rate = adr) %>% 
  mutate(total = average_daily_rate / adults)
head(counted_df)

#Basic Cleaning SOP
install.packages("here")
library("here")
install.packages("skimr")
library("skimr")
install.packages("janitor")
library("janitor")

#The lecture use palmerpenguins dataset 
install.packages("palmerpenguins")
library("palmerpenguins")

install.packages("dplyr")
library("dplyr")

#There are few different functions to get summary of our data frame
#skim_without_charts()
#head()
#glimpse()
#select()

penguins %>% 
  select(-species)
#選subset用

#Two Basic Cleaning functions
rename_with(penguins, tolower) #把column名都換成小字母，或大字母toupper
clean_names(penguins)    #column名只有字母，號碼和底線會被保留

#Organize our data by using arrange(), group_by(), filter() function.

# 小到大或大到小
penguins2 <- penguins %>% 
  arrange(-bill_length_mm)  #sorted by the highest
View(penguins2)

# group_by()
penguins3 <- penguins %>% 
  group_by(species, island) %>% 
  drop_na() %>% 
  summarize(mean_bl = mean(bill_length_mm), mean_bd = mean(bill_depth_mm) )
penguins3

# filter()
penguins %>% filter(species == "Adelie")

# Hands-On Activity: Cleaning data in R

# Import our .csv file
bookings_df <- read_csv("hotel_bookings.csv")
#Apply the SOP of cleaning
library("here")
library("skimr")
library("janitor")
clean_names(bookings_df) 
rename_with(bookings_df, tolower)
# or below
bookings_df %>%  clean_names() %>% rename_with(tolower)


trimmed_df <- bookings_df %>% 
  select(hotel, is_canceled, lead_time)


trimmed_df %>% 
  select(hotel, is_canceled, lead_time) %>% 
  rename(hotel_type = hotel)

example_df <- bookings_df %>% 
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_date_month, c(arrival_date_year, arrival_date_month), sep = " ")
example_df

example_df <- bookings_df %>%
  mutate(guests =  adults + children + babies)


example_df <- bookings_df %>%
  summarize(number_canceled = sum(is_canceled), average_lead_time = mean(lead_time))
head(example_df)

#Optional: Manually create a data frame

id <- c(1:10)

name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")

job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")

employee <- data.frame(id, name, job_title)

fl_columns <- separate(employee, name, into = c("first_name", "last_name"), sep = " ")
name_column <- unite(fl_columns, Name, c("first_name", "last_name"), sep = " ")
name_column <- unite(fl_columns, Name, first_name, last_name, sep = " ") #没有放c也可以
name_column

##########################
# Hands-On Activity: Changing your data

library(tidyverse)
library(skimr)
library(janitor)

hotel_bookings <- read_csv("hotel_bookings.csv")
head(hotel_bookings)
str(hotel_bookings)
glimpse(hotel_bookings)
colnames(hotel_bookings)

sorted_df <- arrange(hotel_bookings, -lead_time)
sorted_df

max(hotel_bookings$lead_time)
min(hotel_bookings$lead_time)
mean(hotel_bookings$lead_time)
mean(sorted_df$lead_time)
hotel_bookings_city <- filter(hotel_bookings, hotel_bookings$hotel=="City Hotel")
head(hotel_bookings_city)
mean(hotel_bookings_city$lead_time)

hotel_summary <- 
  hotel_bookings %>%
  group_by(hotel) %>%
  summarize(average_lead_time=mean(lead_time),
            min_lead_time=min(lead_time),
            max_lead_time=max(lead_time))
head(hotel_summary)

################################################
# Week 4: Visualization in R

# Hands-On Activity: Visualizing data with ggplot2
library(palmerpenguins)
library(ggplot2)
head(penguins)
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point()

# Hands-On Activity: Using ggplot
hotel_bookings <- read_csv("hotel_bookings.csv")
ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x = lead_time, y = children))

ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x = stays_in_weekend_nights, y = children))



#######################
data(diamonds)
head(diamonds)
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity)) #stacked barplot
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = cut)) 
ggplot(data = diamonds) + geom_bar(mapping = aes(x = color, fill = cut)) + facet_wrap(~cut)




#Aesthetics and facets
library(palmerpenguins)
library(ggplot2)
head(penguins)
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_wrap(~species) + geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g, linetype = species))
 
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_grid(sex~species)
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_grid(~sex)

ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_wrap(~species) 


# Hands-On Activity: Aesthetics and visualizations
# https://d3c33hcgiwev3.cloudfront.net/BcijwTl7RhKIo8E5e2YSeg_3e0f5bb543fa4525a0378a7ba0338bf1_Lesson3_Aesthetics.Rmd?Expires=1637625600&Signature=PmIkgJLKbALfRK0meTAjAYZ171q4tSA4LAlr5yQaYY2WOahY~2v9mKp3pyt5~YLd5tOuqOScr-ZFcu2aviA5xOal-bi2M4lLcMhXpPHgDkjSGDdnKkHEEtAOpGIEP3MK8OI~8Lzk5vGRQAwFsJqxTdM7xdrqzioOr6C7hmVOR3E_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel, fill = distribution_channel))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel, fill = deposit_type))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel, fill = market_segment ))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~deposit_type)

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~deposit_type) +
  theme(axis.text.x = element_text(angle = 45))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_grid(~deposit_type) +
  theme(axis.text.x = element_text(angle = 45))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +   #正確的
  facet_wrap(~deposit_type~market_segment) +
  theme(axis.text.x = element_text(angle = 45))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_grid(market_segment~deposit_type) +
  theme(axis.text.x = element_text(angle = 45))

# These charts are probably overwhelming and too hard to read, but it can be useful if you are exploring your data through visualizations.  

#####################################
# Hands-On Activity: Filters and plots
# https://d3c33hcgiwev3.cloudfront.net/cgXdEhw9SqmF3RIcPXqpiQ_62e138c702bb4abfba5db60f97e5edf1_Lesson3_Filters.Rmd?Expires=1637625600&Signature=hPd4HNPHXp4FfDEW6xUacpwWRo0LpwFqRhVfbFxhp2~9nd2COzU2kmaNYFRPsw3TdzX0yGYY0P-CqLz3j3NWmmLcF9FkiUrbjKLzDZe2Bc9X6H7o3yplYTzv6WhghOh0oDIozpzgEX-puRsnOOc7btkLTBghQFIImnotTLBlEmI_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A

ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x = lead_time, y = children))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = hotel, fill = market_segment))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = hotel)) +
  facet_wrap(~market_segment)

onlineta_city_hotels <- filter(hotel_bookings, 
                               (hotel=="City Hotel" & 
                                  hotel_bookings$market_segment=="Online TA"))

View(onlineta_city_hotels)

onlineta_city_hotels_v2 <- hotel_bookings %>%
  filter(hotel=="City Hotel") %>%
  filter(market_segment=="Online TA")

View(onlineta_city_hotels_v2)

ggplot(data = onlineta_city_hotels_v2) +
  geom_point(mapping = aes(x = lead_time, y = children))
############################################################

# Annotations and labels

library(palmerpenguins)
library(ggplot2)

ggplot(data = penguins)+
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species))+
  labs("text", title = "Palmer Penguins: Flipper Length(mm) VS Body Mass(g)",
       subtitle = "Sample of Three Penguins Species", caption = "Data collected by Dr.Kristen Gorman")+
  annotate("text", x = 220, y = 3500, label = "The Gentoos are the largest", color = "Purple", fontface = "bold", size = 4.5, angle = 25)

#############################
# Markdown
install.packages("rmarkdown")
head(cars)








