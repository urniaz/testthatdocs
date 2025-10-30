## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
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

## ----eval=FALSE---------------------------------------------------------------
# library(testthatdocs)
# 
# all_res <- document(
#   root = system.file("examples", package="testthatdocs"),
#   template = "advanced",
#   section_prefix = "# -",
#   encoding = "UTF-8",
#   backup = TRUE,
#   write = TRUE,
#   quiet = TRUE
# )
# 
# # Combined table (with 'file' column)
# all_res$listing

