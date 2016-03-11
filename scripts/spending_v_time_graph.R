#########################################
# `spending_v_time.R`
# This produces a graph showing candidate 
# spending data over time
#########################################


# Required packages
library(plotly)
library(dplyr)

# Needed functions
source("scripts/analysis.R")

# graph the spending of each candidate over time
spending_v_time <- function(expense_data) {
   names <- unique(expense_data$Candidate)
   
   p <- plot_ly()
   
   for(nm in names) {
      
      p <- finance_for(expense_data, nm) %>%
         add_trace(x = Date, y = total_spent, evaluate = TRUE, name = nm)
   }
   
   return(p)
}