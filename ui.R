ptData <- read.csv("www/ptData_1.csv", header=TRUE, na.strings = "NA")
dataset <- ptData
shinyUI(
    navbarPage("Clinical Data Explorer",
             tabPanel(
               "Overview",
               sidebarLayout(
                 sidebarPanel(
p("This web APP built using Shiny",a("Shiny",href="http://www.rstudio.com/shiny"),"(a web application framework for R). "),
 p("This APP uses a .csv dataset which simulates a selected set of patient data values from a group of fictitious clinics. "),
p("The purpose of this project is to serve as a proof of concept to show doctors and clinical scientists differnt ways data can be viewed dynamically "),
p("The present page represents a summary of the dataset while the other two pages provide different views of the data "),
"Choose a Tab"
                   #selectizeInput(
                    # 'id', label="Year", choices=NULL, multiple=F, selected="X2015",
                    # options = list(create = TRUE,placeholder = 'Choose the year')
                  # ),
                  
                  # radioButtons("radio", label = h3("Radio buttons"),
                    #            choices = list("Choice 1" = 1, "Choice 2" = 2)
                   #)
                 ),
                 mainPanel( "Summary", verbatimTextOutput("summary") )
               )
             ),
             tabPanel(
"Age Range",
sidebarLayout(
    sidebarPanel(
      p("Use the slider to select the number categories or bins to divide patient age into "),
      p("Then observe how the associated wellbeing scores are distributed "),
      sliderInput("bins",
                  "Number of bins:",
                  min = 4,
                  max = 20,
                  value = 10)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("agePlot")
    )
  )


),
             tabPanel(
"Dynamic Data Views",
  
sidebarPanel(
p("Use the slider to select the number of observations (more useful in a bigger dataset)"),
      p("Then choose variables and experiment with the other controls "),
    

sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value= 50, round=0),

    selectInput('x', 'X axis', names(dataset)),
    selectInput('y', 'Y axis', names(dataset), names(dataset)[[2]]),
    #selectInput('color', 'Color', c('None', names(dataset))),

    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),

    selectInput('facet_row', 'Y sub-category', c(None='.', names(dataset))),
    selectInput('facet_col', 'X sub-category', c(None='.', names(dataset)))
  ),

  mainPanel(
    plotOutput('plot')
  )
)


  )
)
