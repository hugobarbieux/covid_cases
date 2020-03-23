# You can either download the dataset at https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
# Save it in a .csv
# The data are updated everyday, check the website every morning and repeat the operations

##########
# Script for downloading the Excel file into "R" software
# These libraries are necessary

library(readxl)

library(httr)

#create the URL where the dataset is stored with automatic updates every day

url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xlsx", sep = "")

#download the dataset from the website to a local temporary file

GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xlsx")))

#read the Dataset sheet into "R"

data <- read_excel(tf)

##########
# Import dataset in a variable

covidworldcases <- read.csv("COVID-19-geographic-disbtribution-worldwide-2020-03-22.csv")

View(covidworldcases)

# Optional - Examine the data

dim(covidworldcases)
names(covidworldcases)
nrow(covidworldcases)
ncol(covidworldcases)
head(covidworldcases)
tail(covidworldcases)
summary(covidworldcases)

##########
# Generate a sort of pivot table, apply a sum to the Cases column and aggregate it by the Countries column

tapply(covidworldcases$Cases, covidworldcases$Countries.and.territories, sum)

# Put the "pivot table" in a new variable

casesbycountry <- tapply(covidworldcases$Cases, covidworldcases$Countries.and.territories, sum)
View(casesbycountry)

deathsbycountry <- tapply(covidworldcases$Deaths ,covidworldcases$Countries.and.territories, sum)
View(deathsbycountry)

# Order it

casesbycountry <- casesbycountry[order(-casesbycountry)]
deathsbycountry <- deathsbycountry[order(-deathsbycountry)]

View(casesbycountry)
View(deathsbycountry)

# Select only the 50 first rows

casesbycountry <- casesbycountry[c(1:50)]
deathsbycountry <- deathsbycountry[c(1:50)]

# Create a bar chart with "pivot" values

barplot(height = casesbycountry)
barplot(height = deathsbycountry)

# Export "pivot" to use it with any visualisation program

write.csv(casesbycountry, file='cases_by_country.csv')
write.csv(deathsbycountry, file = "deaths_by_country.csv")

##########
# Subset the dataset by country

Italy <- subset(covidworldcases, covidworldcases$Countries.and.territories == "Italy")
View(Italy)

write.csv(Italy, file="Italy.csv")

# Create a bar chart

barplot(height = Italy$Deaths, xlab = "Day")

##########

