# melonProbes

melonProbes provides a very simple and elegant way to test common problems in DNA methylation microarray data by consulting bioinformatically determined probes which have known problems.

The probelist was determined from using more than 30,000 450K array samples as seeks to identify probes which suffer the same problems that many other datasets have.

These include checking detection P values, beadcounts, variation and minor allele frequencies. This tool can be used alongside Zhou's probelist and is compatible with methylumi, minfi and bigmelon objects with additional generic functions for alternative frameworks. While it is important to test all probes I am providing this package as a means to quickly screen out any probes that may lead to spurious association.

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

# Select probes to filter using a selection of probes or filters (Latter Columns (with numeric values)) indicate % of datasets a probe fails certain properties
```