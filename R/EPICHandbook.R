#' @title MelonProbeEPIC Dataframe Handbook
#' @aliases EPICHandbook, EPIC, MelonProbes, melonprobes
#'@description There are 865918 Infinium Human DNA Metylation EPIC array probes and 9 variables
#'
#'@param Zhou_HG19: Logical vector shows which probe presents in Zhou's probelist and match on HG19 human reference genome
#'@param Zhou_GH38: Logical vector represents probes which can be found on Zhou's probelist and map on HG38 human assembly
#'@param Pidsley_CrossReactive: Logical vector depicts as TRUE when the probe has multiple bindind affinity determined by Pidsley et al.
#'@param Pidsley_GeneVariant_Body: Logical vector of probes which is identified as TRUE when 'SNP' and 'INDEL' variants overlap in the EPIC probes
#'@param Pidsley_Overlap_Gene: Logical vector of probes which is marked as TRUE when the probe matches more than one gene
#'@param Pidsley_GeneVariant_Extension: Logical vector of probes can be TRUE if it is identified as a SNP within the probe single base extension identified by Pidsley et al.
#'@param PercLowVariation: A value between 0 and 1, represents percentage of low variable probes
#'@param PercBadbc: A value between 0 and 1, describes percentage of bad bead count for this probe
#'@param PercBadPv: A value between 0 and 1, represents percentage of bad P value for that particular probe
#'
#'
#'@seealso before using this package, please read these articles to understand variables better
#'@references Pidsley, R., Zotenko, E., Peters, T. J., Lawrence, M. G., Risbridger, G. P., Molloy, P., Van Djik, S., Muhlhausler, B., Stirzaker, C. and Clark, S. J. (2016) Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling.Genome Biol, 17, 208.
#'@references Zhou, W., Laird, P. W. and Shen, H. (2017) Comprehensive characterization, annotation and innovative use of Infinium DNA methylation BeadChip probes. Nucleic Acids Res, 45, e22.
#' 
NULL
