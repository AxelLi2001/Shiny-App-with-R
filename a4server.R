cdata <- read.csv("https://raw.githubusercontent.com/owid/co2-data/b22808a6d039e281a360f9dd40bebbae8ea8475c/owid-co2-data.csv")

server <- function(input, output) {
  output$line_year <- renderPlotly({
    plot_data <- cdata %>% 
      filter(year <= input$year_range[2],
             year >= input$year_range[1]) %>% 
      filter(country %in% input$country)

    
    plot1 <- ggplot(plot_data) +
      geom_line(aes(x = year, y = co2_per_capita), 
                color = "green", size = 1) +
      geom_point(aes(x = year, y = co2_per_capita), 
                color = "orange", size = 1) +
      labs(x = "Year", y = "CO2 Emission Per Capita",
           title = paste("CO2 Emission Per Capita in", input$country,
             input$year_range[1], "to", input$year_range[2]))
      
    plot1 <- ggplotly(plot1)
    
    return(plot1)
  })
  

}