## R file containing necessary code to create a matrix able to cache its inverse
## saving computation time when the inverse has to be re-used multiple times

## build a cache matrix, so a matrix able to cache its inverse the first time it
## computed

makeCacheMatrix <- function(x = matrix()) {
    
    # Inverse of the matrix. Init to NULL
    mInv <- NULL
    
    # Assignment function to create new matrix
    set <- function(y){
        x <<- y
        mInv <<- NULL
    }
    
    # Get function to retrive the matrix
    get <- function() x
    
    # Set the inverse of the matrix in the cache
    setInverse <- function(matInverse) mInv <<- matInverse
    
    # get inverse of matrix from cache
    getInverse <- function() mInv
    
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## compute the inverse of a cacheMatrix and store it in the cache if not already
## done. Returns inverse from cache if already set

cacheSolve <- function(x, ...) {
    
    mInv <- x$getInverse()
    if(!is.null(mInv)){
        message("Retrieving invert matrix from cache")
        return(mInv)
    }
    
    # Invert matrix does not already exist so we create it
    mat <- x$get()
    mInv <- solve(mat)
    x$setInverse(mInv)
    mInv
}



