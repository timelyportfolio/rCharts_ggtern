#get the latest and greatest
#library(devtools)
#install_github("ggtern","nicholasehamilton")

#get CRAN
#install.packages("ggtern")

library(ggplot2)
library(ggtern)
library(gridSVG)

plot <- ggtern()
plot <- plot + geom_point(data=data.frame(x=1,y=0,z=0),aes(x,y,z))
plot

