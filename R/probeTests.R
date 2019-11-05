#' Test Illumina CpG Probes for potential issues
#'
#' Tests Illumina CpGs for potential issues that affect a given proportion of datasets. Useful for removing hits that may be unlikely to be reproduced
#'
#' @param betas placeholder
#' @param manifest placeholder
#' @param beadcounts placeholder
#' @param detection placeholder
#' @param nb placeholder
#' @param np placeholder
#' @param nvar placeholder
#' @param ot placeholder
#'
#' @return Logical vector of probes to filter
#'
#' @examples
#' 
#' @author Tyler Gorrie-Stone \email{tgorri@essex.ac.uk}
#' @seealso 
#' @keywords 
#' @export
testProbes <- function(betas, manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
	                   nb = .2, np = .2, nvar =.5, ot,
	                   nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05){
    manifest <- match.arg(manifest)
    switch(manifest,
    	'450k' = {
    		data(melonProbes450k)
    		manifest <- melonProbes450k
    	},
    	'EPIC' = {
    		message('Potentially bad probes only identified for 450k data, only these will be tested')
    		data(melonProbesEpic)
    		manifest <- melonProbesEpic
    	}
    ) 
    if(!is.null(beadcounts)){
    # Test beadcounts
    badbc <- manifest$PercBadBc > nb
    badbcRelative <- (rowSums(beadcounts[badbc,] <= nbCount, na.rm = TRUE) / ncol(beadcounts)) > 0.05
    message(paste0(sum(badbcRelative), ' of ', sum(badbc), ' have a beadcount <= ', nbCount, ' in more than ', nbThresh*100 , '% of samples.'))
    }
    if(!is.null(detection)){
    # Test p-values
    badpv <- manifest$PercBadPv > np
    badpvRelative <- (rowSums(detection[badpv,] > pvCount, na.rm = TRUE) / ncol(detection)) > pvThresh
    message(paste0(sum(badpvRelative), ' of ', sum(badpv), ' have a beadcount <= ', pvCount, ' in more than ', pvThresh*100 , '% of samples.'))
    }
    # Test variance
    # betas to test...
    badvar <- manifest$PercLowVariation > nvar
    sds <- rowSds(betas, na.rm=T)
    gv1 <- perc.rank(sds[ot == 'I']) 
    gv2 <- perc.rank(sds[ot == 'II']) 

    lowi  <- gv1 <= nvarThresh
    lowii <- gv2 <= nvarThresh

	message(paste0(sum(badpvRelative), ' of ', sum(badpv), ' have a beadcount <= ', pvCount, ' in more than ', pvThresh*100 , '% of samples.'))
	message(paste0(sum(badpvRelative), ' of ', sum(badpv), ' have a beadcount <= ', pvCount, ' in more than ', pvThresh*100 , '% of samples.'))

    
    # Test HW Snps
    # Currently missing D:
}

setGeneric(name="testProbes")

setMethod(
   f= "testProbes",
   signature(betas="MethyLumiSet"),
   definition=function(betas, manifest = c('450k', 'EPIC'), beadcounts, detection, 
	                   nb = .2, np = .2, nvar =.5, ot,
	                   nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05){

})

setMethod(
   f= "pfilter",
   signature(betas="RGChannelSetExtended"),
   definition=function(betas, manifest = c('450k', 'EPIC'), beadcounts, detection, 
	                   nb = .2, np = .2, nvar =.5, ot,
	                   nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05){

   })

perc.rank <- function(x) trunc(rank(x))/length(x)
