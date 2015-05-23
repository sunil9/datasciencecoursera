# header ----------------------------------------------------------------------
# Course: R Programming
# Programming Assignment 3: Hospital Quality
# Author: Sunil Pereira
# Created Date: May 1, 2015

# best() ------------------------------------------------------------
# This function takes two arguments: the 2-character abbreviated name of a state
# and an outcome name. The function reads the outcome-of-care-measures.csv file
# and returns a character vector with the name of the hospital that has the best
# (i.e. lowest) 30-day mortality for the specified outcome in that state. The
# hospital name is the name provided in the Hospital.Name variable. The outcomes
# can be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that
# do not have data on a particular outcome should be excluded from the set of
# hospitals when deciding the rankings.

best <- function(state, outcome) {
    data.file <- "./data/outcome-of-care-measures.csv"
    data <- read.csv(data.file, colClasses="character")
    
    ## Filter the state
    data <- data[data$State == state, ]
    
    ## Check invalid state
    if(nrow(data) == 0) {
        stop("invalid state")
    }
    
    ## Get the col number
    coln <- if(outcome == "heart attack") {
        11
    } else if(outcome == "heart failure") {
        17
    } else if(outcome == "pneumonia") {
        23
    } else {
        stop("invalid outcome")        
    }
    
    ## Convert character to numeric
    data[, coln] <- suppressWarnings(as.numeric(data[, coln]))
    
    ## Remove NAs
    data <- data[complete.cases(data[,coln]),]
    
    ## Sort by rate and then by name
    data <- data[order(data[coln], data[2]), ]
    
    
    data[1, 2]
    
}