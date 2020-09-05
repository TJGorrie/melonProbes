#testProbes methods examples

#Generic function

data("RGsetEx") #from minfiData

preprocessed.RG <- preprocessRaw(RGsetEx) #converting Red/Green channel into methylation signal

beta.RGsetEx <- getBeta(preprocessed.RG) #extracting beta-values from object

testRG <- testProbes(beta.RGsetEx, ot=ot) 

#Return is a logical list of Variation for each probe. TRUEs are for failed probes. 

#Raw data object of minfi (RGChannelSetExtended)

toydat <- RGsetEx.sub #from minfiData

class(toydat) <- "RGChannelSetExtended" #generating simple RGChannelSetExtended object

nbeads <- matrix(as.integer(rnorm(1938,mean=5, sd=1)), 1938,6) #adding bead counts into the object

nbeads[nbeads<0] <-0

assays(toydat, withDimnames= FALSE)$NBeads <- nbeads

test_Toydata <- testProbes(toydat)

#Return is a logical list of detectionP and Variation. TRUEs for failed probes

#Raw data object of Methylumi (MethylumiSet)

data(melon) #from wateRmelon
 
testPmelon <- testProbes(melon)

#Return is methylumiSet object and analysis can be seen under testPmelon@featureData@data[["Variation"]]

#Raw data object of minfi (RGChannel)

data("RGsetEx") #from minfiData

testRG <- testProbes(RGsetEx)

#Return is a logical list of detectionP and Variation. TRUEs for failure

