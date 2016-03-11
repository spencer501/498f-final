#########################################
# `bar_chart.R`
# This produces a bar chart showing 
# candidate spending data per state
#########################################

# Required packages
library(plotly)
library(dplyr)

# Needed functions
source("scripts/analysis.R")

# make bar chart showing spending by state
bar_state_spending <- function(spending_data) {
   p <- spending_data %>%
      plot_ly(
         x = State,
         y = total,
         name = paste("Spending by state for", cand_nm),
         type = "bar"
      )
   
   return(p)
}