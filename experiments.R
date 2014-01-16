#get the latest and greatest
#library(devtools)
#install_github("ggtern","nicholasehamilton")

#get CRAN
#install.packages("ggtern")

library(ggplot2)
library(ggtern)
library(gridSVG)

x11(height=11,width=11)

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
  arrowfinish      = 0.75,  #
  prop of axis where arrow finishes
  ticklength.major = 0.02,  #major ternary ticklength
  ticklength.minor = 0.01   #minor ternary ticklength
))
grid.export("advanced.svg",addClasses=T)



#feldspar
data(Feldspar)
ggtern(data=Feldspar,aes(x=An,y=Ab,z=Or)) + geom_point()
grid.export("feldspar.svg",addClasses=T)

#feldspar with confidence
#gets error
ggtern(data=Feldspar,aes(An,Ab,Or)) + geom_point() + geom_confidence()
grid.export("feldspar_confidence.svg",addClasses=T)


#USDA
#Load the Data.
data(USDA)


library(plyr)

#Put tile labels at the midpoint of each tile.
USDA.LAB <- ddply(USDA,"Label",function(df){apply(df[,1:3],2,mean)})

#Tweak
USDA.LAB$Angle=0; USDA.LAB$Angle[which(USDA.LAB$Label == "Loamy Sand")] = -35

#Construct the plot.
ggtern(data=USDA,aes(Clay,Sand,Silt,color=Label,fill=Label)) +
  geom_polygon(alpha=0.75,size=0.5,color="black") +
  geom_text(data=USDA.LAB,aes(label=Label,angle=Angle),color="black",size=3.5) +
  theme_rgbw() +
  theme_showsecondary() +
  theme_showarrows() +
  weight_percent() +
  theme(legend.justification=c(0,1),legend.position=c(0,1),axis.tern.padding=unit(.15,"npc")) +
  labs(title="USDA Textural Classification Chart",fill="Textural Class",color="Textural Class")

grid.export("USDA.svg",addClasses=T)
