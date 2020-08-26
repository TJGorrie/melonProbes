#testProbes methods examples

#Beta

data("RGsetEx") #minfiData

preprocessed.RGsetEx <- preprocessRaw(RGsetEx)

beta.RGsetEx <- getBeta(preprocessed.RGsetEx)

testProbes.RGsetEx <- testProbes(beta.RGsetEx, ot=ot)

#RGChannelSetExtended

toydat <- RGsetEx.sub #minfiData

class(toydat) <- "RGChannelSetExtended"

nbeads <- matrix(as.integer(rnorm(1938,mean=5, sd=1)), 1938,6)

nbeads[nbeads<0] <-0

assays(toydat, withDimnames= FALSE)$NBeads <- nbeads

test_Toydata <- testProbes(toydat)

#MethylumiSet

data(melon) #wateRmelon
 
testPmelon <- testProbes(melon)

#RGChannel

data(RGsetEx) #minfiData

testRG <- testProbes(RGsetEx)