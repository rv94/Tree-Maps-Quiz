#Install packages
install.packages('treemap')

#Get required libraries
library('treemap')
library('readxl')
library('tidyverse')
library('RColorBrewer')

#Get data and clean up
QuestionSplit <- read_excel('Quiz Split.xlsx', sheet = 'Sheet4')
TreeData <- QuestionSplit %>% 
              rename(Question = `...1`) %>% 
              filter(Question == 'Total') %>% 
              t() %>% 
              as.data.frame() %>%
              rownames_to_column() %>% 
              rename(Tally = V1, Category = rowname) %>% 
              filter(!Category %in% c('Category','Question'))

TreeData$Tally <- as.numeric(as.character(TreeData$Tally))
TreeData$Label <- paste(TreeData$Category, TreeData$Tally, sep = '\n')

#Build treemap
TreeData %>% 
  arrange(desc(Tally)) %>% 
  treemap(  index = 'Label',
            vSize = 'Tally',
            vColor = 'Tally',
            palette = 'Reds',
            type = 'value',
            title = 'Distribution of Questions',
            fontsize.title = 24,
            fontface.labels = c(3),
            fontsize.labels = c(12),
            border.lwds = c(1),
            position.legend = 'none'
            )

