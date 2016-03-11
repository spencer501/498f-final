#########################################
# `server.R`
# Handles the backend of the shiny app
#########################################

# Needed libraries
library(plotly)
library(shiny)

# Source files
source("scripts/analysis.R")
source("scripts/pie_chart.R")
source("scripts/spending_v_time_graph.R")
source("scripts/bar_chart.R")

shinyServer(function(input, output) {
   
  # Create pie chart for total amount donated for all candidates
  output$pie_chart <- renderPlotly({
     fec_data %>% still_running() %>% total_spending_of() %>% tot_expense()  
  })
  
  # Graph of spending over time for all candidates
  output$spending_v_time <- renderPlotly({
     fec_data %>% still_running() %>% spending_by_date_for() %>% 
        spending_v_time()
        
  })
  
  # Bar chart of spending by state for a given candidate
  output$bar_state_spending <- renderPlotly({
     fec_data %>% finance_for(input$slctbx_candidate) %>% summary_for() %>%
        bar_state_spending()
  })
  


})