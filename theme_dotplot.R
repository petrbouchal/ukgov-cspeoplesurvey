library(pbtools)
library(dplyr)
library(ggplot2)
library(reshape2)

data <- read.table('./data-input/themes2014.tsv',sep='\t')
names(data) <- c('manager','team','work')
data$dept <- as.factor(row.names(data))

data$dept <- factor(data$dept, levels = data$dept[order(data$manager)])

data <- data %>%
  melt() %>%
  arrange(value)

data$variable <- factor(data$variable,levels(data$variable[c(1,2,3)]))

loadcustomthemes(ifgcolours, 'Calibri')
ggplot(data=data, aes(dept, value, colour=variable),fill='white') + 
  geom_point(size=5, pch=19) + 
  coord_flip() + 
  scale_y_continuous(limits=c(0,100)) + 
#   scale_fill_manual(values=ifgbasecolours, breaks=c('manager','work','team'),
#                     labels=c('My manager','My work','My team')) +
  scale_colour_manual(values=ifgbasecolours, breaks=c('manager','work','team'),
                      labels=c('My manager','My work','My team')) +
  guides(colour=guide_legend()) + 
  theme(axis.text.y=element_text(size=12, colour='black'),
        legend.text=element_text(size=12, face='bold'))

saveplot(plotdir = './',plotname = 'test',plotformat = 'png', plotw=600/96*2.54, ploth=400/96*2.54,dpi=96)

