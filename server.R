library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(readxl)


server <- function(input, output, session) {
  
  
  data <- reactive({
    req(input$file1)
    ext <- tools::file_ext(input$file1$name)
    
    if (ext == "csv") {
      read.csv(input$file1$datapath, header = input$header)
    } else if (ext == "xlsx") {
      readxl::read_excel(input$file1$datapath)
    }
  })
  
  
  observe({
    req(data())
    updateSelectInput(session, "xvar", choices = colnames(data()))
    updateSelectInput(session, "yvar", choices = colnames(data()))
  })
  
  
  output$table <- renderDT({
    req(data())
    datatable(data(), options = list(pageLength = 5))
  })
  
  
  output$summary <- renderPrint({
    req(data())
    summary(data())
  })
  
  
  output$distPlot <- renderPlot({
    req(data())
    df <- data()
    
   
    if (length(input$xvar) > 0) {
      ggplot(df, aes_string(x = input$xvar)) +
        geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7) +
        theme_minimal() +
        labs(title = paste("Distribution of", input$xvar), x = input$xvar, y = "Frequency")
    }
  })
  
 
  output$scatterPlot <- renderPlot({
    req(data())
    
    if (input$goButton > 0) {
      df <- data()
      ggplot(df, aes_string(x = input$xvar, y = input$yvar)) +
        geom_point(color = "red") +
        theme_minimal() +
        labs(title = paste("Scatter Plot of", input$xvar, "vs", input$yvar), x = input$xvar, y = input$yvar)
    }
  })
}



