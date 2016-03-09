#########################################
# `iu.R`
# Builds the interface for the shiny app
#########################################

# Needed libraries
library(shiny)

# Source files
source("scripts/analysis.R")

# Create UI
shinyUI(fluidPage(
   # Title of UI
   titlePanel("2016 Presidential Campaign Spending"),
   
   # Create Sidebar Layout
   sidebarLayout(
      
      # Inputs
      sidebarPanel(
         # show only currently running candidates
         checkboxInput("ckbx_running", label = "Display only currently running candidates:", value = FALSE),
         
         # choose candidate
         selectInput("slctbx_candidate", label = "Candidate:",
                     choices = unique(fec_data$Candidate),
                     selected = unique(fec_data$Candidate)[1]
                     ),
         
         # spending range
         sliderInput("sldr_amount", label = "Amount Range:",
                     min = -3000.00, 
                     max = 700000.00,
                     value = c(-3000.00, 700000.00),
                     step = 10000
                     )
         
         
      ),
      
      # Display outputs
      mainPanel(
         tabsetPanel(type = "tabs",
                     tabPanel("Summary"),
                     tabPanel("Travel"), 
                     tabPanel("Expense Summary"), 
                     tabPanel("Table")
         )
      )
   )
   
))