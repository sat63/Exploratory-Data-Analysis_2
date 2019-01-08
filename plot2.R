## plot2.R

## Set WD

setwd("C:/Users/sthakrar/Desktop/JHU_DS")

## Load Dataset

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sampling

Nsampling <- NEI[sample(nrow(NEI), size = 5000, replace=F),]

## Subset data

subNEI <- subset(NEI, fips == '24510') ## Create a new dataset with only observations where fips is 24510

## Plot

barplot(tapply(X=subNEI$Emissions, INDEX = subNEI$year, FUN=sum),
        main='Total Emission in Baltimore City, MD',
        xlab = 'Year', ylab = expression('PM[2.5]'))

## Save file

dev.copy(png, file = "plot2.png")

dev.off()