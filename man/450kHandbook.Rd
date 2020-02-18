\name{MelonProbes450kHandbook}
\alias{MelonProbes450kHandbook, 450k, melonprobes, MelonProbes}
\title{MelonProbes450k Dataframe Handbook

}
\description{ This table provides information about DNA methylation 450k array probes. Some of these probes are low quality and problematic. In order to detect these probes, each probes are tested for p-value, bead count, variation and also checked for mapping on HG19 and HG38 human genome assemblies.

}
\usage{data("MelonProbes450kHandbook")}
\format{
  A data frame with 485577 DNA methylation 450k array probes on the following 5 variables.
  \describe{ There are 485577 DNA methylation 450k probes and 5 variables
    \item{\Zhou_HG19}{a logical vector, it is TRUE when that probe presents in ZHou's probelists and perfectly fits its position on HG19 human genome assembly }
    \item{\Zhou_HG38}{a logical vector, it is marked TRUE if this probe found in Zhou's probelist and mapped on HG38}
    \item{PercLowVariation}{A numeric vector, } }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ https://github.com/TJGorrie/melonProbes ~~
}
\references{
%%  ~~ Pidsley, R., Zotenko, E., Peters, T. J., Lawrence, M. G., Risbridger, G. P., Molloy, P., Van Djik, S., Muhlhausler, B., Stirzaker, C. and Clark, S. J. (2016) Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling.Genome Biol, 17, 208. ~~
%%  ~~ Zhou, W., Laird, P. W. and Shen, H. (2017) Comprehensive characterization, annotation and innovative use of Infinium DNA methylation BeadChip probes. Nucleic Acids Res, 45, e22. ~~
}
\examples{
data(MelonProbes450kHandbook)
## maybe str(MelonProbes450kHandbook) ; plot(MelonProbes450kHandbook) ...
}
\keyword{datasets}
