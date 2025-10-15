#' GWAS Result Visualization
#'
#' @description
#' Creates plots for GWAS results, including Manhattan and QQ plots.
#' These visualizations help interpret genome-wide association findings.
#'
#' @details
#' Focuses on visualizing analysis outputs only. Each plot is built from
#' standardized, cleaned data and can be customized or extended with
#' additional layers, styles, or annotations.
#'
#' All plots can be exported to common file formats such as PNG, PDF, or SVG
#' using `ggsave()` or similar functions from **ggplot2**. This allows users
#' to easily integrate plots into reports or publications.
#'
#' @param results A `data.frame` containing GWAS results with columns
#'   such as `CHR`, `BP`, and `P`.
#' @param output_path Optional. If provided, the plot will be automatically
#'   saved to this path (e.g., `"results/manhattan_plot.png"`).
#' @param plot_type Type of plot to generate: `"manhattan"` (default) or `"qq"`.
#' @return A `ggplot` object showing the results. If `output_path` is provided,
#'   the plot is also saved to disk.
#' @examples
#' \dontrun{
#' # Create and display a Manhattan plot
#' plot_manhattan(results)
#'
#' # Save plot to file
#' plot_manhattan(results, output_path = "manhattan_plot.png")
#' }
#' @seealso [run_gwas_pipeline()], [ggplot2::ggsave()]
#' @export
