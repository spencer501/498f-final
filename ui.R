#########################################
# `iu.R`
# Builds the interface for the shiny app
#########################################

# Needed libraries
library(shiny)

# Create UI
shinyUI(fluidPage(
   # Title of UI
   titlePanel("2016 Presidential Campaign Spending"),
   
   # Create Sidebar Layout
   sidebarLayout(
      
      # Inputs
      sidebarPanel(
         # show only currently running candidates
         checkboxInput("ckbx_running", label = "Display only currently running candidates:", value = TRUE),
         
         # choose candidate
         selectInput("slctbx_candidate", label = "Candidate",
                     choices = c("a", "b", "c", "d"),
                     selected = "a"
                     ),
         
         # spending range
         sliderInput("sldr_amount", label = "Amount Range",
                     min = -3000.00, 
                     max = 700000.00,
                     value = c(-3000.00, 700000.00),
                     step = 10000)
         
         
      ),
      
      # Display outputs
      mainPanel(
         tabsetPanel(type = "tabs", 
                     tabPanel("Plot"), 
                     tabPanel("Summary"), 
                     tabPanel("Table")
         )
      )
   )
   
))