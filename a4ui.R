# calculation
cdata <- read.csv("https://raw.githubusercontent.com/owid/co2-data/b22808a6d039e281a360f9dd40bebbae8ea8475c/owid-co2-data.csv")

country_data <- cdata %>% filter(as.numeric(year) == 2020, iso_code != "OWID_WRL")
asia_co2 <- country_data %>% filter(country == "Asia") %>% pull(share_global_co2)
china_co2 <- country_data %>% filter(country == "China") %>% pull(co2)
qatar_pcco2 <- country_data %>% filter(country == "Qatar") %>% pull(co2_per_capita)
hk_growth <- country_data %>% filter(country == "Hong Kong") %>% pull(co2_growth_prct)
tj_growth <-  country_data %>% filter(country == "Tajikistan") %>% pull(co2_growth_prct)



usable_country <- cdata %>% filter(year >= 1970, year <= 2020) %>% 
  drop_na(co2_per_capita)
country_unique <- unique(usable_country$country) 
country_check <- selectInput(inputId = "country",
                                  label = "Country",
                                  choices = country_unique)

year_slider <- sliderInput(inputId = "year_range",
                              label = "Year range(1970-2020)",
                              min = 1970,
                              max = 2020,
                              value = c(1970,2020),
                              step = 1)
explainer <- "This is an interactive line plot that allows users to pick a country, and the plot will show the per capita
co2 of the selected country between 1970-2020, a 50 year range. The country and year range can be modified. This plot is 
important since co2 per capita is the most fair variable to quantify a country's CO2 emission level. The total emission is 
more biased since the population in different country can be significantly different. Some pattern to notice is that even 
though a large amount of country had some increase on per capita CO2 emission starting around 2000, we also can notice that, 
many countries' per capita emission dropped starting around 2015, inferring they noticed climate change and made some effort 
to fight it. "
sum <- 


ui <- fluidPage(theme = bs_theme(bootswatch = "minty"),
                  h1(strong("CO2 Emission Per Capita"),
                   style = "color: Orange"),
                
  tabsetPanel(
    tabPanel("Introduction, Summary, Data",
             h1("CO2 Emission Per Capita Across the Globe", align = "center"),
             h3("Zhuoyang Li, Mar 4th 2022"),
             p("In this project, we will be working with ", tags$a(href = "https://github.com/owid/co2-data/","data on cliamte change "),
               "containing countries and areas' green house gas emission status from 1750 to 2020. In this specific project, we will only
               be looking at CO2 emission per capita across countries and areas between 1970 to 2020, a 50 year interval. Such dedicated 
               choice has serveral reasons: There are more missing data in earlier data, which could decrease users' experience when looking
               at them while they are actually missing. Also, CO2 is one of major green house gas, and per capita visualization can be more
               reliable than the total value since the total value can be impacted by population, making the total value not representative.
               Some countries are excluded in the visualization due to a complete missing data in the 50-year interval, to provide users with
               better interaction experience. Users will be able to filter a specfic a country and a range of years to look at."),
             p(""),
             p("As their mission was to make data and research on the world's largest problems understandable and accessible, this dataset was 
               collected, aggregated, and documented by Hannah Ritchie, Max Roser, Edouard Mathieu, Bobbie Macdonald and Pablo Rosado.
               This dataset is a collection of key metrics maintained by *Our World in Data*, sourced from various places such as 
               *the Global Carbon Project* and *the Climate Watch Portal*. It includes green house gas emission data of various kinds in
               terms of many countries and areas, as well as the world. The time interval is from 1750 to 2020, while ealier years tend to
               contain more missing data. In total, there are 25191 observations and 60 variables in the dataset. There are also some limitations 
               with this dataset. First, although they explain the variable 'country'
               in their codebook as areas instead of actual countries, it can be confusing when people see some areas like Asia, Africa, Hongkong
               under the variable named 'country', as they are obviously not countries. Also, most of the columns are on CO2, while other gases
                like mathane are not analyzed so precisely, but those gases are also important reasons for climate change. Another issue is there 
               are a large amount of missing data, and many of the values in earlier times could be not so precise. "),
             p(""),
             p("There are some numbers worth sharing. In 2020, Asia contributed", round(asia_co2,3), "percent of world CO2 emission. China was the 
               country with the most cumulative emission, which was", round(china_co2,3), " million tons. Qatar has the highest CO2 emission per 
               capita, which was ", round(qatar_pcco2,3), "tons per person. As for growth rate, Tajikistan had a ", round(tj_growth,3), "percent of 
               growth on total CO2 emission comparing to the previous year. On the contrary, Hong Kong had the lowest growth rate, which was ",
               round(hk_growth,3), "percent.")
             
             ),
    
    tabPanel("Interactive Visualization: CO2 Emission Per Capita",
             sidebarLayout(
               sidebarPanel(country_check,
                           year_slider,
                           explainer),
             mainPanel(plotlyOutput("line_year")))),
  
    tabPanel("Reflection: Value Sensitive Design",
             strong("Envision your system in use by a single stakeholder. Now imagine 100 such individuals interacting with the system. 
               Then 1,000 individuals. Then 100,00. What new interactions might emerge from widespread use? Find three synergistic
                benefits of widespread use and three potential breakdowns."),
             p(""),
             h3("Benefits:"),
             p("1. Social medias keep spreading biased information. This can be a decend source of information for people to know the truth."),
             p("2. We cannot insure the data to be totally unbiased, as more people interact with the app, they can potentially point out the mistakes and make the dataset more and more reliable for future usage"),
             p("3. Such app is much more convinient than simply googling the data, people can look at different country and time intervals in more efficient ways."),
             h3("Breakdowns:"),
             p("1. Some may take out the value or tendency independently to make a claim. However, both numeric value and variation over time are important when commenting on a country's effort in terms of fighting climate change."),
             p("2. Some people might find there are areas being considered as country. This can be offensive and confusing"),
             p("3. Some countries in the data set are not in the web app due to lack of data. Some group of people could potentially be underrepresented")
    )
  )
)
                
                
                
                
                
                
                 