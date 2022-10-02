
transfBidSimObj <- function(bidSimObj){ # bidSimObj <- distMatSD
	ns			<- names(bidSimObj)
	colNames 	<- colnames(bidSimObj[[1]])
	rowNames 	<- rownames(bidSimObj[[1]])
	
	emptMat		<- matrix(NA, ncol = length(colNames), nrow = length(ns) * length(rowNames))
	colnames(emptMat) <- colNames
	rownames(emptMat) <- paste0(rep(ns, each=length(rowNames)), rowNames)
	
	for(name in ns){ # name <- ns[1]
		for(rName in rowNames){
			for(cName in colNames){
				emptMat[ paste0(name,rName) , cName ] <- bidSimObj[[name]][ rName , cName ]
			}
		}
	}
	return(emptMat)
}