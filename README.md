
# **Final Project**
Members: Fion, Jared, and Spencer
Section: FB

## **Introduction** 

For our final project for INFO 498F, we are looking at the 2016 Presidential Campaign Finance Expenditure Data. This dataset was collected by the Federal Election Commission (FEC), which is an independent regulatory agency that discloses campaign finance information, contributions, and public funding for Presidential elections. This dataset includes the name of the candidates running, the amount of expenses, the date and location (city, state, zip, longitude, and latitude) of the transactions, and the category of expenses. Additionally, more information about the dataset can be found via this [link](http://www.fec.gov/disclosurep/pnational.do).


Specifically, we are reading in reformatted version of a CSV filIn our project, we will be summarizing financial information disclosed by presidential candidates who has reported at least $100,000 in contributions from individuals other than the candidate. Our main target audience is the general public who are interested in presidential campaign finances. However, other audiences may include other candidates, different interest groups, voters, donors, etc. who are interested in the expenditures of the candidates. e that contains the 2016 Presidential Campaign Finance (with the information listed previously). To display the data, we have created a Shiny app that allows the user to change how the data is displayed through interactive visualizations. 


**Individual Information**: On the left, the user can select "Display only currently running candidates" and a select box for "Cadidate" names.The summary table shows a summary of the dataset (candidate, state, expense, etc.).From the summary table, state expenses, and state transactions graphs we hope to answer the minimum and maximum expenses, biggest reciepient, highest state expenses, amount of transactions per state, etc. for each candidate. The map shows the spending by city for each candidate. 
 

**Group Information**: On the left, you can select the pie chart or the spending over time. For the pie chart, the user is able to see the total amount of expense of each candidate. They can also compare the information as well as remove one or more candidates from the chart (by clicking the candidate's name. For the graph you can see the candidate's spending over time. If you hover over each point you can see the amount spent, in millions, for each candidate from Jan 2015 to Jan 2016. 


**Additional Information**: For the technical aspect of our project, we used Shiny(for visualization), plotly(for visualization), dplyr(for data manipulation), and lubridate (for working with dates) libraries.


