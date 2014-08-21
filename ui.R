library(markdown)

shinyUI(
    navbarPage("Fitting Lines to Random Data",
               tabPanel("App",
                        sidebarLayout(
                            sidebarPanel(
                                radioButtons("dtype", "Random Distribution Type:",
                                             c("Normal", "Uniform", "Exponential", "Poisson")),
                                sliderInput("dcnt", "Select random data count:",
                                            value = 100, min = 10, max = 1000, step = 10),
                                radioButtons("ltype", "Line Type:",
                                             c("Linear Model", "Loess", "Knots and Splines")),
                                conditionalPanel(condition = "input.ltype == 'Knots and Splines'",
                                                 sliderInput("kcnt", "Select spline count:",
                                                             value = 10, min = 1, max = 100, step = 1)),
                                actionButton("gocnt", "Regenerate Random Data")),
                            mainPanel(
                                plotOutput("plot"))
                        )
               ),
               tabPanel("Documentation",
                        includeMarkdown("helpinfo.md")
               )
    )
)