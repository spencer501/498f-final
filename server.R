#########################################
# `server.R`
# Handles the backend of the shiny app
#########################################

# Needed libraries
library(plotly)
library(shiny)
library(leaflet)

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
  
  # Bar chart of transactions by state for a given candidate
  output$bar_state_transactions <- renderPlotly({
     fec_data %>% finance_for(input$slctbx_candidate) %>% summary_for() %>%
        bar_state_transactions()
  })
  
  #Table of general summary information for a candidate
  output$summary_table <- renderDataTable(
      fec_data %>% finance_for(input$slctbx_candidate) %>% summary_for()
  )
  output$mymap <- renderLeaflet({
    # group by city
    spending_by_city <- function(spending_data) {
      return_data <- spending_data %>%
        filter(!is.na(Lat)) %>% 
        group_by(Candidate, City) %>% 
        summarise(total = sum(Amount),
                  lat = Lat[1],
                  lng = Lng[1])
      
      return(return_data)
    }
    city_loc <- fec_data %>% finance_for(input$slctbx_candidate) %>% spending_by_city()
    leaflet(data = city_loc) %>% 
      addTiles() %>% 
      addMarkers(lng = city_loc$lng, lat = city_loc$lat, popup = paste0(city_loc$City, ": $", city_loc$total))
  })

})