# header ------------------------------------------------------------------
# Course: R Programming
# Assignment:1 - Air Pollution, Part2 - Completely Observed Cases 
# Author: Sunil Pereira
# Created Date: April 19, 2015

complete <- function(directory, id = 1:332) {
    # Reads a directory full of files and reports the number of completely
    # observed cases in each data file
    # Args:
    #   directory: character vector of length 1 indicating
    #              the location of the CSV files
    #    id: integer vector indicating the monitor ID numbers to be used
    #
    # Returns:
    # A data frame where the first column is the name of the file and the 
    # second column is the number of complete cases
    # sample output:
    # id nobs
    # 1  117
    # 2  1041
    # ...
    # where 'id' is the monitor ID number and 'nobs' is the
    # number of complete cases
    
    # begin ----------------------------------------------------- 
    
    # check if argument 'id' is is valid numeric range and not character 
    if (id < 1 || id > 332 || !is.numeric(id)) {
        print("Error: id - invalid argument range/type")
        print("Usage: complete(directory, id = 1:332)")
    } else {
                
        # read entire file list (monitors) from 'directory' into character vector 
        monitors.list <- list.files(directory)
        # creates subset of monitors from the above list as specified by 'id'
        monitors.subset <- monitors.list[id]
        
        #Initialize the vector to record complete cases
        complete.observations = numeric()
        
        # read monitors subset and computes the total of complete cases and
        # adds to complete.oberservations vector 
        
        for (filename in monitors.subset) {   
            monitor.file <- paste(directory,"/", filename, sep = '')
            total.cases <- sum(complete.cases(read.csv(monitor.file)))
            complete.observations <- c(complete.observations, total.cases)            
        } 
        
        # creates data frame with column headers: id, nobs(complete.observations) 
        data.frame(id, nobs=complete.observations)
    }
}    