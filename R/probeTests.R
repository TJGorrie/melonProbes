#' Test Illumina CpG Probes for potential problems
#'
#' Test Illumina CpG probes for potential problems, useful for removing hits that may be unlikely to be reproduced
#'
#' @aliases testProbes methylumi, testProbes methylumiSet, testProbes minfi, testProbes RGChannelSet, testProbes RGChannelSetExtended
#' 
#' @param betas A matrix contain beta values, or a RGChannelSet(Extended), or a methylumiSet
#' @param manifest Specify which manifest to use
#' @param beadcounts Default: NULL, provide with a matrix containing beadcounts. Bead counts values will be used in calculation of nb for each probe.
#' @param detection Default: NULL, provide with a matrix containing detection P values.Detection p-values will be used in calculation of np for each probe.
#' @param nb A value between 0 and 1, the percentage of dataset a probe has failed in bead count. Probes failed in more than 20\% of datasets in terms of bead count will be filtered out. However, all probes can be tested by nb=0.
#' @param np A value between 0 and 1, the percentage of dataset a probe has failed in detection p-value. Probes failed in more than 20\% of datasets in terms of detection p-values will be filtered out. However, all probes can be tested by np=0.
#' @param nvar A value between 0 and 1, sample variance is used to filter out low variance having probes. Nvar parameter is adjusted to 0.5 which means the probe showing a low variation for more than 50\% of the time will be failed in test. The last two messages clarify how many type I and type II probes were determined within the 5\% in terms of variation.
#' @param ot a character vector representing the types of probes as I or II. 
#' @param nbCount refers to physical bead counts to test the probes determined as lower than 3.
#' @param nbTresh a proportion of the sample. The TestProbes function filters probes when the nbCount is less than 3 (<3) and nbThresh > 5\% of the samples. 
#' @param pvCount the detection p-value to test probes. Default is 0.05 (5\%).
#' @param pvThresh the detection p-value threshold, corresponding to > 0.01 value. Probes are failed when they show > 0.05 detection p-value in > 1\% of samples.
#' @param nvarThresh the density of variation a probe can be in. 
#'
#' @return 
#' For minfi package & beta-values: A data.frame of nrow(betas) x 3 columns specifying which probes have failed which tests.
#' 
#' For methylumi package: MethylumiSet object. Analysis is stored under betas@featureData@data$Variation.
#' @examples
#' data("melon") #Sample dataset from wateRmelon package
#' betas <- betas(melon) #extracting beta values from melon object
#' test_betas <- testProbes(betas, ot = ot)
#' 
#' library(minfiData)
#' data("RGsetEx")
#' test_RG <- testProbes(RGsetEx)
#' 
#' data("melon")
#' test_melon <- testProbes(melon)
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
    badbc <- manifest$PercBadBc >= nb
    badbcRelative <- (rowSums(beadcounts[badbc,] <= nbCount, na.rm = TRUE) / ncol(beadcounts)) > 0.05
    message(paste0(sum(badbcRelative), ' of ', sum(badbc), ' have a beadcount <= ', nbCount, ' in more than ', nbThresh*100 , '% of samples.'))
    out[['BeadCounts']] = rownames(betas) %in% names(which(badbcRelative))
    }
    if(!is.null(detection)){
    # Test p-values
    badpv <- manifest$PercBadPv >= np
    badpvRelative <- (rowSums(detection[badpv,] > pvCount, na.rm = TRUE) / ncol(detection)) > pvThresh
    message(paste0(sum(badpvRelative), ' of ', sum(badpv), ' have a detection p > ', pvCount, ' in more than ', pvThresh*100 , '% of samples.'))
    out[['DetectionP']] = rownames(betas) %in% names(which(badpvRelative))
    }
    # Test variance
    # betas to test...
    badvar <- manifest$PercLowVariation >= nvar
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
setMethod(f= "testProbes",
          signature(betas="RGChannelSetExtended"),
          definition=function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, 
                              detection = NULL, nb = .2, np = .2, nvar = .5, ot,
                              nbCount = 3, nbThresh = 0.05, pvCount = 0.05, 
                              pvThresh = 0.01, nvarThresh = 0.05)
            
          { betasP <- preprocessRaw(betas)
          
          #betas of object
          betRG <- getBeta(betasP)
          
          #ot
          ot <- got(betasP)
          
          #beadcount
          beadcount <- beadcount(betas)
          
          
          #detectionP
          dp <- detectionP(betas)
          
          out <-  testProbes(betas=betRG,manifest = c('450k', 'EPIC'), 
                             beadcounts = beadcount, detection = dp, nb = nb, np = np,
                             nvar = nvar, ot = ot,nbCount = nbCount, nbThresh = nbThresh,
                             pvCount = pvCount, pvThresh = pvThresh, 
                             nvarThresh = nvarThresh)  
          
          return(out)
          
          
          }
)

setMethod( f="testProbes",
           signature(betas="MethyLumiSet"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, 
                                 detection = NULL, nb = .2, np = .2, nvar = .5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, 
                                 pvThresh = 0.01, nvarThresh = 0.05)
           {
             #betas of MethylumiSet object            
             bet <- betas(betas)
             #probe types column name
             ds <- fot(betas)
             ot <- betas@featureData@data[,ds]
             
             #beadcounts
             if(exists("NBeads", assayData(betas))){
               bc       <- assayData(betas)$NBeads
               bc[bc<3] <- NA
             } else { 
               bc       <- NULL
               message("No beadCounts available")}
             
             #detection 
             pv <- betas@assayData$pval
             out <- testProbes(betas=bet,manifest = c('450k', 'EPIC'), beadcounts = bc, 
                               detection = pv, nb = nb, np = np, nvar = nvar, ot=ot,
                               nbCount = nbCount, nbThresh = nbThresh, pvCount = pvCount, 
                               pvThresh = pvThresh, nvarThresh = nvarThresh)
             
             
             history.submitted <- as.character(Sys.time())
             history.finished <-as.character(Sys.time())
             history.command <- "Filtered by testProbes method (melonProbes)"
             betas@history <- rbind(betas@history, data.frame( 
               submitted = history.submitted,
               finished = history.finished,
               command = history.command))
             
             fData(betas) <- cbind(fData(betas),out)
             return(betas)
             
           })



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
