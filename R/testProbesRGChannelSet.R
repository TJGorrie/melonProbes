

#TestProbes RGSet (RGChannelSet)

setMethod(f= "testProbes",
          signature(betas="RGChannelSet"),
          definition=function(
            betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
            nb = nb, np = np, nvar =nvar, ot,
            nbCount = nbCount, nbThresh = nbThresh, pvCount = pvCount, pvThresh = pvThresh, nvarThresh = nvarThresh)
        
              { betasP <- preprocessRaw(betas)
            
                #betas of object
                betRG <- getBeta(betasP)
                
                #ot
                ot <- got(betasP)
                
                
                #beadcount
                beadcount <- NULL
                message("No beadCounts available")
                
                #detectionP
                dp <- detectionP(betas)
                
                
                
              out <-  testProbes(betas=betRG,manifest = c('450k', 'EPIC'), beadcounts = beadcount, detection = dp, 
                           nb = nb, np = np, nvar = nvar, ot=ot,
                           nbCount = nbCount, nbThresh = nbThresh, pvCount = pvCount, pvThresh = pvThresh, nvarThresh = nvarThresh)  
            
                

                return(out)
  
                
                 }
              )