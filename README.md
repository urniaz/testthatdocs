The **testthatdocs** is one-click documentation for testthat unit tests, simply ... ![alt text](https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true)


# Install from CRAN 

`install.packages("testthatdocs")`

# and Run 

`testthatdocs::document()`

so simple as `devtools::document()`


## Key Features

- Scans `.R` test files for lines beginning with `test_that("title")`.
- Extracts test titles (as raw text or expressions).
- Automatically generates roxygen-style listings:
  - `#' @testsList` – global list of all tests.
  - `#' @testsSection` – section-specific lists.
  - `#' @testsItem` – numbered entries for each test.
- Two numbering templates:
  - `"simple"` → `{g}`
  - `"advanced"` → `{g}.{s}.{i}.{l}`
- Fully **idempotent** — listings are replaced, not duplicated.
- Handles both single files and full testthat directories.

---
