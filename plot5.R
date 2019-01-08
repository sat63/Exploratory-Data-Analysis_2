## plot5.R

## Library 

library(ggplot2)

## Set WD

setwd("C:/Users/sanch/Desktop/JHU_DS")

## Load Dataset

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$yr <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

## Subset

NEIonroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

## Aggregate

NEI.df <- aggregate(NEIonroad[, 'Emissions'], by=list(NEIonroad$year), sum)
colnames(NEI.df) <- c('year', 'Emissions')

## Plot
ggplot(data=NEI.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill= year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

## Save file

dev.copy(png, file = "plot5.png", width = 640, heigh = 480)

dev.off()