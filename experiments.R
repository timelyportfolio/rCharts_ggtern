#get the latest and greatest
#library(devtools)
#install_github("ggtern","nicholasehamilton")

#get CRAN
#install.packages("ggtern")

library(ggplot2)
library(ggtern)
library(gridSVG)

#examples from website http://ggtern.com
#basic example
plot <- ggtern()
plot <- plot + geom_point(data=data.frame(x=1,y=0,z=0),aes(x,y,z))
plot
grid.export("basicexample.svg", addClasses=T)


#ternary scales
plot2 <- plot + tern_limits(T=1.0,L=0.7,R=0.7)
plot2 <- plot2 + labs(x="THS",y="LHS",z="RHS")
plot2
grid.export("ternaryscales.svg", addClasses=T)
