#########################################
# `iu.R`
# Builds the interface for the shiny app
#########################################

# Needed libraries
library(shiny)

# Source files
source("scripts/analysis.R")

# Create UI
shinyUI(
   navbarPage(
      
      # Title of UI
      strong("2016 Presidential Campaign Spending"),
   
      # Intro tab
      tabPanel("Intro"),
   
      # Individual data
      tabPanel("Individual Information",
               
         # Create Sidebar Layout
         sidebarLayout(
            # Inputs
            sidebarPanel(
               # show only currently running candidates
               checkboxInput("ckbx_running", label = "Display only currently running candidates:", value = FALSE),
               
               # choose candidate
               selectInput(
                  "slctbx_candidate",
                  label = "Candidate:",
                  choices = unique(fec_data$Candidate),
                  selected = unique(fec_data$Candidate)[1]
               ),
               
               # spending range
               numericInput("min_range", label = "Minimum value", value = -3000.00),
               numericInput("max_range", label = "Max value", value = 700000.00)
            ),
            
            # Display outputs
            mainPanel(
               tabsetPanel(
                  type = "tabs",
                  tabPanel("Summary"),
                  tabPanel("Travel"),
                  tabPanel("Expense Summary"),
                  tabPanel("Table")
               )
            )
         ) # close sidebarLayout
      ), # end `individual data` tabpanel
      
      # group data
      tabPanel("Group Information",
         
         # Create navigation panel
         navlistPanel(
            
            tabPanel("Pie Chart",
                     plotlyOutput("chart")),
            tabPanel("Spending over time")
         ) # end navigation panel
      ) # end group data
   ) # end navbarPage
) # end shinyUI