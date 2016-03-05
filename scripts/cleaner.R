library(dplyr)

data <- read.csv('2016_election.csv')

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
   rename("Candidate" = cand_nm,
          "Recipient" = recipient_nm,
          "Amount" = disb_amt,
          "Date" = disb_dt,
          "City" = recipient_city,
          "State" = recipient_st,
          "Zip" = recipient_zip,
          "Category" = disb_desc,
          "Memo" = memo_text)

write.csv(formatted_data, file = "data/cleaned_finance_data.csv")
