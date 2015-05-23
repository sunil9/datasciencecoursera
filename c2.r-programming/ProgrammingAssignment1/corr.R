# header ----------------------------------------------------------------------
# Course: R Programming
# Assignment:1 - Air Pollution, Part3 - Pollutant Mean 
# Author: Sunil Pereira
# Created Date: April 19, 2015

# corr() ----------------------------------------------------------------------
corr <- function(directory, threshold = 0) {
    # Calculates the correlation between sulfate and nitrate for monitor locations where 
    # the number of completely observed cases (on all variables) is greater than the threshold.
    # Args:
    #   directory: character vector of length 1 indicating
    #              the location of the CSV files
    #   threshold: numeric vector of length 1 indicating the
    #              number of completely observed observations (on all variables) 
    #              required to compute the correlation between nitrate and sulfate; 
    #              the default is 0
    # Returns:
    # Numeric vector of correlations for the monitors that meet the threshold requirement. 
    # If no monitors meet the threshold requirement, the function returns a numeric vector of length 0
    
     # initialize vector
    correlations <- numeric(0)
    
    # read entire file list (monitors) from 'directory' into character vector 
    monitors.list <- list.files(directory)
    
    
    # read all monitors and total of complete cases and
    # adds to complete.oberservations vector 
    
    for (filename in monitors.list) {   
        monitor.file <- paste(directory,"/", filename, sep = '')
        pollutant.dataset <- read.csv(monitor.file)
        pollutant.dataset <- pollutant.dataset[complete.cases(pollutant.dataset), ]
        
        if ( nrow(pollutant.dataset) > threshold ) {            
            correlations <- c(correlations, cor(pollutant.dataset$sulfate, pollutant.dataset$nitrate) ) 
        }      
    }  
    return(round(correlations, digits = 4))
}