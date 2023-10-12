library(shiny)
library(shinyjs)
library(leaflet)
library(shinycustomloader)

ui <- fluidPage(
  useShinyjs(),  # Enable the use of shinyjs
  
  navbarPage(
    title = "Nematode and Vector Genomics Lab | La Trobe University, Australia",
    id = "nav",
    
    header = fluidRow(
      column(
        width = 2,  # Adjust the width as needed
        img(src = "your_logo.png", width = "50%")  # Adjust the image file path and size
      )
    ),
    tabPanel(
      title = "Upload data",
      
      fluidRow(
        column(
          width = 12,
          wellPanel(
            p("You can use this app to map GPS coordinates from a spreadsheet."),
            p("Please download and complete a copy of the map-gps.xlsx file."),
            p("When finished, upload your file and click continue. Your file will be checked for errors."),
            
            div(
              "NOTE: The longitude and latitude must be in the decimal format (e.g. -37.123456, 145.123456); not in degrees or UTM.",
              style = "color: red; font-weight: bold;"
            )
          )
        )
      ),
      
      fluidRow(
        column(
          width = 6,
          wellPanel(
            downloadButton("download_map_gps_template", "Download template", class = "btn-primary"),
            br(),
            br(),
            fileInput("uploaded_map_gps_data", label = "Upload your GPS data")
          )
        )
      ),
      
      fluidRow(
        column(
          width = 12,
          actionButton("map_data", "Map GPS coordinates", class = "btn-primary", width = "100%")
        )
      ),
      
      fluidRow(
        column(
          width = 12,
          withLoader(leafletOutput("gps_map", width = "100%", height = 600))
        )
      )
    )
  )
)
