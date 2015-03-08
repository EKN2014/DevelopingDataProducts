###################################################################### 
## FileName: ui.R 
## Author: Elizabeth 
## Date: 3rd March 2015.
##
## Description:  This page shows the birth weight prediction based on selected variables.
##               These variables were selected using stepwise regression
##      INPUT: Variables selected by stepwise regression were 
##          1)  low - indicator of birth weight less than 2.5 kg,  
##          2)  race- race of the mother, 
##          3)  smoke - smoking status during pregnancy
##          4)  ui - presence of uterine irritability
##          5)  age - age was not selected by stepwise regression but i thought it was 
##                    would be important in predicting a child's weight at birth
##
##       
##      OUTPUT: 
##          bwt = birth weight of the child in grams 
###################################################################### 

library(shiny)
data(birthwt)

shinyUI(pageWithSidebar(
       headerPanel("Predicting Weight of Children at Birth"),
       sidebarPanel( 
        
        h3 ("Enter Predicting Variables"), 
        sliderInput("inputage","Mother's age in years", min = 16,
                    max=50, value = 16,step =1),
        selectInput("inputrace", "Mother's race (1 = white, 2 = black, 3 = other)",
                     c("1","2","3")),
        selectInput("inputsmoke", "Smoking status during pregnancy",
                     c("0","1")),
        selectInput("inputui", "Presence of uterine irritability",
                     c("0","1")),
        selectInput("inputlow", "Indicator of birth weight less than 2.5 kg",
                    c("0","1"))
),
        
mainPanel( 
                h3 ("You selected"),
                h4 ("Age of mother is"),
                verbatimTextOutput("oage"),
                h4("Race of mother is"), 
                verbatimTextOutput("orace"), 
                h4("Is mother smoking or not"), 
                verbatimTextOutput("osmoke"),
                h4("Did the mother have uterine irritability or not"), 
                verbatimTextOutput("oui"),
                h4("Anything to show lpossibility of low birth weight"), 
                verbatimTextOutput("low"),
                h4("================================="),
                h3 ("Birth Weight Predicted in grams"), 
                h4("================================="), 
                verbatimTextOutput("obwt")

                ) 
    )) 


        