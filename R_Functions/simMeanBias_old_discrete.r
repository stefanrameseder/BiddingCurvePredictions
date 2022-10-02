
simMeanBias_d 	<- function(sim_data, nbasis_dgp = 5, p, n, #sim_data= sim_data4
							comp_dom = seq(from = 0, to = 1,len = n), 
							small_dom = comp_dom[ comp_dom <= 0.5 ],
							basis = create.bspline.basis(rangeval = range(comp_dom), nbasis_dgp = nbasis_dgp), 
							seq.ev = rev(seq(from = 10,to = 2,len = nbasis_dgp))){
	# 
	
	if(dim(sim_data)[2] != 2) stop("Domain and First Basis should be correlated and contained in sim_data")
	if(any(range(comp_dom)< range(small_dom))) stop("Domains do not fit")
	
	# sum(sim_data[, 2] == 1)
	domain_index	<- sim_data[,2] == 1
	domain			<- sum(domain_index) # domain = 1 is complete domain -> !domain = small domain
	domain2			<- n - domain
	if( any(domain < n/2-0.3*n/2, domain > n/2+0.3*n/2)) warning(paste0("Zu wenige f?r ernsthaften Bias \n domain: ", sum(domain), "\n domain2: ", sum(domain2)))
	
	## Simulating scores
	scores_m 		<- matrix(NA, nrow = nbasis_dgp, ncol = n) # for each function as column there are nbasis_dgp elements for functions


	## First Scores are depending on domain
	scores_m[1, ] 	<- sim_data[ ,1] # in sim_data, the normal marginal have sd = sqrt(seq.ev[b]) 
	for(b in 2:nbasis_dgp){					
		scores_m[b, ] 	<- rnorm(n, sd = sqrt(seq.ev[b]))  
	}

	
	scores_cd_m 	<- scores_m[ , domain_index] #complete 
	scores_sd_m 	<- scores_m[ ,!domain_index] #short

	## Simulated functions: 
	X_cd_m    		<- eval.basis(evalarg = comp_dom, basisobj = basis) %*% scores_cd_m # dim(X_cd_m), dim(eval.basis(evalarg = comp_dom, basisobj = basis)) 
	X_sd_m    		<- eval.basis(evalarg = small_dom, basisobj = basis) %*% scores_sd_m # dim(X_sd_m)
	
	
	# matplot(eval.basis(evalarg = comp_dom, basisobj = basis))
	# matplot(X_cd_m, type = "l", lwd = 0.6, ylim = c(-15, 15))
	# matplot(X_emp_mcbind, type = "l", lwd = 0.6, ylim = c(-15, 15))
	# lines(1:500, rowMeans(X_emp_mcbind, na.rm = TRUE), col = "black", lwd = 4)
	# plot(x = comp_dom, y = X_cd_m[ ,1])
	# lines(x = comp_dom, y = rowMeans(X_cd_m), col = "blue")
	# mean(X_cd_m[ ,1])

	y1_mean 		<- round(mean(rowMeans(X_sd_m)), 2)
	y0_mean			<- round(mean(rowMeans(X_cd_m)), 2)
	dist			<- round(sum(rowMeans(X_sd_m)^2), 2)
	
	## Caluclation of combined mean
	X_emp_mcbind	<- cbind(X_cd_m, rbind(X_sd_m, matrix(NA, nrow = length(comp_dom) - length(small_dom), ncol = dim(X_sd_m)[2])))
	X_emp_mean		<- rowMeans(X_emp_mcbind, na.rm = TRUE)
	
	scores			<- rbind(scores_m, domain_index)
	rownames(scores)<- c(paste0("score",1:nbasis_dgp), "d")
	return(list(X_cd_m = X_cd_m, X_sd_m = X_sd_m, X_emp_mcbind = X_emp_mcbind, X_emp_mean = X_emp_mean, basis = basis, 
				scores_cd = scores_cd_m, scores_sd = scores_sd_m, nbasis_dgp = nbasis_dgp, p = p, n = n, comp_dom = comp_dom, small_dom = small_dom,
				y1_mean = y1_mean, y0_mean = y0_mean, dist = dist, scores = scores))
} 

