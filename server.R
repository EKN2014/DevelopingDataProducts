###################################################################### 
## FileName: server.R 
## Author: Elizabeth 
## Date: 3rd March 2015. 
## 
##  Description: The server side code the computes bwt prediction. 
## 
##      'birthwt' data set is used to create a 'LM' model based on the selected 
##      predictors. These predictors were selected using stepwise regression
##      The selected predictors are - low, race, smoke, ui. Age was however 
##      used in the model because the author thought it was important in predicting
##      birthweight of children. Very young women are more likely to get children
##      with low birth weight.  
## 
##  Computations Performed in this page: 
##      1) Using as.factor to convert 0, 1 variables
##      5) Using the LM model to predict the bwt. 
## 
###################################################################### 

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

