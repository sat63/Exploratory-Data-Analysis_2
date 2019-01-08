## plot3.R

## Library 

library(ggplot2)

## Set WD

setwd("C:/Users/sthakrar/Desktop/JHU_DS")

## Load Dataset

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sampling

Nsampling <- NEI[sample(nrow(NEI), size = 5000, replace=F),]

## Subset data

subNEI <- subset(NEI, fips == '24510') ## Create a new dataset with only observations where fips is 24510
subNEI$year <- factor(subNEI$year, levels = c('1999', '2002', '2005', '2008'))

## Plot


ggplot(data=subNEI, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') +
  geom_jitter(alpha=0.10)

## Save file

dev.copy(png, file = "plot3.png", width = 640, heigh = 480)

dev.off()