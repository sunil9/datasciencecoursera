# header ----------------------------------------------------------------------
# Course: R Programming
# Programming Assignment 2: Lexical Scoping
# Author: Sunil Pereira
# Created Date: April 26, 2015

# description -----------------------------------------------------------------
# Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly. The two
# functions mackeCacheMatrix(), cacheSolve() below creates a special "matrix" 
# object and caches its inverse


# makeCacheMatrix() ----------------------------------------------------------
# This function creates a special "matrix", which is really a list containing a 
# function to ...
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of inverse of the matrix
# 4. get the value of inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


# cacheSolve() ----------------------------------------
# This function computes the inverse of the special "matrix" returned by
# makeCacheMatrix above. If the inverse has already been calculated (and the
# matrix has not changed), then cacheSolve retrieves the inverse from
# the cache   
cacheSolve <- function(x, ...) {
    
    inv <- x$getinverse()
    
    if(!is.null(inv)) {
        # if inverse is cached, return it
        message("getting cached data....")
        return(inv)
    }
    
    # else, calculate the inverse and cache it
    m <- x$get()
    inv <- solve(m, ...)
    x$setinverse(inv)
    inv    
}

# usage -----------------------------------------------------------------------
# > x <- rbind(c(1, -1/4), c(-1/4, 1)) 
# > m <- makeCacheMatrix(x)
# > m$get()
# [,1]  [,2]
# [1,]  1.00 -0.25
# [2,] -0.25  1.00
# > cacheSolve(m)
# [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667
# > cacheSolve(m)
# getting cached data....
# [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667


