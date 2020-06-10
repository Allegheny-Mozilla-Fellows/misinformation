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
            fileInput("file", h3("File input")),
            sliderInput("slider", h3("# of Iterations to Complete"),
                        min = 5, max = 30, value = 10)
        ),
        
        mainPanel(h2("Article will be displayed here"))
    )
)     

# Define server logic ----
server <- function(input, output) {
    
}

# Run the app ----
shinyApp(ui = ui, server = server)







# # Define UI for data upload app ----
# ui <- fluidPage(
#     
#     # App title ----
#     titlePanel("Uploading Files"),
#     
#     # Sidebar layout with input and output definitions ----
#     sidebarLayout(
#         
#         # Sidebar panel for inputs ----
#         sidebarPanel(
#             
#             # Input: Select a file ----
#             fileInput("file1", "Choose CSV File",
#                       multiple = TRUE,
#                       accept = c("text/csv",
#                                  "text/comma-separated-values,text/plain",
#                                  ".csv")),
#             
#             # Horizontal line ----
#             tags$hr(),
#             
#             # Input: Checkbox if file has header ----
#             checkboxInput("header", "Header", TRUE),
#             
#             # Input: Select separator ----
#             radioButtons("sep", "Separator",
#                          choices = c(Comma = ",",
#                                      Semicolon = ";",
#                                      Tab = "\t"),
#                          selected = ","),
#             
#             # Input: Select quotes ----
#             radioButtons("quote", "Quote",
#                          choices = c(None = "",
#                                      "Double Quote" = '"',
#                                      "Single Quote" = "'"),
#                          selected = '"'),
#             
#             # Horizontal line ----
#             tags$hr(),
#             
#             # Input: Select number of rows to display ----
#             radioButtons("disp", "Display",
#                          choices = c(Head = "head",
#                                      All = "all"),
#                          selected = "head")
#             
#         ),
#         
#         # Main panel for displaying outputs ----
#         mainPanel(
#             
#             # Output: Data file ----
#             tableOutput("contents")
#             
#         )
#         
#     )
# )
# 
# # Define server logic to read selected file ----
# server <- function(input, output) {
#     
#     output$contents <- renderTable({
#         
#         # input$file1 will be NULL initially. After the user selects
#         # and uploads a file, head of that data file by default,
#         # or all rows if selected, will be shown.
#         
#         req(input$file1)
#         
#         df <- read.csv(input$file1$datapath,
#                        header = input$header,
#                        sep = input$sep,
#                        quote = input$quote)
#         
#         if(input$disp == "head") {
#             return(head(df))
#         }
#         else {
#             return(df)
#         }
#         
#     })
#     
# }
# 
# # Create Shiny app ----
# shinyApp(ui, server)