# header ----------------------------------------------------------------------
# Course: R Programming
# Programming Assignment 3: Hospital Quality
# Author: Sunil Pereira
# Created Date: May 1, 2015

# rankhospital() ------------------------------------------------------------
# This function  takes three arguments: 
#     1. the 2-character abbreviated name of a state (state), 
#     2. an outcome (outcome), and 
#     3. the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and 
# returns a character vector with the name of the hospital that has the ranking 
# specified by the num argument.

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
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
    
    ## Return the desired
    if(num == "best"){
        data[1, 2]
    } else if(num == "worst"){
        tail(data, 1)[1, 2]
    } else {
        data[num, 2]
    }
}