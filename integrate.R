# This script reproduces Shaun McGirr's analysis of 2016 US Federal Presidential Election campaign finance data
# Dependencies: packages loaded below, data loaded from data_raw

# Program structure
# 1. Load data from zip files downloaded earlier
# 2. Make it ready for analysis
# 3. Explore visually to refine business questions
# 4. Analyse to answer business questions
# 5. Produce automated report

####################
# 0. Preliminaries #
####################

# library(XML)        #install.packages('XML')
# library(httr)       #install.packages('httr')
# library(downloader) #install.packages('downloader')
library(readr)      #install.packages('readr')
library(lubridate)  #install.packages('lubridate')
library(zoo)        #install.packages('zoo')
library(ggplot2)    #install.packages('ggplot2')
library(dplyr)      #install.packages('dplyr')
library(ggmap)      #install.packages("ggmap")
library(Cairo)      #install.packages('Cairo')
library(tidyr)      #install.packages('tidyr')
library(knitr)      #install.packages('knitr')
library(xtable)     #install.packages('xtable')
library(maps)       #install.packages('maps')

options(digits = 15) # So display of numerics isn't truncated

##################
# 1. Obtain data #
##################

# Load data from data_raw (see download addresses in that folder if data not yet downloaded)
source("code_grooming/assemble_campaign_finance_data.R")

######################
# 2. Make data ready #
######################

# No further steps required

#######################
# 3. Explore visually #
#######################

# Visualise
source("code_analysis/visualise_campaign_finance_data.R")

#######################
# 4. Further analysis #
#######################

#

#####################
# 5. Compile report #
#####################

# knit('campaign-finance-report.rnw', encoding='UTF-8') 
# system('pdflatex campaign-finance-report.tex')
