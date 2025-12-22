<!-- Podstawowe -->
![License](https://img.shields.io/github/license/urniaz/testthatdocs)
![Stars](https://img.shields.io/github/stars/urniaz/testthatdocs?style=flat)
![Forks](https://img.shields.io/github/forks/urniaz/testthatdocs?style=flat)
![Issues](https://img.shields.io/github/issues/urniaz/testthatdocs)
![PRs](https://img.shields.io/github/issues-pr/urniaz/testthatdocs)
![Last commit](https://img.shields.io/github/last-commit/urniaz/testthatdocs)

<!-- Release / tag -->
![Release](https://img.shields.io/github/v/release/urniaz/testthatdocs)
![Tag](https://img.shields.io/github/v/tag/urniaz/testthatdocs)

<!-- Aktywność / statystyki -->
![Contributors](https://img.shields.io/github/contributors/urniaz/testthatdocs)
![Repo size](https://img.shields.io/github/repo-size/urniaz/testthatdocs)
![Code size](https://img.shields.io/github/languages/code-size/urniaz/testthatdocs)
![Top language](https://img.shields.io/github/languages/top/urniaz/testthatdocs)
![Languages](https://img.shields.io/github/languages/count/urniaz/testthatdocs)

<!-- Status workflow (GitHub Actions) – zmień NAZWA_WORKFLOW.yml -->
![CI](https://img.shields.io/github/actions/workflow/status/urniaz/testthatdocs/NAZWA_WORKFLOW.yml)

<!-- Opcjonalnie: “maintained” / wersja -->
![Maintained](https://img.shields.io/maintenance/yes/2025)


<a href="#"><img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="25%" style="pointer-events: none;"/></a>
<H1 style="text-decoration: none;"> One-click documentation for testthat </H1>
<H3> Install from CRAN </H3> 

`install.packages("testthatdocs")`

<H3> Run </H3>

`testthatdocs::document()`

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
- Fully idempotent — listings are replaced, not duplicated.
- Handles both single files and full testthat directories.

