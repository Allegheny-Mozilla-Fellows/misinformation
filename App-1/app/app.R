library(shiny)

# p("p creates a paragraph of text."),
# p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
# strong("strong() makes bold text."),
# em("em() creates italicized (i.e, emphasized) text."),
# br(),
# code("code displays your text similar to computer code"),
# div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
# br(),
# p("span does the same thing as div, but it works with",
#   span("groups of words", style = "color:blue"),
#   "that appear inside a paragraph.")

# Define UI ----
ui <- fluidPage(
    titlePanel("The MisInfo Bot"),
    
    sidebarLayout(
        sidebarPanel(
            h2("Transformation Info:"),
            fileInput("file", h3("CSV File Input")),
            sliderInput("slider", 
                        h3("# of Iterations to Complete"),
                        min = 5, max = 30, value = 10),
            textOutput("selected_iterations")
        ),
        
        mainPanel(h2("Article will be displayed here"))
    )
)     

# Define server logic ----
server <- function(input, output) {
    output$selected_iterations <- renderText({ 
        paste("You have selected", input$slider, "iterations")
    })
    
}

# Run the app ----
shinyApp(ui = ui, server = server)





