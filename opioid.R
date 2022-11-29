library(tidyverse)
install.packages("readxl")
library(readxl)
library(lubridate)##### 

opioid <- read_excel("opioid_R.xlsx", na = "")
help(read_excel)

opioid <- as.data.frame(opioid)

library(tidyr)
opioid_long <- opioid %>% pivot_longer(cols = starts_with("20"),values_to = "count") %>% drop_na() 
opioid_long <- opioid_long[,-c(3)]

####
opioid_IP <- opioid %>% filter(`Hospital Setting`== "IP" & `Characteristic Level` == "All inpatient stays^")
opioid_IP<- opioid_IP[,-c(3:4,65:68)] 

MissingRate <- opioid_IP
MissingRate[,-c(1:2)] <- c(NA)

E <- ncol(opioid_IP)
for (i in 1:nrow(opioid_IP)){
  for(j in 3:E){
MissingRate[i,j]<- sum(is.na(opioid_IP[i,j:E]))/length(c(opioid_IP[i,j:E]))
  }
    }

rbind(MissingRate[,-c(1:2)],apply(MissingRate[,-c(1,2)],2,sum))

names(opioid_IP)
opioid_IP_11_19<- opioid_IP[-c(1,6,18,21,47),-c(2,3:22,59:62)] 
n <- nrow(opioid_IP_11_19)
opioid_IP_11_19 <- as.matrix(opioid_IP_11_19[,-1])
#MRC 
mrc = mrc.mean(opioid_IP_11_19[,-1] , beta = 1.5*log(n))


