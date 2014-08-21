# Fitting Lines to Random Data

The idea behind this Shiny app is to show how easy it is to do non-sensical things with powerful statistical tools.
This app will cheerfully fit any number of lines to a variety of random data resulting in a what looks like a
meaningful plot.  Only it isn't!

## Controls

* The **Random Distribution Type** radio button allows one to select between normal, uniform, exponential, 
and Poisson random data.

* The **Select random data count** slider determines how many random data will be generated.  This slider ranges from
10 to 1000 in increments of 10.

* The **Line Type** radio button allows one to select how a line will be fitted to the random data.  If **Knots and Splines** 
is selected, then an additional slider for specifying the spline count will appear.  This slider ranges from 1 to 100 in 
increments of 1.

* The **Regenerate Random Data** button forces generation of new random data without changing any of the other settings.
Changing the data count or distribution type will also cause generation of new random data.  Changing only the line type
or knot count plots a new line with the existing data unchanged.

## Suggested Experiments

### Negative Effect of Small Sample Sizes

Select the **Normal** distribution type, a line type of **Linear Model**, and set the data count slider to its
lowest/leftmost setting.
Tap the **Regenerate Random Data** button repeatedly and observe how the the slope of the 
fitted line varies greatly.  This is
because although the ten data points are truly random, they are not statistically significant.  For this we need much larger 
amounts of data.  To show this, set the data count slider to its highest/rightmost setting.  Now you should see much less
variation in the fitted line when tapping the **Regenerate Random Data** button repeatedly.

### When Not to Use Knots

Select any data distribution, select a high data count, and select **Knots and Splines** for the fitted line type.
Experiment with the spline count slider and notice how smaller spline counts can almost make you believe there is
a pattern in the data!

### Algorithms Don't Understand Data Distributions

Select the **Poisson** distribution, select a data count about 3/4 along the slider, and select the **Loess** line type.
Tap the **Regenerate Random Data** button repeatedly and note what kind of line is fitted to the data.  Since
this is Poisson data, any fitted line should be perfectly horizontal reflecting some arrival rate.  But the Loess
algorithm doesn't understand the data and thus fits a misleading and erroneous line.





