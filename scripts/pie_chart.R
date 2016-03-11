
# Required packages
# set working directory: setwd("c:/Users/user/Assignments/498f-final/")
library(plotly)
library(dplyr)
# makes a summary plot of expenses
tot_expense <- function (fec_data) {
  expense_data <- group_by(fec_data, Candidate) %>% 
    summarise(sum = sum(fec_data$Amount, na.rm = FALSE))
  data <- data.frame(labels = c("Ben Carson", "Bernie Sanders ", "Bobby Jindal", "Carly Fiorina", "Chris Christie", 
                                "Donald Trump", "George Pataki ", "Hillary Clinton ", "James Webb ", "Jeb Bush ",
                                "Jill Stein", "John Kasich", "Lawrence Lessig", "Lindsey Graham", "Marco Rubio",
                                "Martin O'Malley", "Mike Huckabee", "Rand Paul", "Rick Perry", "Rick Santorum", 
                                "Scott Walker", "Ted Cruz"),
                     
                     values = c(53194648.6, 80671666.3, 1413192.0, 8276537.4, 7124343.0, 
                                24546733.4, 515708.9, 95749026.5, 498443.5, 30447823.1,
                                253155.8, 7029369.6, 437679.2, 5223487.8, 31531465.9,
                                5306623.7, 4497219.3, 11164024.1, 2016483.4, 1324659.0, 
                                10164863.3, 40600617.3))
  
  plot_ly(data,labels = labels, values = values, 
          type = "pie") %>% 
    layout(title = "2016 Campaign:Amount Donated") 
}

