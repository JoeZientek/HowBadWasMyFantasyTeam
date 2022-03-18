
# load necessary packages
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(shinydashboard)

# source module
source("./modules/mod_figures.R")

# read in score/projection data and do minor manipulation
scores_2019 <- read.csv("./data/2019projections.csv")
scores_2019 <- scores_2019 %>% 
  dplyr::mutate(Actual = ifelse(is.na(Actual), 0, Actual), 
                Difference = round(Actual - Proj, 2))

# create default roster formation
rosterFormation <- c("QB", "RB", "RB", "WR", "WR", "TE", "Flex", 
                     "Bench", "Bench", "Bench")
