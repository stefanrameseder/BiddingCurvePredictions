#############################################
## List2Mat
List2Mat <- function (y, t) 
{
    n = length(y)
    obsGrid = sort(unique(unlist(t)))
    ymat = matrix(rep(NA, n * length(obsGrid)), nrow = n, byrow = TRUE)
    for (i in 1:n) {
        ymat[i, is.element(obsGrid, t[[i]])] = y[[i]]
    }
    return(ymat)
}
