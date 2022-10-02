
summarizeFC <- function(pmhtntFC, B, bdQuan, PMHTNT){
    # Output:
    # - accRate = sum Z_t / B
	# - perfRate = 
	
	
	
    accRates <- sapply(PMHTNT, function(pmhtnt){ # pmhtnt <- pmhtntFC[[1]]; fcs <-pmhtnt[[1]]
        # Get all acceptances or non acceptances
        accs <- sapply(pmhtntFC[[pmhtnt]], function(fcs) fcs["acc"])
        accRate <- sum(accs)/B
        return(accRate)})
    
    # - perfRate = sum fc_t * Z_t / sum wavg_t
    perfRates <- sapply(PMHTNT, function(pmhtnt){ # pmhtnt <- "POS_HT"
        # Get all acceptances or non acceptances
        accs <- sapply(pmhtntFC[[pmhtnt]], function(fcs) fcs["acc"])
        FCs <- sapply(pmhtntFC[[pmhtnt]], function(fcs) fcs["fc"])
        
        accRate <- sum(accs*FCs) / sum(rev(bdQuan[[pmhtnt]][ , c("gavg")])[1:B])
        return(accRate)})
    return(cbind(accRates = accRates, perfRates = perfRates))
}


