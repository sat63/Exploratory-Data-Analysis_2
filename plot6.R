## plot6.R

## Library 

library(ggplot2)

## Set WD

setwd("C:/Users/sanch/Desktop/JHU_DS")

## Load Dataset

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$yr <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

## Subset

MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

## Aggregate

MD.data <- aggregate(MD.onroad[,'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.data) <- c('year', 'Emissions')
MD.data$City <- paste(rep('MD', 4))

CA.data <- aggregate(CA.onroad[,'Emissions'], by = list(CA.onroad$year), sum)
colnames(CA.data) <- c('year', 'Emissions')
CA.data$City <- paste(rep('CA', 4))

df <- as.data.frame(rbind(MD.data, CA.data))
## Plot
ggplot(data=df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

## Save file

dev.copy(png, file = "plot6.png", width = 640, heigh = 480)

dev.off()