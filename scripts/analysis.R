#########################################
# `analysis.R`
# Description
#########################################

# Needed libraries
library(dplyr)
library(lubridate)

# temp
#cand_name <- "Donald Trump"

# Read in clean data
fec_data <- read.csv('data/2016_campaign_finances-clean.csv', stringsAsFactors = FALSE)

# filter for data about a specific candidate
finance_for <- function(spending_data, cand_name) {
   cand_data <- spending_data %>% 
      filter(Candidate == cand_name)
   
   return(cand_data)
}

# filter down to candidates who are still running
still_running <- function(spending_data) {
   return_data <- spending_data %>% 
      filter(Running == TRUE)
   
   return(return_data)
}

# summarize total spending of candidates
total_spending_of <- function(spending_data) {
   return_data <- spending_data %>% 
      group_by(Candidate) %>% 
      summarise(total = sum(Amount)) %>% 
      arrange(total)
   
   return(return_data)
}

# Summarize spending by date
spending_by_date_for <- function(spending_data) {
   return_data <- spending_data %>%
      mutate(Date = as.Date(paste0("1", "-", month(Date), "-", year(Date)), "%d-%m-%Y")) %>% 
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

# Filter down to expenses that map movement
travel_of <- function(spending_data) {
   return_data <- spending_data %>% 
      filter(spending_data, grepl('TRAVEL|FOOD', Category))
}

# Get general summary of candidate spending
summary_for <- function(spending_data) {
   
   return_data <- spending_data %>% 
      group_by(Candidate, 
               State) %>%
      summarise(total = sum(Amount),
                expense = sum(Amount[Amount > 0]),
                income = sum(Amount[Amount < 0]),
                transactions = length(Amount),
                min_expense = min(Amount[Amount > 0]),
                max_expense = max(Amount),
                most_pop = names(sort(-table(Recipient)))[1],
                biggest_recipient = Recipient[Amount == max(Amount)][1])
    
      
   return(return_data)  
}

