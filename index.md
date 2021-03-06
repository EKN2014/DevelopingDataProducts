---
title       : Exploring determinants of low birth weight among children 
author      : Elizabeth

---

Predicting the value of mpg for cars

In this project, I am studying determinants of birth weight among children. The dataset used is an R dataset, birthwt. The data set is used to create a 'LM' model based on the selected predictors. These predictors were selected using stepwise regression. The selected predictors are - low, race, smoke, ui. Age was however used in the model because the author thought it was important in predicting birthweight of children. Very young women are more likely to get children with low birth weight.

Outline of this pitch
.server.R
.ui.R
.Output

---  

Computation

After loading the data set, i built the regression model using bwt as the outcome variable and low, race, ui, age and smoke as predictor variables 


```r
library(MASS)
library(plyr)
data(birthwt)

birthwt$race <- as.factor(birthwt$race)
birthwt$smoke <- as.factor(birthwt$smoke)
birthwt$ui <- as.factor(birthwt$ui)
birthwt$low <- as.factor(birthwt$low)

fit <- lm(bwt~., data=birthwt)

step <- stepAIC(fit, direction="both")
step$anova

bestfit <- lm(bwt ~ age +  race + smoke + ui +low , data=birthwt)


predictbwt <- function(age1, race1, smoke1, ui1, low1)
{
        newdata<- data.frame(age=age1, race=race1, smoke=smoke1, ui=ui1, low=low1)
        res <-round(predict(bestfit, newdata)[[1]], 2)
        res
}
```

--- 
 
server.R

Here i assigned the input values to interactive part of the code using the shiny syntax. The user will be required to enter the values of age, low, ui, smoke and race


```r
library(shiny)
shinyServer(
        function(input, output) {
           output$oage <- renderPrint({input$inputage})
           output$orace <- renderPrint({input$inputrace})
           output$osmoke <- renderPrint({input$inputsmoke})
           output$oui <- renderPrint({input$inputui})
           output$low <- renderPrint({input$inputlow})
           output$obwt <- renderPrint({predictbwt(input$inputage,
                          input$inputrace, input$inputsmoke,input$inputui,input$inputlow)})
           
})
```

--- 

ui.R

There are five input values in server.R. The output widgets are put in the main panel. 


```r
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
```
