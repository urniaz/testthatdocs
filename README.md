[![CRAN status](https://www.r-pkg.org/badges/version/testthatdocs)](https://CRAN.R-project.org/package=testthatdocs)
[![R-CMD-check](https://github.com/urniaz/testthatdocs/actions/workflows/r.yaml/badge.svg)](https://github.com/urniaz/testthatdocs/actions/workflows/r.yaml)
[![Codecov coverage](https://codecov.io/gh/urniaz/testthatdocs/branch/main/graph/badge.svg)](https://codecov.io/gh/urniaz/testthatdocs)
[![CodeFactor](https://www.codefactor.io/repository/github/urniaz/testthatdocs/badge)](https://www.codefactor.io/repository/github/urniaz/testthatdocs)


<a href="#"><img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="30%" style="pointer-events: none"/></a>
# One-click documentation for testthat
### Install from CRAN

`install.packages("testthatdocs")`

### Run </H3>

`testthatdocs::document()`

### Key Features

- Scans `.R` test files for lines beginning with `test_that("title")`.
- Extracts test titles (as raw text or expressions).
- Automatically generates roxygen-style listings:
  - `#' @testsList` – global list of all tests.
  - `#' @testsSection` – section-specific lists.
  - `#' @testsItem` – numbered entries for each test.
- Two numbering templates:
  - `"simple"` → `{g}`
  - `"advanced"` → `{g}.{s}.{i}.{l}`
- Fully idempotent — listings are replaced, not duplicated.
- Handles both single files and full testthat directories.

