library(shiny)
library(ggplot2)


# ui
ui <- fluidPage(
   
   # title; first panel
   titlePanel('normal distribution'),
   # normal distribution formula; withMathJax lets you have math equations in R Shiny app; in Markview, would do $$f(x) = \frac{1}$$
   headerPanel(withMathJax('$$f(x) = \\frac{1}{\\sigma\\sqrt{2\\pi}} e^\\frac{-(x-\\mu)^{2}}{2\\sigma^2}$$')), 
   
   # sidebar with slider and checkbox inputs
   sidebarLayout(
      sidebarPanel(
         sliderInput('n',    #name of slider panel
                     'sample size',
                     min = 0,
                     max = 500,
                     value = 100),
         sliderInput('mu',
                     withMathJax('$$\\mu$$'), 
                     min = -5,
                     max = 5,
                     value = 0,
                     step = 0.1),
         sliderInput('sigma', 
                     withMathJax('$$\\sigma$$'),
                     min = 0.01,
                     max = 10,
                     value = 5,
                     step = 0.1),
         checkboxInput('histogram', label = 'histogram', value = TRUE), 
         checkboxInput('density', label = 'density', value = TRUE),
         textInput("title", label = "What should i call this?")
          ),
      

      
      # main plot
      mainPanel(
         plotOutput('dist')
      )
   )
)

# server; always start server with function(input, output)
server <- function(input, output) {
   
   output$dist <- renderPlot({ # adjust the number of bins based on the sample size
     
     n <- input$n     #designated bins based off of the sample size
     if(n < 25){
       bins <- 10
     } else if(n < 50){
       bins <- 20
     } else if(n <= 500){
       bins <- 30
     }
     
     set.seed(1001) # prevent output from changing based on plot type

      x <- rnorm(input$n, input$mu, input$sigma) # determine distribution
      
      # draw the histogram with the specified number of bins
      
     p <- ggplot() + scale_x_continuous(limits = c(-20, 20))
     if(input$histogram) p <- p + geom_histogram(aes(x, y = ..density..), bins = bins, colour = 'black', fill = 'white') # add hist if checked
     if(input$density) p <- p + geom_density(aes(x), alpha=.2, fill="#FF6666") # add density if checked
     p + theme_minimal() + labs(title=input$title)
   })
}

# run application
shinyApp(ui = ui, server = server)

