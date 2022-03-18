
# load necessary packages
library(shiny)
#library(ggplot2)
#library(dplyr)
#library(reactable)

# read in score/projection data
scores_2019 <- read.csv("./data/2019projections.csv")

# create default roster formation
rosterFormation <- c("QB", "RB", "RB", "WR", "WR", "TE", "Flex", 
                     "Bench", "Bench", "Bench", "Bench", "Bench")

