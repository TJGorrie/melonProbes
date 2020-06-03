#testProbes(betas(myset), ot=ot)-> x

#testProbes MethyLumi (MethyLumiSet)

setMethod( f="testProbes",
          signature(betas="MethyLumiSet"),
          definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                nb = .2, np = .2, nvar =.5, ot,
                                nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
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
      message("No beadCount available")
  
  }
  
  
  # beadc<-function(x){
  #length(which(is.na(x)=="TRUE"))}  not working for methylumiSet

  
  
#detection 
  pval <- pval(betas)
  testProbes(betas=bet,manifest = c('450k', 'EPIC'), beadcounts = bc, detection = pval, 
             nb = .2, np = .2, nvar =.5, ot=ot,
             nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
})
 