#####################################################################
# `cleaner.R`
# Contains a function that reshapes data about presidential campaign 
# finance expenditures to be more easily analyzed.
# requires a data file about candidates political parties.
# Data source: http://www.fec.gov/disclosurep/PDownload.do
# Current as of March 5, 2015
#####################################################################

# Needed libraries
library(dplyr)
library(stringr)
library(tools)


##################
## Initial data ##
##################

# source file
file_name <- 'data/2016_campaign_finances.csv'

# Read in data about the political party each candidate belongs to
cand_data <- read.csv('data/2016_candidates.csv')

# Read in data about US states
state_info <- read.csv('data/state_info.csv')

# Read in data mapping zip codes to lat/lng coordinates
zip_data <- read.csv('data/location_data.csv', stringsAsFactors = FALSE)

# read in raw data
data <- read.csv(file_name, stringsAsFactors = FALSE)


###############################
## Reshape data for analysis ##
###############################

# pick useful columns
formatted_data <- data %>%
   select(
      cand_nm,
      recipient_nm,
      disb_amt,
      disb_dt,
      recipient_city,
      recipient_st,
      recipient_zip,
      disb_desc
   ) %>%
   
   # give columns better names
   rename(
      "Candidate" = cand_nm,
      "Recipient" = recipient_nm,
      "Amount" = disb_amt,
      "Date" = disb_dt,
      "City" = recipient_city,
      "State" = recipient_st,
      "Zip" = recipient_zip,
      "Category" = disb_desc
   ) %>%
   
   # remove entries outside of the US
   filter(State %in% state_info$abbreviation) %>% 
   
   # add candidate data
   left_join(cand_data, by = "Candidate") %>%
   
   # change format of data
   mutate(
      Date = as.Date(Date, "%d-%b-%y"),
      City = str_to_title(City),
      Candidate = Popular_name,
      Zip = str_sub(Zip, 1, 5),
      Zip = as.numeric(Zip)
   ) %>% 
   
   # fix extraneous data
   # (WARNING: May not generalize to all datasets)
   filter(City != "Berlin Germany") %>% 
   filter(Date <= as.Date("2016-01-31") & Date >= as.Date("2015-01-05")) %>% 
   mutate(Zip = ifelse(Zip == 0, 20001, Zip),
          Zip = ifelse(City == "Sydney", 36117, Zip),
          Zip = ifelse(Recipient == "SP PLUS CORPORATION", 60601, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "JIMMY JOHN'S", 29201, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "TAXI-PASS", 10001, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "SERESC CONFERENCE CENTER", 3110, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "EMBASSY SUITES", 22101, Zip),
          Zip = ifelse(is.na(Zip) & Candidate == "James Webb" & City == "San Diego", 92106, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "WYNDHAM", 97201, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "HILTON NEWARK PENN STATION", 7102, Zip),
          Zip = ifelse(is.na(Zip) & Recipient == "HOLIDAY INN EXPRESS", 3101, Zip),
          Zip = ifelse(is.na(Zip) & City == "Chicago", 60612, Zip),
          
          City = ifelse(City == "" & Candidate == "Chris Christie" & State == "NH", "Manchester", City)
          ) %>%
   
   # rearrange columns
   select(1, 10:11, 2:8) %>%
   
   # add lat/lng
   left_join(select(zip_data, 
                    Zip, 
                    Lat, 
                    Lng), 
             by = "Zip") %>%
   
   # sort rows
   arrange(desc(Running), Candidate, Date, Amount, State, Category)


#########################
## Output cleaned file ##
#########################

# set output filename to be original filename with "-clean" appended
new_file_name <- paste0(file_path_sans_ext(file_name), "-clean.csv")

# write new file
write.csv(formatted_data, file = new_file_name, row.names = FALSE)
   

# #################
# ## Bug testing ##
# #################
# 
# pre_latlng <- formatted_data
# 
# bad_zip_df <- filter(formatted_data, is.na(Lat) | is.na(Lng)) %>% 
#    select(1, 4, 6:9, 11:12)
# 
# bad_zip_v <- unique(bad_zip_df$Zip)
# 
# zip_source <- unique(zip_data$Zip)


