# Require packages
# set working directory: setwd("c:/Users/user/Assignments/498f-final/")
library(plotly)
library(dplyr)

# makes a summary plot of expenses

  expenses_plot <- function(cand_name) {
    cand_data <- fec_data %>% 
      filter(Candidate == cand_name)
    
    plot_ly(fec_data,x = Candidate, y = Amount, mode = "markers", color = cand_name) %>% 
      layout(title = paste("Campaign Expenses"))
  }
  
  
  

  
