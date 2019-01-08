## plot1.R

## Set WD

setwd("C:/Users/sthakrar/Desktop/JHU_DS")

## Load Dataset

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sampling

Nsampling <- NEI[sample(nrow(NEI), size = 2000, replace=F),]

## Aggregate (compute summary statistics of data subsets)

Ems <- aggregate(NEI[,'Emissions'], by=list(NEI$year), FUN = sum)
Ems$PM <- round(Ems[,2]/1000, 2) ## Add variable PM in dataset Ems

## Plot

barplot(Ems$PM, names.arg = Ems$Group.1,
        main = expression('Total Emission of PM' [2.5]),
        xlab = 'Year', ylab=expression(paste('PM', ''[2.5], 'in Kilotons')))

## Save file

dev.copy(png, file = "plot1.png")

dev.off()