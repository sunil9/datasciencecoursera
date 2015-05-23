# header ----------------------------------------------------------------------
# Course: R Programming
# Assignment:1 - Air Pollution, Part1 - Pollutant Mean 
# Author: Sunil Pereira
# Created Date: April 19, 2015

# pollutantmean() -------------------------------------------------------------
# Calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
# Args:
#   directory: character vector of length 1 indicating
#              the location of the CSV files
#   pollutant: character vector of length 1 indicating
#              the name of the pollutant for which we will 
#              calculate the mean; either "sulfate" or "nitrate".
#    id: integer vector indicating the monitor ID numbers to be used
#
# Returns:
# The mean of the pollutant across all monitors list in the 'id' vector (ignoring NA values)

pollutantmean <- function(directory, pollutant, id = 1:332) {
      # check if argument 'id' is is valid numeric range and not character 
    pollutant.vector <- c("sulfate","nitrate")
    if (id < 1 || id > 332 || !is.numeric(id) || is.na(match(pollutant,pollutant.vector))) {
        print("Error: invalid argument type")
        print("Args:pollutant = sulfate or nitrate")
        print("Args:id should be in the range of 1:332")       
        print("Usage: pollutantmean(directory, pollutant, id = 1:332) ")
    } else {
        
        # read entire file list (monitors) from 'directory' into character vector 
        monitors.list <- list.files(directory)
        # creates subset of monitors from the above list as specified by 'id'
        monitors.subset <- monitors.list[id]
        
        #initialize the pollutant dataset to be read from each monitor csv
        pollutant.dataset <- NA
        
        # read monitors subset into pollutant dataset
        if(length(monitors.subset) >= 1) {
            for (filename in monitors.subset) {   
                monitor.file <- paste(directory,"/", filename, sep = '')
                pollutant.dataset <- rbind(pollutant.dataset, read.csv(monitor.file))
            } 
            
            #calculate mean for dataset with column name = pollutant
            pollutant.mean <- mean(pollutant.dataset[,pollutant], na.rm = TRUE)
            
            # round the mean to 3 decimal digits
            round(pollutant.mean, digits=3)
            
        } 
    }
}


