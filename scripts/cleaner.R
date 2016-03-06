#####################################################################
# `cleaner.R`
# Contains a function that reshapes data about presidential campaign 
# finance expenditures to be more easily analyzed.
# requires a data file about candidates political parties.
# Data source: http://www.fec.gov/disclosurep/PDownload.do
#####################################################################

# Needed libraries
library(dplyr)
library(stringr)
library(tools)

# Read in data about the political party each candidate belongs to
pol_party <- read.csv('data/2016_candidate_parties.csv')

# testing
#file_name <- 'data/2016_campaign_finances.csv'

# Reshape data for analysis
clean <- function(file_name) {
   
   # read in raw data
   data <- read.csv(file_name, stringsAsFactors = FALSE)
   
   # pick useful columns
   formatted_data <- data %>%
      select(
         cand_nm,
         recipient_nm,
         disb_amt,
         disb_dt,
         recipient_city,
         recipient_st,
         recipient_zip,
         disb_desc,
         memo_text
      ) %>%
      
      # give columns better names
      rename(
         "Candidate" = cand_nm,
         "Recipient" = recipient_nm,
         "Amount" = disb_amt,
         "Date" = disb_dt,
         "City" = recipient_city,
         "State" = recipient_st,
         "Zip" = recipient_zip,
         "Category" = disb_desc,
         "Memo" = memo_text
      ) %>%
      
      # change format of data
      mutate(Date = as.Date(Date, "%d-%b-%y"),
             City = str_to_title(City)) %>%
      
      # add political party data
      left_join(pol_party, by = "Candidate") %>%
      
      # rearrange columns
      select(1, 10, 2:9) %>%
      
      # sort rows
      arrange(Candidate, Date, Amount, State, Category)
   
   
   
   # set output filename to be original filename with "-clean" appended
   new_file_name <- paste0(file_path_sans_ext(file_name), "-clean.csv")
   
   # write new file
   return(write.csv(formatted_data, file = new_file_name))
   
}
