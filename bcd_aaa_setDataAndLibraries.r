## ###########################################
### Used Libraries

require(parallel) # for parallel spline smoothing
require(MASS) # for df

# install.packages("devtools")
require(devtools) # to install older packages

# install_version("coneproj", version = "1.11", repos = "http://cran.us.r-project.org") # cone projections for smoothing parameter lambda
require("coneproj")
packageVersion("coneproj") # if not 1.11., monot splines might not work

# install.packages("reshape")
require(orthogonalsplinebasis) # cone projections for smoothing parameter lambda
require(locfit) # for local linear fit with alternative means

# For Graphics, in particular get_step_curve
require(ggplot2) # graphs, in particular plots
require(grid) # for multiplot function
#library(dplyr) # like plyr a package for dataset operators
require("scales")
require("reshape") # install.packages("reshape")
require("scatterplot3d") # install.packages("fda.usc")
require(RColorBrewer)

# For FDA-Analysis
require(fda.usc) # Outlier Analysis, FDA objects, ... install.packages("fda.usc")
require(far) # Functional Autoregression for FAR(1) models install.packages("GenSA")
require("fda")    # convenient basis functions
require("scales") # colors

# For Time Series
require("timeDate")
require("tseries") # install.packages("forecast")
require(zoo)
require("dynlm")
require(xts)
require(forecast) # install.packages("forecast") # remove.packages("forecast")
require("functional") # install.packages("functional")
require(GenSA) # install.packages("GenSA")

require(pbapply) # progressbar fors lapply install.packages("prophet")
require(timeSeries) # fast Plots install.packages("orthogonalsplinebasis")
require("prophet")

#install_github("stefanrameseder/PartiallyFD")
# install("PartiallyFD") # For installing locally
require("PartiallyFD")

loadedLibraries <- search()[2:(length(search())-2)]


##########################################################################################
### Source functions

function_path   <- "R_Functions"
for(file in list.files(function_path)){
  source(paste0(function_path, "/", file))
  print(paste0(file, " was sourced"))
}
loadedFunctions <- ls()[ls() != "loadedLibraries"]

##########################################################################################
### Setup for variables


# Products ###############################################################################
PM   				  			<- c("POS", "NEG")
HTNT 				  			<- c("HT", "NT")
PMHTNT							<- c("POS_HT", "POS_NT", "NEG_HT", "NEG_NT")
rla            			<- "SRL"
PriceTypes      		<- c("LP", "AP") # "LP" or "AP"
pmhtnt 							<- PMHTNT[1]
pricetype 					<- PriceTypes[1]
########################################################################################## 
