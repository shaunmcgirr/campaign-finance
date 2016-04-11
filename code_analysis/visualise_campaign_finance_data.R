# This script "creates an overview of the most significant contributors by:
# Occupation
# Employer
# State
# Rate over Time

## Notes
# 

## 0. Basics
clinton_total <- sum(contributor_data_democrats_cleaned$Amount[contributor_data_democrats_cleaned$Candidate == "Clinton, Hillary Rodham"])
sanders_total <- sum(contributor_data_democrats_cleaned$Amount[contributor_data_democrats_cleaned$Candidate == "Sanders, Bernard"])


## 1. Occupation
# Simple table with top ten occupations by candidate will do

top_ten_occupations_by_candidate <- contributor_data_democrats_cleaned %>%
                                      filter(Candidate %in% c("Clinton, Hillary Rodham", "Sanders, Bernard")) %>%
                                      group_by(Candidate, Occupation) %>%
                                        summarise(`Total donated` = sum(Amount)) %>%
                                        arrange(Candidate, -`Total donated`) %>%
                                      group_by(Candidate) %>%
                                        mutate(Percentage = round(`Total donated` / sum(`Total donated`) * 100, digits = 1)) %>%
                                        filter(row_number() <= 10) %>%
                                      ungroup()

top_ten_occupations_by_candidate_for_table <- top_ten_occupations_by_candidate %>%
                                                select(Occupation, Percentage)
top_ten_occupations_by_candidate_for_table <- cbind(top_ten_occupations_by_candidate_for_table[1:10,],
                                                    top_ten_occupations_by_candidate_for_table[11:20,])

xtable(top_ten_occupations_by_candidate_for_table)

## 2. Employer
# Along the way get rid of the less interesting employers (self-employed etc) and residuals
employers_not_presented <- c("N/A", "SELF-EMPLOYED", "", "RETIRED", "INFORMATION REQUESTED", "NOT EMPLOYED",
                             "NONE", "SELF", "SELF EMPLOYED", "NA", "MR.", "MS.", "INFO REQUESTED", "FREELANCE",
                             "UNEMPLOYED")

top_ten_employers_by_candidate <- contributor_data_democrats_cleaned %>%
  filter(Candidate %in% c("Clinton, Hillary Rodham", "Sanders, Bernard")) %>%
  group_by(Candidate, Employer) %>%
    summarise(`Total donated` = sum(Amount)) %>%
    arrange(Candidate, -`Total donated`) %>%
  group_by(Candidate) %>%
    mutate(Percentage = round(`Total donated` / sum(`Total donated`) * 100, digits = 2)) %>%
    filter(!Employer %in% employers_not_presented) %>%
  filter(row_number() <= 20) %>%
  ungroup()

clinton_top_twenty_employers <- top_ten_employers_by_candidate %>%
                                  filter(Candidate == "Clinton, Hillary Rodham") %>%
                                  select(Employer) 

cat(paste(as.character(clinton_top_twenty_employers), sep = ","))

sanders_top_twenty_employers <- top_ten_employers_by_candidate %>%
  filter(Candidate == "Sanders, Bernard") %>%
  select(Employer) 

cat(paste(as.character(sanders_top_twenty_employers), sep = ","))


## 3. State
# Try a map

contributions_by_state <- contributor_data_democrats_cleaned %>%
  filter(Candidate %in% c("Clinton, Hillary Rodham", "Sanders, Bernard")) %>%
  group_by(Candidate, State) %>%
    summarise(`Total donated` = sum(Amount)) %>%
    arrange(Candidate, -`Total donated`) %>%
  group_by(Candidate) %>%
    mutate(Percentage = round(`Total donated` / sum(`Total donated`) * 100, digits = 1)) %>%
   filter(row_number() <= 100) %>%
  ungroup()

map(database = "state")
map_data("state")

