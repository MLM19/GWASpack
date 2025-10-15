#' Standardize Column Names
#'
#' @description
#' Harmonizes column names from different GWAS datasets into a standard format
#' (e.g., `SNP`, `CHR`, `BP`, `A1`, `A2`, `BETA`, `SE`, `P`, `N`).
#'
#' @details
#' Ensures consistent column naming across studies so downstream steps can
#' rely on the same variable names. Users can customize mappings dynamically
#' to match their dataset’s column labels.
#'
#' @param data A `data.frame` or `data.table` of GWAS summary statistics.
#' @param mapping A named list mapping standard names to dataset-specific columns.
#'   Example: `list(SNP = "rsid", CHR = "chromosome")`.
#' @return A data frame with standardized column names.
#' @examples
#' df <- data.frame(rsid = "rs1", chromosome = 1, position = 100, beta = 0.2, pval = 0.01)
#' standardize_columns(df)
#' @seealso [load_sumstats()]
#' @export
