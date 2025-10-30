The **testthatdocs** package provides utilities for generating structured, idempotent listings of `test_that()` blocks in R test files.  
It automatically creates both global and section-specific listings using roxygen-style comment markers.

These listings make it easier to navigate, audit, and document your tests, and they integrate naturally with pkgdown and roxygen2 documentation workflows.

# Install from CRAN 

install.packages("testthatdocs")

---

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
