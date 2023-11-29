# shiny_app.R

library(shiny)
library(ggplot2)
library(ggstar)
library(dplyr)

# Define UI
ui <- fluidPage(
  titlePanel("Overview of Dataset by Genre"),
  
  sidebarLayout(
    sidebarPanel(
      # Dropdown to select the dataset
      selectInput("dataset", "Select Dataset", choices = c("Spotify Songs")),
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overall Popularity", img(src = "overall_popularity_plot.png", width = 800, height = 600)),
        tabPanel("Subgenre Counts", downloadButton("download_table", "Download Subgenre Counts Table")),
        tabPanel("Subgenre Popularity", img(src = "combined_plot.png", width = 800, height = 600))
        )
      )
    )
  )

# Define server
server <- function(input, output) {
  
  selected_dataset <- reactive({

    return(paste("Selected Dataset: ", input$dataset))
  })
  
  # Generate the subgenre count table
  output$download_table <- downloadHandler(
    filename = function() {
      paste("subgenre_count_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(subgenre_count, file, row.names = FALSE)
    }
  )
}

# Run the Shiny app
shinyApp(ui, server)