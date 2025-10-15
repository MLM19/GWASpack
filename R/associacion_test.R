#' Association Testing Framework
#'
#' @description
#' Defines the base and derived classes for running GWAS association tests
#' using summary-level data.
#'
#' @details
#' This file provides a flexible structure for implementing different analysis
#' strategies, such as linear models or meta-analyses. Each method extends the
#' base `AssociationTest` class and implements a `run()` method.
#'
#' This approach makes it easy to add new test types without changing existing code.
#'
#' @section Classes:
#' * `AssociationTest` — Abstract base class
#' * `LinearAssociation` — Simple implementation for continuous traits
#'
#' @examples
#' \dontrun{
#' model <- LinearAssociation$new(data = std_data)
#' results <- model$run()
#' }
#' @seealso [create_pipeline()], [clean_sumstats()]
#' @export
