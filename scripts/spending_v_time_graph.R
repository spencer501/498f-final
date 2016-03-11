
# Required packages
library(plotly)
library(dplyr)

source("scripts/analysis.R")

# graph the spending of each candidate over time
spending_v_time <- function(expense_data) {
   names <- unique(expense_data$Candidate)
   
   p <- plot_ly()
   
   for(nm in names) {
      
      p <- finance_for(nm, expense_data) %>%
         add_trace(x = Date, y = total_spent, evaluate = TRUE, name = nm)
   }
   
   return(p)
}