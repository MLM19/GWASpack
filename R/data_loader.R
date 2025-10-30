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

# Library dependencies
library(data.table)
library(dplyr)

# main function (high-level, clear steps)
data_loader <- function(file_path, separator = NULL) {
    # 1) Setup and logging
    file_name <- basename(file_path)
    message("Loading dataset: ", file_name) # TRACKER

    # 2) Decide which separator to use (caller override or per-extension default)
    sep_to_use <- determine_separator(file_name, separator)

    # 3) Attempt to read using the chosen separator
    data <- tryCatch(
        read_with_sep(file_path, file_name, sep_to_use),
        error = function(e) stop("Failed to read file: ", e$message)
    )

    # 4) Sanity check: ensure file parsed into multiple columns; let user fix separator if necessary
    check_result <- check_and_fix_separator(data, file_path, file_name, sep_to_use)
    data <- check_result$data
    sep_to_use <- check_result$sep

    # 5) Final validations
    if (nrow(data) == 0) {
        stop("The dataset is empty: ", file_name)
    }

    # (further checks / column mapping would go here)

    # 6) Return the loaded data.table
    data
}

# helper functions (below main so they are grouped in the helper section)
normalize_sep <- function(s) {
    # Turn user-friendly inputs into an actual separator character or NULL.
    # Accepts: NULL, "", "tab", "\t", "\\t", ",", ";", " " etc.
    if (is.null(s) || !nzchar(as.character(s))) return(NULL)
    s_trim <- trimws(as.character(s))
    if (s_trim %in% c("\\t", "\\\\t", "tab")) return("\t")
    s_trim
}

determine_separator <- function(file_name, user_separator) {
    # If the caller passed a separator, normalize and use it.
    if (!is.null(user_separator) && nzchar(as.character(user_separator))) {
        ns <- normalize_sep(user_separator)
        if (!is.null(ns)) return(ns)
    }

    # Otherwise pick a sensible default depending on file extension.
    # CSV => comma, TSV/TXT => tab, fallback => tab.
    if (grepl("\\.csv$", file_name, ignore.case = TRUE)) {
        return(",")
    }
    if (grepl("\\.tsv$", file_name, ignore.case = TRUE) ||
        grepl("\\.txt$", file_name, ignore.case = TRUE)) {
        return("\t")
    }
    # If it's a .gz we don't know the inner extension; default to tab but allow override.
    if (grepl("\\.gz$", file_name, ignore.case = TRUE)) {
        return("\t")
    }
    # final fallback
    return("\t")
}

read_with_sep <- function(file_path, file_name, sep) {
    # Read supported file types; gz is handled via gunzip -c so we can still pass sep.
    if (grepl("\\.tsv$", file_name, ignore.case = TRUE) ||
        grepl("\\.txt$", file_name, ignore.case = TRUE) ||
        grepl("\\.csv$", file_name, ignore.case = TRUE) ||
        grepl("\\.gz$", file_name, ignore.case = TRUE)) {
        return(fread(file_path, sep = sep, header = TRUE))
    } else {
    stop("Unsupported file format: ", file_name)
    }
}

check_and_fix_separator <- function(data, file_path, file_name, sep_to_use) {
    # Returns a list with data and the separator actually used.
    col_count <- ncol(data)
    if (col_count > 1) {
        # everything looks OK
        return(list(data = data, sep = sep_to_use))
    }

    # Single-column result — likely wrong separator. Inform the user what was used.
    used_label <- ifelse(identical(sep_to_use, "\t"), "\\t", sep_to_use)
    message("Read result: ", col_count, " column(s) found using separator '", used_label, "'. This usually means the separator is incorrect.")

    # If R is running non-interactively (Rscript, CI, etc.) we cannot prompt the user.
    # interactive() returns TRUE for RStudio / R console sessions and FALSE for Rscript/batch.
    if (!interactive()) {
        stop("Non-interactive session: cannot prompt for a new separator. Re-run data_loader() with the correct separator (e.g. separator = ',' or separator = '\\t').")
    }

    # Interactive: let the user try different separators until a multi-column read succeeds.
    repeat {
        user_input <- readline("Enter correct separator (e.g. ',', '\\t', 'tab', ';') or press Enter to abort: ")

        # empty input => abort
        if (!nzchar(user_input)) {
            stop("Aborted by user. Provide the correct separator via the 'separator' argument when calling data_loader().")
        }

        # normalize user input (so 'tab', '\t', '\\t' all map to actual tab)
        user_sep <- normalize_sep(user_input)
        if (is.null(user_sep)) {
            message("Could not interpret separator '", user_input, "'. Try again.")
            next
        }

        # attempt to read with the user-provided separator; catch errors to continue the loop
        data_try <- tryCatch(
            read_with_sep(file_path, file_name, user_sep),
            error = function(e) e
        )

        if (inherits(data_try, "error")) {
            # failed to read (bad path, permissions, or other fread error)
            message("Read failed: ", data_try$message)
            next
        }

        # check the column count for the new attempt
        new_col_count <- ncol(data_try)
        if (new_col_count <= 1) {
            message("Still wrong separator: found ", new_col_count, " column(s). Try a different separator.")
            next
        }

        # success: return the corrected data and separator
        message("Successfully read file with separator '", ifelse(identical(user_sep, "\t"), "\\t", user_sep), "'. Columns found: ", new_col_count)
        return(list(data = data_try, sep = user_sep))
    }
}

prompt_and_load <- function(prompt = "Enter full path to GWAS file: ") {
    if (!interactive()) stop("prompt_and_load() requires an interactive R session.")
    file_path <- readline(prompt)
    if (!nzchar(trimws(file_path))) stop("No file path entered. Aborting.")
    data_loader(file_path)
}