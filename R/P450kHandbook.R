#' MelonProbes450k Dataframe Handbook
#' @aliases {melonProbes, 450k, melonProbes450k, P450kHandbook}
#' @description {This table provides information about DNA methylation 450k array probes. 
#' Some of these probes are low quality and problematic. In order to detect these probes,
#' each probes are tested for p-value, bead count, variation and also checked for mapping
#' on HG19 and HG38 human genome assemblies.}
#' @examples {data(melonProbes450k)}
#' @export 
 
#' @keywords {melonProbes, 450k, 450kprobes, badprobes, datasets}
#' @param Zhou_HG19: {a logical vector, it is TRUE when that probe presents in ZHou's probelists and perfectly fits its position on HG19 human genome assembly}
#' @param Zhou_GH38: Logical vector represents probes which can be found on Zhou's probelist and map on HG38 human assembly
#' @param PercLowVariation: A value between 0 and 1, represents percentage of low variable probes
#' @param PercBadbc: A value between 0 and 1, describes percentage of bad bead count for this probe
#' @param PercBadPv: A value between 0 and 1, represents percentage of bad P value for that particular probe
#' @source https://github.com/TJGorrie/melonProbes
#' @seealso before using this package, please read these articles to understand variables better
#' @references Pidsley, R., Zotenko, E., Peters, T. J., Lawrence, M. G., Risbridger, G. P., Molloy, P., Van Djik, S., Muhlhausler, B., Stirzaker, C. and Clark, S. J. (2016) Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling.Genome Biol, 17, 208.
#' @references Zhou, W., Laird, P. W. and Shen, H. (2017) Comprehensive characterization, annotation and innovative use of Infinium DNA methylation BeadChip probes. Nucleic Acids Res, 45, e22.
#' 
