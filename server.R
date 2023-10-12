library(shiny)
library(leaflet)
library(tidyverse)
library(readxl)
library(writexl)

server <- function(input, output, session){
  
  uploaded_map_gps_data <- eventReactive(c(input$uploaded_map_gps_data),
                                         {
                                           map_gps_data <- read_excel(input$uploaded_map_gps_data$datapath)
                                           map_gps_data
                                           })

  output$download_map_gps_template <- downloadHandler(
    filename = function(){
      paste0(Sys.Date(), "_map_gps_template.xlsx")
    },
    content = function(file){
      file.copy("data/map_gps_template.xlsx", file)
    }
  )
  
  # Event handler for the "Map Data" button
  observeEvent(input$map_data, {
    output$gps_map <- renderLeaflet({
      map_data <- uploaded_map_gps_data()
      
      validate(need(!is.null(map_data), "Please enter GPS coordinates."))
      
      leaflet() %>%
        addTiles() %>%
        addMarkers(data = map_data,
                   lng = ~Longitude,
                   lat = ~Latitude,
                   popup = ~paste("Longitude: ", Longitude, "<br>",
                                  "Latitude: ", Latitude, "<br>",
                                  "Location: ", Location))
    })
  })
  
}
