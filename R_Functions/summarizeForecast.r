summarizeForecast	<- function(resList, B){
	# Evaluates the forecasts of one pm-htnt entry in the result_l list
	# Input: 
	# - resList = a list with entries (pm) each with entries (htnt) with a forecast object:
	# 		- par: the estimated parameters of that model for period T+1
	# 		- fc: the actual forecast y_T+1|T
	#       - wavg: the weighted average in T+1
	#		- max: the maximum accepted price in T+1
	# 		- acc: the maximum accepted price in T+1 (same as Z_T+1)
	# - B = Number of Periods for which it should be backtested
	# Output:
	# - accRate = sum Z_t / B
	# - perfRate = sum fc_t * Z_t / sum wavg_t
	# accRate = sum Z_t / T
	# Hint: Since we have Forecasts for i = T-B, ..., T+1 but only compareable data j = T-B, ..., T, we need to get rid of T+1 
	
	accRate 	<- sum(unlist(lapply(resList$fc[- (B+1) ], function(x) x$acc == 1)), na.rm = TRUE)/B	
	
	# perfRate = sum B_t * Z_t / sum WAvg_t
	bidGain		<- unlist(lapply(resList$forecast[- (B+1) ], function(x) x$fc * x$acc ))
	avgGain		<- unlist(lapply(resList$forecast[- (B+1) ], function(x) x$wavg))
	
	if(sum(avgGain) > 0){ # if anybody gained anything
		perfRate	<- sum(bidGain)/sum(avgGain)
	} else if(all(sum(avgGain) == 0, sum(bidGain) == 0 )){ # if nobody gained anything
		perfRate	<- -100
	} else{
		print("Error within the calculation of the perfRate")
	}
	return( list(CapacityPrice = resList$fc[B+1][[1]]$fc, accRate = accRate, perfRate = perfRate))
}