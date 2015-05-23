# header ----------------------------------------------------------------------
# Course: R Programming
# Programming Assignment 3: Hospital Quality
# Author: Sunil Pereira
# Created Date: May 1, 2015

# rankall() ------------------------------------------------------------
# This function takes two arguments: an outcome name (outcome) and a hospital
# ranking (num). The function reads the outcome-of-care-measures.csv file and
# returns a 2-column data frame containing the hospital in each state that has
# the ranking specified in num. For example the function call rankall("heart
# attack", "best") would return a data frame containing the names of the
# hospitals that are the best in their respective states for 30-day heart attack
# death rates. The function should return a value for every state (some may be
# NA). The first column in the data frame is named hospital, which contains the
# hospital name, and the second column is named state, which contains the
# 2-character abbreviation for the state name. Hospitals that do not have data
# on a particular outcome should be excluded from the set of hospitals when
# deciding the rankings.

# rankall <- function(outcome, num = "best") {
#     ## Read outcome data
#     data.file <- "./data/outcome-of-care-measures.csv"
#     data <- read.csv(data.file, colClasses="character")
#     
#     ## Get the col number
#     coln <- if(outcome == "heart attack") {
#         11
#     } else if(outcome == "heart failure") {
#         17
#     } else if(outcome == "pneumonia") {
#         23
#     } else {
#         stop("invalid outcome")        
#     }
#     
#     ## Remove NAs
#     data <- data[complete.cases(data[,coln]),]
#     
#     ## Sort by state, rate and name
#     data <- data[order(data[7], data[coln], data[2]), ]
#     
#     ## Split by state
#     s <- split(data, data[7])
#     
#     hospitals <- character(0)
#     states <- character(0)
#     
#     for(name in names(s)){
#         hospName <- if(num == "best"){
#             s[[name]][1, 2]
#         } else if(num == "worst"){
#             tail(s[[name]], 1)[1, 2]
#         } else {
#             s[[name]][num, 2]
#         }
#         hospitals <- append(hospitals, hospName)
#         states <- append(states, name)
#     }
#     
#     data.frame(hospital=hospitals, state=states)
# }

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data.file <- "./data/outcome-of-care-measures.csv"
    outcome.data <- read.csv(data.file, colClasses="character")
    
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
    
    states <- unique(outcome.data$State)
    rankMatrix <- sapply(states, function(state){
        ## Filter DF on state
        outcome.data <- outcome.data[outcome.data$State==state,]
        
        ## Convert using as.numeric, supressing coercian warnings
        suppressWarnings(outcome.data[, coln] <- as.numeric(outcome.data[, coln]))
        if (class(num) == "numeric") { ## Order DF on outcomeCol, and then name
            outcome.data <- outcome.data[order(outcome.data[,coln], outcome.data[,2]), ]
            return (c(state, outcome.data[num,2]))
        }
        if (num=="best") { ## Order DF on outcomeCol, and then name
            outcome.data <- outcome.data[order(outcome.data[,coln], outcome.data[,2]), ]
            return (c(state, outcomeData[1,2]))
        }
        if (num=="worst") { ## Order DF on reverse of outcomeCol, and then name
            outcome.data <- outcome.data[order(-outcome.data[,coln], outcome.data[,2]), ]
            return (c(state, outcome.data[1,2]))
        }
    })
    result <- data.frame(rankMatrix[2,], rankMatrix[1,]) # Insert values into DF
    colnames(result) <- c("hospital", "state")
    rownames(result) <- result$state
    result <- result[order(result$state),]
    return(result)
    
}