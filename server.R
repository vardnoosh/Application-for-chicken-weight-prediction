

library(shiny)
data("ChickWeight")
library(dplyr)
library(ggplot2)

# linear model
dt <- ChickWeight[ChickWeight$Diet == c("1","2"),]
model1 <- lm(weight ~ Time + Diet , data=dt)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$pText <- renderText({
    paste("Time",
          strong(round(input$inTime, 1)),
           " then:" )
    })

  output$pred <- renderText({
    df <- data.frame(Time=input$inTime,
                     
                     Diet=factor(input$inDiet, levels=levels(dt$Diet)))
    ch <- predict(model1, newdata=df)
    kid <- ifelse(
      input$inDiet=="1","Diet1","Diet2")
    paste0(em(strong(kid)),
           "'s predicted weight is going to be around", em(strong(round(ch))),
           " gm"
    )
  })
 output$Plot <- renderPlot({
            kid <- ifelse(
          input$inDiet=="1","Diet1","Diet2")  
            df <- data.frame(Time=input$inTime,
                             
          Diet=factor(input$inDiet, levels=levels(dt$Diet)))
          ch <- predict(model1, newdata=df)
          yvals <- c("Time", kid)
          df <- data.frame(
          x = factor(yvals, levels = yvals, ordered = TRUE),
          y = c(input$inTime, ch))
          ggplot(df, aes(x=x, y=y, color=c("red", "green"), fill=c("red", "green"))) +
          geom_bar(stat="identity", width=0.5) +
          xlab("") +
          ylab("Weight (gm)") +
          theme_minimal() +
          theme(legend.position="none")
  })
})