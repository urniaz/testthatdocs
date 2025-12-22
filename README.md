<!-- Podstawowe -->
![License](https://img.shields.io/github/license/TWOJ_LOGIN/TWOJE_REPO)
![Stars](https://img.shields.io/github/stars/TWOJ_LOGIN/TWOJE_REPO?style=flat)
![Forks](https://img.shields.io/github/forks/TWOJ_LOGIN/TWOJE_REPO?style=flat)
![Issues](https://img.shields.io/github/issues/TWOJ_LOGIN/TWOJE_REPO)
![PRs](https://img.shields.io/github/issues-pr/TWOJ_LOGIN/TWOJE_REPO)
![Last commit](https://img.shields.io/github/last-commit/TWOJ_LOGIN/TWOJE_REPO)

<!-- Release / tag -->
![Release](https://img.shields.io/github/v/release/TWOJ_LOGIN/TWOJE_REPO)
![Tag](https://img.shields.io/github/v/tag/TWOJ_LOGIN/TWOJE_REPO)

<!-- Aktywność / statystyki -->
![Contributors](https://img.shields.io/github/contributors/TWOJ_LOGIN/TWOJE_REPO)
![Repo size](https://img.shields.io/github/repo-size/TWOJ_LOGIN/TWOJE_REPO)
![Code size](https://img.shields.io/github/languages/code-size/TWOJ_LOGIN/TWOJE_REPO)
![Top language](https://img.shields.io/github/languages/top/TWOJ_LOGIN/TWOJE_REPO)
![Languages](https://img.shields.io/github/languages/count/TWOJ_LOGIN/TWOJE_REPO)

<!-- Status workflow (GitHub Actions) – zmień NAZWA_WORKFLOW.yml -->
![CI](https://img.shields.io/github/actions/workflow/status/TWOJ_LOGIN/TWOJE_REPO/NAZWA_WORKFLOW.yml)

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

