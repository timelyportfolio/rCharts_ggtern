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


#facetting example
set.seed(1) #for reproduceability
MYDATA <- data.frame(A=runif(100),
                     B=runif(100),
                     C=runif(100),
                     groupA=rep(paste(c("A1","A2"),""),50)[sample(50)],
                     groupB=rep(paste(c("B1","B2"),""),50)[sample(50)]) 

#create plot3
plot3 <- ggtern(data=MYDATA,mapping=aes(x=A,y=B,z=C)) + 
  labs(title ="Example Ternary plot3s w/ Facetting",
       fill  ="Fill Metric",
       color ="Color Metric",
       alpha ="Alpha Metric",
       x     ="T",
       y     ="L",
       z     ="R") + 
  facet_grid(groupA~groupB) +
  stat_density2d(fullrange=T,n=200,
                 geom="polygon",
                 aes(fill  =..level..,
                     alpha =..level..)) + 
  theme_rgbw()  + #custom themes 
  atomic_percent()   + #make ternary scales on atomic %
  geom_point(size=3,shape=16,
             aes(colour=factor(paste0(groupA,"/",groupB))))
#render
plot3
grid.export("facettern.svg",addClasses=TRUE)


#advanced example
plot3 + theme(ternary.options  =element_ternary(
  showarrows       = TRUE,  #show or hide the ternary arrows 
  padding          = 0.15,  #analogous to 'expand' for x and y.
  arrowsep         = 0.075, #distance between tern axis and arrows
  arrowstart       = 0.25,  #prop of axis where arrow starts
  arrowfinish      = 0.75,  #prop of axis where arrow finishes
  ticklength.major = 0.02,  #major ternary ticklength
  ticklength.minor = 0.01   #minor ternary ticklength
))
grid.export("advanced.svg",addClasses=T)
