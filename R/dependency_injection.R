#' Build and Connect Pipeline Components
#'
#' @description
#' Creates a modular analysis pipeline by combining independent components
#' (loader, standardizer, cleaner, tester, plotter) into a single workflow.
#'
#' @details
#' This design makes the system flexible and easy to extend. You can swap or
#' add components without changing the rest of the pipeline.
#' 
#' The function `create_pipeline()` builds a list of connected functions and
#' classes that define the full GWAS workflow.
#'
#' @param loader Function used to load summary statistics.
#' @param standardizer Function used to standardize column names.
#' @param cleaner Function used to clean and filter data.
#' @param tester Class instance that performs association testing.
#' @param plotter Function used to visualize the results.
#' @return A list of connected components forming a GWAS analysis pipeline.
#' @examples
#' \dontrun{
#' pipeline <- create_pipeline(
#'   loader = load_sumstats,
#'   standardizer = standardize_columns,
#'   cleaner = clean_sumstats,
#'   tester = LinearAssociation$new(),
#'   plotter = plot_manhattan
#' )
#' }
#' @seealso [run_gwas_pipeline()]
#' @export
