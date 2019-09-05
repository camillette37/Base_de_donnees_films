library(shinydashboard)  
library(shiny)
library(dplyr)
library(readr)
library ( DT ) 

ui <- fluidPage(
  
  # Application title
  titlePanel("MEDIATHEQUE"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      uiOutput("choix_periode"),
      uiOutput("choix_film"),
      uiOutput("choix_realisateur")
    ),
    
    mainPanel(
      #   h4('style du film:'), #Mes villes sélectionnées sont 
      #    verbatimTextOutput("sel_film"), #sel_ville
      # # #dataTableOutput("df_output"),
      # # 
      #   h4('quel realisateur:'), #la periode sélectionnées sont 
      #   verbatimTextOutput("sel_realisateur"), #sel_ville
        dataTableOutput("df_output")
      # 
    )
    )
  )


server <- function(input, output, session) {
  
  df_people <- reactive({
    df_people <- read.csv2(file="/home/ca/Téléchargements/FILM.csv", header=FALSE,sep=',')
    colnames(df_people) <- c("H","title","année","realisateur","producteur","studio","genre")
    df_people <- df_people[-1, ]
    df_people$année <- as.numeric(as.character(df_people$année))
    df_people
  })
  output$choix_periode <- renderUI({
    liste_année <- unique(df_people()$année)
    
    # Create the checkboxes and select them all by default
    sliderInput("periode", "Quel periode",
                min = 1900, 
                max = 2000, 
                value = c(1930, 1950))
    
    
  })
  
  output$choix_film <- renderUI({
    liste_genre <- unique(df_people()$genre)
    
    # Create the checkboxes and select them all by default
    selectizeInput("film", "Quel genre?",
                   choices  = liste_genre,
                   multiple = FALSE
    )     
  })
  output$choix_realisateur <- renderUI({
    liste_realisateur <- unique(df_people()$realisateur)
    
    # Create the checkboxes and select them all by default
    selectizeInput("realisateur", "Quel realisateur?",
                   choices  = liste_realisateur,
                   multiple = FALSE)
  })
  output$df_output <- renderDataTable({
    df_people() %>%
      dplyr::filter(année >= input$periode[1] & année <= input$periode[2],
        genre %in% input$film,
         realisateur%in%input$realisateur)
  })
    options = list(pageLength = 10,
                   autoWidth = TRUE,
                   columnDefs = list(list(width = '100px', targets = "_all")))
  
  
  # On recupere la selection du film
  #output$sel_film <- renderText(
  #  input$film
  
  
}


shinyApp(ui = ui, server = server)     



