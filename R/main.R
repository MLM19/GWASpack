#' Main Pipeline Coordination
#'
#' @description
#' This script defines the pipeline functions for the GWASpack package.
#' It coordinates the complete workflow for GWAS summary statistics:
#' loading, standardizing, cleaning, analyzing, and visualizing results.
#'
#' @details
#' Focuses only on managing the pipeline flow. Each processing step is handled
#' by a dedicated, independent component. This design keeps the code modular,
#' easy to extend, and simple to maintain.
#' Depends on abstractions injected through the `create_pipeline()` function.
#'
#' @seealso [create_pipeline()], [load_sumstats()], [standardize_columns()],
#' [clean_sumstats()], [LinearAssociation], [plot_manhattan]
#'
#' @examples
#' \dontrun{
#' run_gwas_pipeline("path/to/sumstats.txt")
#' }
#' @keywords internal