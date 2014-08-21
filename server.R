dtype <- "none"   # "Normal" | "Uniform" | "Exponential" | "Poisson"
dcnt <- -1        # data count, aka x-axis
ltype <- "none"   # "Linear Model" | "Loess" | "Knots and Splines"
kcnt <- -1        # knot count
gocnt <- -1       # regenerate random data button count
x <- NA           # global which survives between calls from ui.R
y <- NA           # global which survives between calls from ui.R
linex <- NA       # global which survives between calls from ui.R
liney <- NA       # global which survives between calls from ui.R

shinyServer(
    function(input, output) {
        output$plot <- renderPlot({
            # Test various conditions so we can discriminate between having to regenerate
            # the fitted line only versus also having to generate new random data.
            newdata <- FALSE
            if ( input$gocnt != gocnt ) {        # Regenerate random data button pressed.
                gocnt <<- input$gocnt
                newdata <- TRUE
            }
            if ( input$dcnt != dcnt ) {          # Data count slider moved.
                dcnt <<- input$dcnt
                x <<- seq(dcnt)
                newdata <- TRUE
            }
            if ( input$dtype != dtype ) {        # Random data type changed.
                dtype <<- input$dtype
                newdata <- TRUE
            }
            if ( newdata ) {
                y <<- switch(dtype,
                             "Normal" = rnorm(dcnt),
                             "Uniform" = runif(dcnt),
                             "Exponential" = rexp(dcnt),
                             "Poisson" = rpois(dcnt, 5))
            }
            if (   newdata                        # new random data needs display
                   | input$ltype != ltype         # fitted line type changed
                   | input$kcnt != kcnt ) {       # knot count changed
                ltype <<- input$ltype
                kcnt <<- input$kcnt
                if ( "Linear Model" == ltype ) {  # fit linear model
                    fit <- lm(y ~ x)
                    linex <<- x
                    liney <<- fit$fitted.values
                } else if ( "Loess" == ltype ) {  # fit loess line
                    lw1 <- loess(y ~ x)
                    j <- order(x)
                    linex <<- x[j]
                    liney <<- lw1$fitted[j]
                } else {                          # fit knot/spline line
                    knots <- seq(0, dcnt, dcnt/kcnt)
                    splineTerms <- sapply(knots, function(knot) { ( x > knot ) * ( x - knot ) } )
                    xMat <- cbind(1, x, splineTerms)
                    yhat <- predict(lm(y ~ xMat - 1))
                    linex <<- x
                    liney <<- yhat
                }
            }
            # Update output plot on any UI change.
            title <- paste("Random", dtype, "distribution data with line fitted by", ltype)
            plot(x, y, main=title)
            lines(linex, liney, col="red", lwd=3)
        })
    })