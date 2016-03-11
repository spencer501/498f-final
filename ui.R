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
      tabPanel("Intro",
               h1("Project Description"),
               h3("Team Members: Fion, Jared, and Spencer"),
               br(),
               p("For our final project for INFO 498F, we are looking at the 2016 Presidential 
                 Campaign Finance Expenditure Data. This dataset was collected by the Federal
                 Election Commission (FEC), which is an independent regulatory agency that 
                 discloses campaign finance information, contributions, and public funding for
                 Presidential elections. This dataset includes the name of the candidates running,
                 the amount of expenses, the date and location (city, state, zip, longitude, and 
                 latitude) of the transactions, and the category of expenses. Additionally, more 
                 information about the dataset can be found via this link: 
                 http://www.fec.gov/disclosurep/pnational.do."),
               br(),
               p("In our project, we will be summarizing financial information disclosed by presidential
                 candidates who has reported at least $100,000 in contributions from individuals other 
                 than the candidate. Our main target audience is the general public who are interested in 
                 presidential campaign finances. However, other audiences may include other candidates, 
                 different interest groups, voters, donors, etc. who are interested in the expenditures 
                 of the candidates. ")),
   
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
            
            # Pie chart
            tabPanel("Pie Chart",
                     plotlyOutput("chart")
            ),
            
            tabPanel("Spending over time")
         ) # end navigation panel
      ) # end group data
   ) # end navbarPage
) # end shinyUI