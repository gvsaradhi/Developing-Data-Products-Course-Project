library(shiny)



# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  titlePanel("IRIS Data Analysis"),
  mainPanel(
  tabsetPanel(
       
    tabPanel("Introduction",
             h4("About the Data"),
             h5("- Iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris."),
             h5("- The species are Iris setosa, versicolor, and virginica."),
             
             h4("The shiny app built will help us perform 3 tasks:"),
             h5("- Analyse the distribution of the measurements for each of the species."),
             h5("- Analyse the correlation between the pairs of measurements using a scatter plot."),
             h5("- A model built on this dataset using decision trees can be evaluated by trying out new measurements and see the classified species based on the model dynamically."),
             h5("Click on the tabs above to navigate the app to perform the tasks mentioned above")
             ),    
    tabPanel("Histogram Analysis",  
             h5("- We can analyse the distribution of measurements for each of the species"),
             h5("- Choose the measurement and species from the dropdown to view the distribution"),
             h5("- Use the slider to adjust the number of bins for the histogram"),
             uiOutput("variable_dropdown"),
             uiOutput("class_dropdown"),
             sliderInput("nbins", 
                         "Number of bins:", 
                         min = 1,
                         max = 20, 
                         value = 10),
             plotOutput("histplot")
             
    ),
    
    tabPanel("Scatter Plot Analysis", 
             h5("- We can analyse the correlation between measurements colored by species"),
             h5("- Choose the measurement pairs from the dropdown and view the scatter plot"),
             
             uiOutput("variable_dropdown1"),
             uiOutput("variable_dropdown2"),
             plotOutput("scatplot")
             
    ),
   
    tabPanel("Predictions",
             h5("- A decision tree model is built using the caret's rpart package"),
             h5("- The model is represented diagramatically for analysis below"),
             h5("- Classified 'Species' can be view dynamically be playing with the measurements in the text boxes below"),
             plotOutput("dtree"),
             
             div(style="display:inline-block",numericInput("sl", "Sepal.Length", 4.3, min = 4.3, max = 8,step = 0.1)),
             div(style="display:inline-block",numericInput("sw", "Sepal.Width", 2, min = 2, max = 5,step = 0.1)),  
             div(style="display:inline-block",numericInput("pl", "Petal.Length", 1, min = 1, max = 7,step = 0.1)),  
             div(style="display:inline-block",numericInput("pw", "Petal.Width", 0.1, min = 0.1, max = 3,step = 0.1)),
             h3(textOutput("classtext",inline=FALSE))        
    )
  )
    
    
)

))
