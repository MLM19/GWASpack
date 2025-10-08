#' GWAS S4 Class
#'
#' @slot summary_stats Data.frame of GWAS summary statistics
#' @slot metadata List containing study metadata
setClass(
  "GWAS",
  slots = c(
    summary_stats = "data.frame",
    metadata = "list"
  )
)

#' GWAS Constructor
#'
#' @param summary_stats Data.frame of GWAS summary statistics
#' @param metadata List containing study metadata
#' @return An object of class GWAS
GWAS <- function(summary_stats = data.frame(), metadata = list()) {
  new("GWAS", summary_stats = summary_stats, metadata = metadata)
}