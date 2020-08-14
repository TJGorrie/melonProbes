
#messages for other object types

#GenomicRatioSet

setMethod( f="testProbes",
           signature(betas="GenomicRatioSet"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                 nb = .2, np = .2, nvar =.5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
           {message("We are sorry. For running testProbes function, using RGChannelSetExtended or MEthylumiSet object is strongly recommended.")
             
           })

#MethylSet

setMethod( f="testProbes",
           signature(betas="MethylSet"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                 nb = .2, np = .2, nvar =.5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
           {message("We are sorry. For running testProbes function, using RGChannelSetExtended or MEthylumiSet object is strongly recommended.")
             
           })

#RatioSet

setMethod( f="testProbes",
           signature(betas="RatioSet"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                 nb = .2, np = .2, nvar =.5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
           {message("We are sorry. For running testProbes function, using RGChannelSetExtended or MEthylumiSet object is strongly recommended.")
             
           })

#GenomicMethylSet

setMethod( f="testProbes",
           signature(betas="GenomicMethylSet"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                 nb = .2, np = .2, nvar =.5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
           {message("We are sorry. For running testProbes function, using RGChannelSetExtended or MEthylumiSet object is strongly recommended.")
             
           })

#MethylumiQC

setMethod( f="testProbes",
           signature(betas="MethylumiQC"),
           definition = function(betas,manifest = c('450k', 'EPIC'), beadcounts = NULL, detection = NULL, 
                                 nb = .2, np = .2, nvar =.5, ot,
                                 nbCount = 3, nbThresh = 0.05, pvCount = 0.05, pvThresh = 0.01, nvarThresh = 0.05)
           {message("We are sorry. For running testProbes function, using RGChannelSetExtended or MEthylumiSet object is strongly recommended.")
             
           })