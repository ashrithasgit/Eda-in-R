library(shiny)


ui <- fluidPage(
  
  
  titlePanel("Exploratory Data Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Upload your dataset:",
                accept = c(".csv", ".xlsx")),
      tags$hr(),
      checkboxInput("header", "Header", TRUE),
      selectInput("xvar", "Select X Variable for Plot:", choices = NULL),
      selectInput("yvar", "Select Y Variable for Plot:", choices = NULL),
      actionButton("goButton", "Generate EDA"),
      tags$hr()
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data Preview", dataTableOutput("table")),
        tabPanel("Summary Statistics", verbatimTextOutput("summary")),
        tabPanel("Visualizations", plotOutput("distPlot"), plotOutput("scatterPlot"))
      )
    )
  )
)
