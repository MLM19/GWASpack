#' Component Interfaces
#'
#' @description
#' Defines the abstract interfaces (generic functions) for all major steps
#' in the GWAS summary statistics analysis workflow.
#' Each module implements one or more of these interfaces.
#'
#' @details
#' This structure ensures each component can be replaced or extended
#' without breaking the overall pipeline. It keeps the design flexible
#' and supports consistent input/output across all processing stages.
#'
#' @section Interfaces:
#' * `load_data()` — Import GWAS summary statistics
#' * `standardize_data()` — Harmonize column names
#' * `clean_data()` — Apply quality control and filtering
#' * `run_analysis()` — Perform association testing
#' * `plot_results()` — Generate GWAS plots
#'
#' @seealso [AssociationTest], [LinearAssociation]
#' @keywords internal