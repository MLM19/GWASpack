#placeholder
library(testthat)

test_that("load_sumstats reads a simple file", {
  # create temporary CSV
  tmp <- tempfile(fileext = ".tsv")
  writeLines(c("rsid\tchromosome\tposition\tbeta\tpval",
               "rs1\t1\t100\t0.1\t0.05",
               "rs2\t1\t200\t-0.2\t0.001"), tmp)

  df <- load_sumstats(tmp)
  expect_s3_class(df, "data.table") # or data.frame depending on your impl
  expect_true(all(c("rsid", "chromosome", "position", "beta", "pval") %in% names(df)))
})