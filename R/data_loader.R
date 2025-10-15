#' Load GWAS Summary Statistics
#'
#' @description
#' Imports GWAS summary statistics from text-based files such as `.txt`, `.tsv`,
#' `.csv`, or compressed `.gz` formats.
#'
#' @details
#' Handles only data import. The goal is to read the data efficiently and return
#' it in a consistent structure for later processing. The function can be extended
#' to support new file formats or loaders.
#'
#' Typical columns include SNP ID, chromosome, position, alleles, effect size,
#' standard error, p-value, and sample size.
#'
#' @param file_path Path to the GWAS summary statistics file.
#' @return A `data.table` containing the loaded summary statistics.
#' @seealso [standardize_columns()]
#' @examples
#' \dontrun{
#' data <- load_sumstats("sumstats.txt")
#' }
#' @export
