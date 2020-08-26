# melonProbes

The melonProbes R package provides a simple and elegant way to test frequently low quality or problematic probes in DNA methylation microarray data by consulting lists that have been bioinformatically determined. 

For both lists (450k, and EPIC), the probe design has been queried by others and identified probes that are known to cross-hybridise or have underlying SNPs within their probe sequence. We extend these probe lists by using more than 30,000 450K array samples to identify probes which are frequently and technically low quality.

These include checking beta-values, detection P values, beadcounts, variation and minor allele frequencies. This tool can be used alongside Zhou's or Pidsley's probelists and is compatible with methylumi and minfi objects with additional generic functions for alternative frameworks. testProbes method will be adapted to bigmelon package, too. 

While it would be important to test all probes for potential problems, the default parameters are set up so the most problematic probes (therefore least likely to be reproduced) are tested. However with the correct parameters you will be able to test all probes. We strongly suggest to customize parameters in line with the requirements and data nature. 

## Installation
The melonProbes package can be install using `devtools`
```
devtools::install_github('gizemaliskan/melonProbes')
```

## Features
We provide Pidsley and Zhou probe lists too.
Can filter probe-lists with this or even test data for problems.

## Usage

```
library(wateRmelon)
library(minfiData)
library(melonProbes)
# Load in either of the probelists
data(melonProbes450k)
data(melonProbesEpic)

#Test MethylumiSet object 

data("melon") #wateRmelon
 
testPmelon <- testProbes(melon)

#return is Methylumiset object and analysis can be seen under testPmelon@featureData@data[["Variation"]]

#Test RGChannelSet object

data(RGsetEx) #minfiData

testRG <- testProbes(RGsetEx)

#return is a logical list of DetectionP and Variation for each probe. intersection of TRUEs for bad and problematic probes.
```

## To Do
* Add probes + test for probes that are in HW equilibrium
