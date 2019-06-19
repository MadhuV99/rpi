R_basics1.R
setwd('~/pj/rpi')
#install.packages("readxl")
#detach('package:readxl', unload=TRUE)
library(readxl)

?read.table
temperature = read.table("temp.txt", header = TRUE)
str(temperature)
temperature$DryWt
temperature = read.table("temp.txt", header = TRUE, na.strings = ".")
temperature = read.table("temp.txt", header = TRUE, na.strings = c(".", NA))
str(temperature)
head(temperature,15)
tail(temperature)                         
names(temperature)
dim(temperature)
nrow(temperature)
ncol(temperature)
summary((temperature))

respspring = read.csv("spring resp.csv")

?read_excel
respfall = read_excel("fall resp.xlsx", sheet = 1)

str(respspring)
respspring$Date = as.Date(respspring$Date, format = "%m/%d/%Y")
head(respspring)
respspring$season = "spring" # Add the column "season" with the category of "spring"

str(respfall)
respfall$Date = as.Date(respfall$Date, format = "%Y-%m-%d")
head(respfall)
respfall$season = "fall"

names(respspring)
names(respfall)

names(respfall) = c("Sample", "Date" , "Resp" , "Season")
names(respfall)[4] 
names(respfall)[4] = "season" # replace the 4th name

respall = rbind(respspring, respfall)
str(respall)
head(respall)
summary(respall)

?merge
resptemp = merge(respall, temperature)
head(resptemp)

head(merge(respall, temperature, by = "Sample"))

temp2 = temperature
names(temp2)[1] = "Samplenum"
head(merge(respall, temp2, by.x = "Sample", by.y = "Samplenum"))

str(temperature)
head(temperature)
str(respall)

sort(temperature$Sample)
sort(respall$Sample)

resptemp = merge(respall, temperature, by = "Sample", all = TRUE)
str(resptemp)
head(resptemp)

resptemp$season
str(resptemp)

as.factor(resptemp$season)
resptemp$season = as.factor(resptemp$season)

?factor
factor(resptemp$season, levels = c("spring", "fall"),
       labels = c("Spring", "Fall") )

resptemp$season = factor(resptemp$season, levels = c("spring", "fall"),
                         labels = c("Spring", "Fall") )
head(resptemp)
resptemp = transform(resptemp, tempf = 32 + ( (9/5)*Temp) )

resptemp = transform(resptemp, tempgroup = ifelse(Temp < 8, "Cold", "Hot") )
resptemp$tempgroup
summary(resptemp)

mean(resptemp$DryWt, na.rm = TRUE)
resptemp2 <- na.omit(resptemp)

rownames(resptemp2)
rownames(resptemp2) <- as.character(c(1:58))

?write.csv
write.csv(x = resptemp, file = "combined_resp_and_temp_data.csv", row.names = FALSE)

subset(resptemp, tempgroup == "Cold")
subset(resptemp, tempgroup == "Cold", select = c("Resp", "tempgroup") )

summary( subset(resptemp, tempgroup == "Cold", select = "Resp") )
summary( subset(resptemp, tempgroup == "Hot", select = "Resp") )








