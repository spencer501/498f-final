#########################################
# `server.R`
# Handles the backend of the shiny app
#########################################

# Needed libraries
library(plotly)
library(shiny)

source("scripts/analysis.R")
source("scripts/pie_chart.R")
source("scripts/spending_v_time_graph.R")

shinyServer(function(input, output) {
   
  # Created pie chart for total amount donated for all candidate
  output$pie_chart <- renderPlotly({
     fec_data %>% still_running() %>% total_spending_of() %>% tot_expense()  
  })
  
  # graph spending over time for all candidates
  output$spending_v_time <- renderPlotly({
     fec_data %>% still_running() %>% spending_by_date_for() %>% spending_v_time()
        
  })
  
  


})