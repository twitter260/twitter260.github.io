
##SERVER
# Define server logic required to draw a wordcloud
server <- function(input, output){
  
  
  time <- reactive({
    cloud[which(input$minute == cloud$minute & input$hour == cloud$hour & input$day == cloud$day),]
  })
  
  wordcloud_rep <- repeatable(wordcloud)
  
  
  output$wordcloud <- renderPlot({
    
    times <- time()
    # draw the word cloud
    wordcloud_rep(words = times$word, freq = times$n, scale = c(5,.6), 
                  min.freq = 1,
                  max.words=input$maxwords, random.order=FALSE,
                  random.color = FALSE,
                  rot.per=0.35, ordered.colors=TRUE,
                  colors=pal(11)[factor(times$score)])
  })
}
