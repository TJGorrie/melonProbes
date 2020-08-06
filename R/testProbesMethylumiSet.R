
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
      message("No beadCounts available")
  
  }

  
#detection 
  pv <- betas@assayData$pval
  out <- testProbes(betas=bet,manifest = c('450k', 'EPIC'), beadcounts = bc, detection = pv, 
             nb = .2, np = .2, nvar =.5, ot=ot,
             nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)



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


 