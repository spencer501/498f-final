#########################################
# `server.R`
# Handles the backend of the shiny app
#########################################

# Needed libraries
library(plotly)
library(shiny)

source("scripts/pie_chart.R")

shinyServer(function(input, output) {
  # Created pie chart for total amount donated for each candidate
  output$chart <- renderPlotly({
    tot_expense(expense_data)  
  })
  


})