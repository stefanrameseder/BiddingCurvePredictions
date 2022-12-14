
addAlpha 		<- function(col, alpha=1){
    ## Defines a color with transparency ratio alpha
	## useful for many lines in a plot
    if(missing(col))
        stop("Please provide a vector of colours.")
    apply(sapply(col, col2rgb)/255, 2, function(x) rgb(x[1], x[2], x[3], alpha=alpha))  
}
