# covid_cases

This repo is aimed to give you the tools to generate quickly and transparently databases and graphs about Covid-19 cases in the world.
The number of cases chages every day (and even faster) and the database is updated every morning (ish).
You can download it following this link https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide and you will find a new dataset every day with the updated figures.

OR copy and paste it in R

#these libraries are necessary

library(readxl)

library(httr)

#create the URL where the dataset is stored with automatic updates every day

url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xlsx", sep = "")

#download the dataset from the website to a local temporary file

GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xlsx")))

#read the Dataset sheet into “R”

data <- read_excel(tf)

Then follow the steps...
R operations here are basic, I didn't do that to push the boundaries of datajournalism, so feel free to submit any improvements.
I'd also suggest that you use it mainly to export subset data and visualise them in Flourish for example.
But it helps to keep graphs updated very quickly.

Nothing will push the boudaries of data journalism here so feel free to submit your improvements...
