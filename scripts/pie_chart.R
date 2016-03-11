
# Required packages
library(plotly)
library(dplyr)


# makes a summary plot of expenses
tot_expense <- function (expense_data) {
  
  
  plot_ly(expense_data,
          labels = Candidate,
          values = total,
          type = "pie") %>%
    layout(title = "2016 Campaign: Amount Spent")
}