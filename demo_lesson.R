library(dplyr)
now <- Sys.time()

later <- now + 10000

time_difference <- difftime(later,now)
time_difference
time_difference <- difftime(later,now,units = "mins")
time_difference
str(time_difference)
time_difference <- as.numeric(difftime(later,now,units = "mins"))

str(time_difference)
# vector definieren
numbers <- 1:10
numbers

# Anzeige des vectors
lead(numbers)
# rollt den vector um zwei stellen nach rechts und fuellt es mit NA
lead(numbers,n = 2)
# rollt den vector um zwei stellen nach links    und fuellt es mit NA
lag(numbers)
lag(numbers,n = 5)

lag(numbers,n = 5, default = 0)
wildschwein <- tibble(
  TierID = c(rep("Hans",5),rep("Klara",5)),
  DatetimeUTC = rep(as.POSIXct("2015-01-01 00:00:00",tz = "UTC")+0:4*15*60, 2)
)

wildschwein
# assign a timelag which is between two elements
wildschwein$timelag  <- as.numeric(difftime(lead(wildschwein$DatetimeUTC), wildschwein$DatetimeUTC))
# same command written in a other way
wildschwein <- mutate(wildschwein,timelag = as.numeric(difftime(lead(DatetimeUTC),DatetimeUTC)))
# currently, timelags are calculated between Boars. Grouping helps.
wildschwein <- group_by(wildschwein,TierID)
wildschwein <- mutate(wildschwein,timelag = as.numeric(difftime(lead(DatetimeUTC),DatetimeUTC)))
wildschwein
summarise(wildschwein, mean = mean(timelag, na.rm = T))

# Written in piping. Same functions     
wildschwein %>%                           # Take wildschwein...
  group_by(TierID) %>%                    # ...group it by TierID
  summarise(                              # Summarise the data...
    mean_timelag = mean(timelag,na.rm = T)# ...by calculating the mean timelag
  )
pigs <- tibble(
  TierID = c(8001,8003,8004,8005,8800,8820,3000,3001,3002,3003,8330,7222),
  sex = c("M","M","M","F","M","M","F","F","M","F","M","F"),
  age= c ("A","A","J","A","J","J","J","A","J","J","A","A"),
  weight = c(50.755,43.409,12.000,16.787,20.987,25.765,22.0122,21.343,12.532,54.32,11.027,88.08)
)

pigs

pigs %>%
  summarise(         
    mean_weight = mean(weight)
  )

pigs %>%
  group_by(sex) %>%
  summarise(         
    mean_weight = mean(weight)
  )
# summarise: crunches
# mutate: creates a new variable
pigs %>%
  group_by(sex,age) %>%
  summarise(         
    mean_weight = mean(weight)
  )