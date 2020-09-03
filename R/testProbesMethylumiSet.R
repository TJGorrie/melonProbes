
#testProbes MethyLumi (MethyLumiSet)

setMethod( f="testProbes",
          signature(betas="MethyLumiSet"),
          definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                nb = nb, np = np, nvar = nvar, ot,
                                nbCount = nbCount, nbThresh = nbThresh, pvCount = pvCount, pvThresh = pvThresh, nvarThresh = nvarThresh)
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
             nb = nb, np = np, nvar = nvar, ot=ot,
             nbCount = nbCount, nbThresh = nbThresh, pvCount = pvCount, pvThresh = pvThresh, nvarThresh = nvarThresh)



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


 