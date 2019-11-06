#' Test Illumina CpG Probes for potential issues
#'
#' Tests Illumina CpGs for potential issues that affect a given proportion of datasets. Useful for removing hits that may be unlikely to be reproduced
#'
#' @param betas A matrix contain beta values, or a RGChannelSetExtended, or a methylumiset
#' @param manifest Specify which manifest to use
#' @param beadcounts Default: NULL, provide with a matrix containing beadcounts
#' @param detection Default: NULL, provide with a matrix containing detection P values
#' @param nb A value between 0 and 1, represents the \% of datasets a probe has failed in. Default is 0.2 (20\%) however all probes can be tested by specifing a value of 0.
#' @param np A value between 0 and 1, represents the \% of datasets a probe has failed in. Default is 0.2 (20\%) however all probes can be tested by specifing a value of 0.
#' @param nvar A value between 0 and 1, represents the \% of datasets a probe has failed in. Default is 0.5 (50\%) however all probes can be tested by specifing a value of 0.
#' @param ot A character vector describing the probe design for CpGs (must contain 'I' and 'II')
#' @param nbCount The beadcount to test probes in your dataset against
#' @param nbThresh The proportion of samples 
#' @param pvCount The detection p value to test probes in your dataset against
#' @param pvThresh The proportion of samples to which a probe can fail in
#' @param nvarThresh The percentile of variation a probe can be in.
#'
#' @return A data.frame of nrow(betas) x 3 columns specifying which probes have failed which tests.
#'
#' @examples
#' #
#' 
#' @author Tyler Gorrie-Stone \email{tgorri@essex.ac.uk}
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

    manifest <- manifest[intersect(rownames(manifest), rownames(betas)),]
    out <- list()
    if(!is.null(beadcounts)){
    # Test beadcounts
    badbc <- manifest$PercBadBc > nb
    badbcRelative <- (rowSums(beadcounts[badbc,] <= nbCount, na.rm = TRUE) / ncol(beadcounts)) > 0.05
    message(paste0(sum(badbcRelative), ' of ', sum(badbc), ' have a beadcount <= ', nbCount, ' in more than ', nbThresh*100 , '% of samples.'))
    out[['BeadCounts']] = rownames(betas) %in% names(which(badbcRelative))
    }
    if(!is.null(detection)){
    # Test p-values
    badpv <- manifest$PercBadPv > np
    badpvRelative <- (rowSums(detection[badpv,] > pvCount, na.rm = TRUE) / ncol(detection)) > pvThresh
    message(paste0(sum(badpvRelative), ' of ', sum(badpv), ' have a detection p > ', pvCount, ' in more than ', pvThresh*100 , '% of samples.'))
    out[['DetectionP']] = rownames(betas) %in% names(which(badpvRelative))
    }
    # Test variance
    # betas to test...
    badvar <- manifest$PercLowVariation > nvar
    sds <- rowSds(betas, na.rm=T)
    I <- ot == 'I'
    II <- ot == 'II'
    tofill <- vector('numeric', length(sds))
    tofill[I] <- trunc(rank(sds[I]))/length(sds[I])
    tofill[II] <- trunc(rank(sds[II]))/length(sds[II])

    low <- tofill < nvarThresh

    bad_lowi <- badvar & I & low
    bad_lowii <- badvar & II & low

	message(paste0(sum(bad_lowi), ' of ', sum(badvar & I), ' are ranked in the bottom ', nvarThresh*100, 'th percentile of Type I probes.'))
	message(paste0(sum(bad_lowi), ' of ', sum(badvar & II), ' are ranked in the bottom ', nvarThresh*100, 'th percentile of Type II probes.'))
    out[['Variation']] = low
    # Test HW Snps
    # Currently missing D:

    df <- data.frame(out)
    rownames(df) <- rownames(betas)
    return(df)
}

#' Dataframe containing potentially bad probes for 450K microarray data
#'
#' Dataframe containing potentially bad probes for 450K microarray data
#'
#' @format A data frame with 800,000 rows and 9 variables:
#' \describe{
#'   \item{Zhou_HG19}{Logical Vector of CpGs that are marked TRUE in Zhou's General Masking column for HG19}
#'   \item{Zhou_HG38}{Logical Vector of CpGs that are marked TRUE in Zhou's General Masking column for HG38}
#'   \item{PercLowVariation}{Numeric Vector describing the number of times a CpG is ranked in bottom 5th percentile of variation}
#'   \item{PercBadBc}{Numeric Vector describing the number of times a CpG has a beadcount  4 in 5 of samples.}
#'   \item{PercBadPv}{Numeric Vector describing the number of times a CpG has a detection p value  0.05 in 1 of samples.}	
#' }
#'
#' @usage data(melonProbes450k)
#' 
#' @examples
#'     data(melonProbes450k)
#'
#' @source 
#'     \url{http://zwdzwd.github.io/InfiniumAnnotation}
#'         
#'    Pidsley, R., Zotenko, E., Peters, T.J. et al. Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling. Genome Biol 17, 208 (2016) doi:10.1186\/s13059-016-1066-1
"melonProbes450k"

#' Dataframe containing potentially bad probes for 450K microarray data
#'
#' Dataframe containing potentially bad probes for EPIC microarray data
#'
#' @format A data frame with 800,000 rows and 9 variables:
#' \describe{
#'   \item{Zhou_HG19}{Logical Vector of CpGs that are marked TRUE in Zhou's General Masking column for HG19}
#'   \item{Zhou_HG38}{Logical Vector of CpGs that are marked TRUE in Zhou's General Masking column for HG38}
#'   \item{Pidsley_CrossReactive}{Logical Vector of CpGs that are marked TRUE if identified to be cross-reactive by Pidsley et al.}
#'   \item{Pidsley_GeneVariant_Body}{Logical Vector of CpGs that are marked TRUE if identified to have a SNP variant within the body of the probe by Pidsley et al.}
#'   \item{Pidsley_Overlap_Gene}{Logical Vector of CpGs that are marked TRUE if identified to have multiple genes mapping to the same CpG by Pidsley et al.}
#'   \item{Pidsley_GeneVariant_Extension}{Logical Vector of CpGs that are marked TRUE if identified to have a SNP in the probe single base extension identified by Pidsley et al.}
#'   \item{PercLowVariation}{Numeric Vector describing the number of times a CpG is ranked in bottom 5th percentile of variation}
#'   \item{PercBadBc}{Numeric Vector describing the number of times a CpG has a beadcount 4 in 5 of samples.}
#'   \item{PercBadPv}{Numeric Vector describing the number of times a CpG has a detection p value 0.05 in 1 of samples.}
#' }
#'
#' @usage data(melonProbesEpic)
#' 
#' @examples
#'     data(melonProbesEpic)
#'
#' @source 
#'     \url{http://zwdzwd.github.io/InfiniumAnnotation}
#'         
#'     Pidsley, R., Zotenko, E., Peters, T.J. et al. Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling. Genome Biol 17, 208 (2016) doi:10.1186/s13059-016-1066-1
"melonProbesEpic"
