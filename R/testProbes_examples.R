#testProbes methods examples

#Beta

data("RGsetEx") #minfiData

preprocessed.RGsetEx <- preprocessRaw(RGsetEx)

beta.RGsetEx <- getBeta(preprocessed.RGsetEx)

testProbes.RGsetEx <- testProbes(beta.RGsetEx, ot=ot)

#Return is a logical list of Variation for each probe. TRUEs are for failed probes. 

#RGChannelSetExtended

toydat <- RGsetEx.sub #minfiData

class(toydat) <- "RGChannelSetExtended"

nbeads <- matrix(as.integer(rnorm(1938,mean=5, sd=1)), 1938,6)

nbeads[nbeads<0] <-0

assays(toydat, withDimnames= FALSE)$NBeads <- nbeads

test_Toydata <- testProbes(toydat)

#Return is logical list of detectionP and Variation. TRUEs for failed probes

#MethylumiSet

data(melon) #wateRmelon
 
testPmelon <- testProbes(melon)

#Return is methylumiSet object and analysis can be seen under testPmelon@featureData@data[["Variation"]]

#RGChannel

data("RGsetEx") #minfiData
testRG <- testProbes(RGsetEx)

#Return is logical list of detectionP and Variation. TRUEs for failure
