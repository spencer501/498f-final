
#########################################
# `pie_chart.R`
# This produces a pie chart that shows how much each 
# candidate spent for the 2016 presidential campaign. 
#########################################

# Required packages
library(plotly)
library(dplyr)

# Makes a summary plot that looks at the total expenses
# of each candidate
tot_expense <- function (expense_data) {
  
  plot_ly(expense_data,
          labels = Candidate,
          values = total,
          type = "pie") %>%
    layout(title = "2016 Campaign: Amount Spent")
}