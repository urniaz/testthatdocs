## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## ----eval=FALSE---------------------------------------------------------------
# library(testthatdocs)
# 
# res <- document_file(
#   path = system.file("examples", "tests_sample_before.R", package="testthatdocs"),
#   section_prefix = "# -",
#   template = "advanced",   # or "simple"
#   encoding = "UTF-8",
#   backup = TRUE,
#   write = TRUE
# )
# 
# # Summary of tests
# res$listing
# 
# # Modified test file
# res$text

