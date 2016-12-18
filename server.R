
library(shiny)
library(quantmod)

#indicator list
moving_average_array<-c("addEMA(n=10)","addEMA(n=20)","addEMA(n=50)","addEMA(n=100)","addEMA(n=200)")
technical_indicator_array<-c("addRSI()","addBBands()","addMACD()","addSMI()")

shinyServer(function(input, output) {
  
  ta<-reactive({
    # add Volume Indicator 
    baseta<-"addVo()"
    
    #add moving average selection
    ma<-paste(moving_average_array[as.numeric(input$ma)],collapse=";")
    
    #add other indicators selection
    baseta<-paste(baseta,ma,sep=";")
    baseta<-paste0(technical_indicator_array[as.numeric(input$ta)],";",baseta)
  })
  # get stock data from yahoo finance  
  datainput<-reactive({
    
    stock <- require_symbol(input$ID_text,input$dates[1],input$dates[2],new.env())
  })
  # plot stock chart
  output$Plot <- renderPlot({
    
    chartSeries(datainput(),theme="white",type ="candlesticks", TA=ta()) 
    
  })

})
# get stock data
require_symbol <- function(symbol,start,end,envir = parent.frame()) {
  if (is.null(envir[[symbol]])) {
    envir[[symbol]] <- getSymbols(symbol,from =start,to =end, src = "google",auto.assign = FALSE)
  }
  
  envir[[symbol]]
}

