# Define UI for application that draws a wordcloud
ui <- fluidPage(
  
  # Application title
  titlePanel("Murfreesboro Protest: Tweet Word Frequency by Time"),
  
  # Sidebar with a slider input for time 
  sidebarLayout(
    sidebarPanel(
      radioButtons("day", "Select a Day:",
                   c("2017-10-27" = "2017-10-27",
                     "2017-10-28" = "2017-10-28",
                     "2017-10-29" = "2017-10-29")),
      sliderInput("hour",
                  "Hour:",
                  min = 0,
                  max = 23,
                  value = 0,
                  step = 1,
                  animate = 
                    animationOptions(interval = 5620, loop = T)
      ),      
      sliderInput("minute",
                  "Minute:",
                  min = 0,
                  max = 45,
                  value = 0,
                  step = 15,
                  animate = 
                    animationOptions(interval = 1500, loop = T)
      ),
      
      sliderInput("maxwords",
                  "Maximum (Most Frequent) Words:",
                  min = 1,
                  max = 50,
                  value = 50
      )
    ),
    mainPanel(
      plotOutput("wordcloud"), position = "right"
    )
  )
)
