

#TestProbes RGSetExt (RGChannelSetExtended)

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