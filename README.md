# melonProbes

The melonProbes R package provides a simple and elegant way to test frequently low quality or problematic probes in DNA methylation microarray data by consulting lists that have been bioinformatically determined. 

For both lists (450k, and EPIC), the probe design has been queried by others and identified probes that are known to cross-hybridise or have underlying SNPs within their probe sequence. We extend these probe lists by using more than 30,000 450K array samples to identify probes which are frequently and technically low quality.

These include checking detection P values, beadcounts, variation and minor allele frequencies. This tool can be used alongside Zhou's or Pidsley's probelists and will be compatible with methylumi, minfi and bigmelon objects with additional generic functions for alternative frameworks. 

While it would be important to test all probes for potential problems, the default parameters are set up so the most problematic probes (therefore least likely to be reproduced) are tested. However with the correct parameters you will be able to test all probes. 

## Installation
The melonProbes package can be install using `devtools`
```
devtools::install_github('tjgorrie/melonProbes')
```

## Features
We provide Pidsley and Zhou probe lists too.
Can filter probe-lists with this or even test data for problems.

## Usage

```
library(wateRmelon)
library(melonProbes)
# Load in either of the probelists
data(melonProbes450k)
data(melonProbesEpic)

# Select probes to filter using a selection of probes or filters 
(Latter Columns (with numeric values)) indicate % of datasets a probe fails certain properties

data(melon) 
# Generic Example, test only problematic probes (skipping beadcounts)
testProbes(betas(melon), manifest='450k', 
           beadcount = NULL, detection = pvals(melon), ot = fData(melon)[,fot(melon)])

# Generic Example, test all probes!
testProbes(betas(melon), manifest='450k', 
           beadcount = NULL, detection = pvals(melon), ot = fData(melon)[,fot(melon)],
           nb = 0, np = 0, nvar =0)

```

## To Do
* Methods for methylumisets (methylumi) and RGChannelsets (minfi)
* Add probes + test for probes that are in HW equilibrium
