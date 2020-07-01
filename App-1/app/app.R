# install.packages('rvest')
# install.packages("rcorpora")
# install.packages("radlibs")
# install.packages("stringr")
# install.packages("spacyr")
# install.packages("rlist")
# install.packages("qdapDictionaries")
# 
# library('rvest')
# library('stringr')
# library('spacyr')
# library('purrr')
# library('xml2')
# library('dplyr')
# library('rcorpora')
# library('radlibs')
# library('rlist')
# library('qdapDictionaries')
library(shiny)

# Define UI ----
ui <- fluidPage(
    titlePanel("The MisInfo Bot"),
    
    sidebarLayout(
        sidebarPanel(
            h2("Transformation Info:"),
            textInput("url", h3("Copy and Paste URL Here:"), value = "Enter URL...") ,
            sliderInput("iterations", 
                        h3("# of Iterations to Complete"),
                        min = 5, max = 500, value = 100),
            textOutput("selected_iterations"),
            radioButtons("changes_display", h3("Display the Changes Made in a List"),
                         choices = list("Yes" = 1, "No" = 2),
                                        selected = 1),
            radioButtons("changes_bolded", h3("Bold the Changes Made in the New Article"),
                         choices = list("Yes" = 1, "No" = 2), 
                         selected = 1),
        ),
        
        mainPanel(h2("Original article will be displayed here, we could also attach a specific article here if that's
                     the route we want to follow:"),
                  a('https://www.nature.com/articles/d41586-018-06215-5/'),
                  p('This is where the text of the original article will be displayed'),
                  br(),
                  h2("The newly changed article will be displayed here:"),
                  p(text),
                  br(),
                  )
    )
)     

# Define server logic ----
server <- function(input, output) {
    output$selected_iterations <- renderText({ 
        paste("You have selected", input$iterations, "iterations")
    })
    
}

# Run the app ----
shinyApp(ui = ui, server = server)





