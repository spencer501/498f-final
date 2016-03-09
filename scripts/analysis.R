#########################################
# `analysis.R`
# Description
#########################################

# Needed libraries
library(dplyr)

# temp
#cand_name <- "Donald Trump"

# Read in clean data
fec_data <- read.csv('data/2016_campaign_finances-clean.csv', stringsAsFactors = FALSE)

# filter for data about a specific candidate
finance_for <- function(cand_name) {
   cand_data <- fec_data %>% 
      filter(Candidate == cand_name)
   
   return(cand_data)
}

# Summarize spending by date
spending_by_date_for <- function(spending_data) {
   return_data <- spending_data %>% 
      group_by(Candidate, Date) %>% 
      summarise('transactions' = length(Amount),
                'total_spent' = sum(Amount),
                'lat' = Lat[1],
                'lng' = Lng[1])
   
   return(return_data)
}

# Filter down to expense amounts in a specific range
spending_range_of <-function(spending_data, min, max) {
   return_data <- spending_data %>% 
      filter((Amount >= min) & (Amount <= max))
   
   return(return_data)
}
