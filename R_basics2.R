R_basics2.R
setwd('~/pj/rpi')
#install.packages("readxl")
#detach('package:readxl', unload=TRUE)
library(readxl)
library(ggplot2)

plot(x = resptemp$tempgroup, y = resptemp$Resp)

qplot(x = tempgroup, y = Resp, data = resptemp)

qplot(x = tempgroup, y = Resp, data = subset(resptemp, !is.na(tempgroup)))

qplot(x = tempgroup, y = Resp, data = resptemp, geom = "boxplot")

qplot(x = tempgroup, y = Resp, data = subset(resptemp, !is.na(tempgroup) ),
      geom = "boxplot")

resptemp2 = subset(resptemp, !is.na(tempgroup) )

qplot(x = tempgroup, y = Resp, data = resptemp2, geom = "boxplot") +
  stat_summary(fun.y = mean, geom = "point", color = "red", size = 3)

hist(resptemp2$Resp)

qplot(x = Resp, fill = tempgroup, data = resptemp2, geom = "histogram")

qplot(x = Resp, fill = tempgroup, data = resptemp2,
      geom = "density", alpha = I(.5) )

resptemp2$tempgroup = factor(resptemp2$tempgroup, levels = c("Hot", "Cold"))

qplot(x = Resp, fill = tempgroup, data = resptemp2,
      geom = "density", alpha = I(.5) )

(x <- 5)

(respunequal = t.test(Resp ~ tempgroup, data = resptemp2))
str(respunequal)


(respequal = t.test(Resp ~ tempgroup, data = resptemp2, var.equal = TRUE))

(respwilcox = wilcox.test(Resp ~ tempgroup, data = resptemp2))
