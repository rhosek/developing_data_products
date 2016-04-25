
library(shiny)
library(ggplot2)
ptData <- read.csv("www/ptData_1.csv", header=TRUE, na.strings = "NA")
dataset <- ptData
function(input, output) {


output$summary<-renderPrint(
            
            str(ptData))

output$agePlot <- renderPlot({
    
  y1 <-  cut(ptData[,1], b = input$bins)
 

	plot(ptData[,3]~y1, xlab="Age", ylab="Wellbeing", las=2)
  })

dataset <- reactive({
   ptData[sample(nrow(ptData), input$sampleSize),]
  })

  output$plot <- renderPlot({

    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()

    #if (input$color != 'None')
     # p <- p + aes_string(color=input$color)

    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)

    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
p <- p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    print(p)

  }, height=700)

}
