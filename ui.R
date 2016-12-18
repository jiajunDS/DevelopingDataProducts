library(shiny)

shinyUI(fluidPage(
  
  # title
  titlePanel("Stock Price Chart"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      # set stock ticker symbol
      textInput("ID_text", 
                label = h4("Ticker Symbol"), 
                value = "GOOG"),
      helpText("Stock ticker symbol is available in Google Finance"),
      
      # select date range
      dateRangeInput("dates", 
                     label = h4("Start Date to End Date"),
                     start="2014-04-01",
                     end=Sys.Date()),
      helpText("Select date range"),
      
      # select MA
      checkboxGroupInput("ma", label = h4("Moving Average Line Period"), 
                         choices = list("10 day" = 1, "20 day" = 2, "50 day" = 3, "100 day" = 4, "200 day"= 5),
                         selected = 1),
      
      # select indicator
      selectInput("ta", label = h4("Additional Indicator"), 
                  choices = list("RSI" = 1, "BB" = 2, "MACD" = 3, "SMI" = 4), 
                  selected = 1),
      helpText("Select technical indicator"),
      
      # select sidebar layout size
      width=3
      
    ),
    
    # show chart and HTML
    mainPanel(
      tabsetPanel(
        
        # show chart 
        tabPanel(
          "Chart",plotOutput("Plot",, width = "100%", height = "500px")
        ),
        
        # show HTML
        tabPanel("Documentation",
                 includeHTML("ShinyWithoutSlidify.html")
        )
      ),
      # select sidebar layout size
      width = 8
    )
  )
))
