

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction of chicken weight"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Prediction of the chicken's weights considering diet and time"),
      helpText("Parameters:"),
       sliderInput(inputId = "inTime",
                  label =  "Time:",
                   min = 0,
                   max = 21,
                   value = 21,
                  step = 1),
      radioButtons(inputId = "inDiet",
                   label = "Chicken's Diet type: ",
                   choices = c("Diet1"="1", "Diet2"="2"),
                   inline = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("pText"),
      htmlOutput("pred"),
      plotOutput("Plot", width = "50%")
    )
  )
))
