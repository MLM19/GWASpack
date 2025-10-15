#' Clean and Filter GWAS Summary Statistics
#'
#' @description
#' Applies quality control (QC) and filtering to standardized GWAS summary data.
#' Removes invalid or incomplete entries and checks data consistency.
#'
#' @details
#' This step ensures the dataset is valid for downstream analyses. Typical
#' operations include removing missing values, filtering invalid p-values,
#' and ensuring alleles are not duplicated (A1 != A2).
#'
#' @param data A standardized `data.frame` or `data.table` of GWAS summary statistics.
#' @return A cleaned data frame ready for analysis.
#' @examples
#' \dontrun{
#' cleaned <- clean_sumstats(std_data)
#' }
#' @seealso [standardize_columns()]
#' @export
