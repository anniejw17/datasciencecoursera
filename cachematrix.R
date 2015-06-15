## The functions makeCacheMatrix and cacheSolve together allow one
## to perform matrix inversion at a reduced computational cost 

## makeCacheMatrix creates a matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
    # First, check that the input is square
    isSquare <- ncol(x) == nrow(x)
    if(!isSquare) {
        print("Warning: The input matrix is not square!")
        return
    }
    # Set the matrix object using a function
    set <- function(y) {x <<- y}
    get <- function() x
    list(set = set, get = get)
}


## cacheSolve computes the inverse of the matrix returned by makeCacheMatrix 

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    solve(x$get())
}
