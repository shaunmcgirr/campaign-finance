# This script assembles the CSVs in to a useable structure

## Notes
# 

## 0. Unzip etc
# unzip("data_raw/screener_new_data.zip", overwrite = T, exdir = "data_raw")

## 1. Load data for Democrats (note that warning results from comma at end of every line)
contributor_data_democrats_raw <- read_csv(file = "data_raw/P00000002-ALL.csv", trim_ws = T)

# Convert date
contributor_data_democrats_raw$contb_receipt_dt <- parse_date(contributor_data_democrats_raw$contb_receipt_dt,
                                                              format = "%d-%b-%y")

# Fix occupation
contributor_data_democrats_raw$contbr_occupation[contributor_data_democrats_raw$contbr_occupation == ""] <- "OCCUPATION NOT GIVEN"


## 2. Load data for Sanders only
# contributor_data_sanders_raw <- read_csv(file = "data_raw/P60007168-ALL.csv", trim_ws = T)
# 
# contributor_data_sanders_raw$contb_receipt_dt <- parse_date(contributor_data_sanders_raw$contb_receipt_dt,
#                                                               format = "%d-%b-%y")


## 3. Just work with the combined file, and just the columns we need
contributor_data_democrats_cleaned <- contributor_data_democrats_raw %>%
                                        transmute(Candidate = cand_nm,
                                                  Contributor = contbr_nm,
                                                  State = contbr_st,
                                                  Employer = contbr_employer,
                                                  Occupation = contbr_occupation,
                                                  Amount = contb_receipt_amt,
                                                  Date = contb_receipt_dt)

