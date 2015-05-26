#install.packages("caret")
#install.packages("rattle")
#install.packages("rpart.plot")
#install.packages("ggplot2")


library(shiny)
library(caret)
library(rattle)
library(ggplot2)
library(rpart.plot)
library(e1071)


data(iris)
cnames_iris= names(iris)
modFit= train(Species~., method="rpart", data=iris)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$variable_dropdown <- renderUI({
    selectInput("selected_var", h5("Select Variable"), choices=cnames_iris[-length(cnames_iris)])
  })
  
  output$variable_dropdown1 <- renderUI({
    selectInput("selected_var1", h5("Select Variable"), choices=cnames_iris[-length(cnames_iris)])
  })
  
  output$variable_dropdown2 <- renderUI({
    selectInput("selected_var2", h5("Select Variable"), choices=cnames_iris[-length(cnames_iris)])
  })
  
  output$class_dropdown <- renderUI({
    selectInput("selected_class", h5("Select class"), choices=unique(levels(iris$Species)))
  })
  
  
  output$histplot <- renderPlot({
    selected_col= input$selected_var
    selected_class= input$selected_class
    print(selected_class)
    curdata= iris[iris$Species==selected_class,]
    hist(curdata[,selected_col],main="",xlab=selected_col, breaks=input$nbins)
    #qplot(selected_col, data=curdata, geom="histogram",bin_width=1)
  })
  
  output$scatplot <- renderPlot({
    xvar= input$selected_var1
    yvar= input$selected_var2
    
    ggplot(iris,aes_string(x=xvar,y=yvar, colour="Species")) + geom_point() 
   
  })
  
  output$dtree <- renderPlot({
    
    
    fancyRpartPlot(modFit$finalModel,sub="")
  })
  
  output$classtext <- renderText({
    testdata= iris[0,]
    testdata= subset(testdata, select=-Species)
    testdata[1,"Sepal.Length"]= input$sl
    testdata[1,"Sepal.Width"]= input$sw
    testdata[1,"Petal.Length"]= input$pl
    testdata[1,"Petal.Width"]= input$pw
    op=predict(modFit,newdata=testdata)
    paste(c("Predicted Class:", as.character(op)), collapse=" ")
  })
  
  
  
})