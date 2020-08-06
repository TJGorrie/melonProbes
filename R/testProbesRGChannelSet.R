

#TestProbes RGSet (RGChannelSet)

setMethod(f= "testProbes",
          signature(betas="RGChannelSet"),
          definition=function(
            betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
            nb = .2, np = .2, nvar =.5, ot,
            nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
        
              { #betas of object
                betRG <- getBeta(betas)
                
                #ot
                ot <- got(betas)
                
                #beadcount ??
                beadc<-function(x){
                length(which(is.na(x)=="TRUE"))}  
                beadcount <- beadc(betas)
                #detectionP
                dp <- detectionP(betas)
                
                out <- testProbes(betas=betRG,manifest = c('450k', 'EPIC'), beadcounts = beacount, detection = dp, 
                           nb = .2, np = .2, nvar =.5, ot=ot,
                           nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)  
            
                fData(betas) <- cbind(fData(betas),out)
                return(betas)
                
                 }
              )