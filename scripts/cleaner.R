#####################################################################
# `cleaner.R`
# Contains a function that reshapes data about presidential campaign 
# finance expenditures to be more easily analyzed.
# requires a data file about candidates political parties.
# Data source: http://www.fec.gov/disclosurep/PDownload.do
# Current as of March 5, 2015
#####################################################################

# Needed libraries
library(dplyr)
library(stringr)
library(tools)

# testing
#file_name <- 'data/2016_campaign_finances.csv'

# Read in data about the political party each candidate belongs to
cand_data <- read.csv('data/2016_candidates.csv')

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
      
      # add candidate data
      left_join(cand_data, by = "Candidate") %>%
      
      # change format of data
      mutate(Date = as.Date(Date, "%d-%b-%y"),
             City = str_to_title(City),
             Candidate = Popular_name) %>%
      
      # rearrange columns
      select(1, 11:12, 2:9) %>%
      
      # sort rows
      arrange(desc(Running), Candidate, Date, Amount, State, Category)
   
   
   
   # set output filename to be original filename with "-clean" appended
   new_file_name <- paste0(file_path_sans_ext(file_name), "-clean.csv")
   
   # write new file
   return(write.csv(formatted_data, file = new_file_name, row.names = FALSE))
   
}
