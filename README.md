Automated Unit Tests Documentation for testthat() 

#So simple as run  :

to see before 

and after


need lies of code ass {l} to the code ...


tyr and  test more

# install 


The **testthatdocs** package provides utilities for generating structured, idempotent listings of `test_that()` blocks in R test files.  
It automatically creates both global and section-specific listings using roxygen-style comment markers.

These listings make it easier to navigate, audit, and document your tests, and they integrate naturally with pkgdown and roxygen2 documentation workflows.

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

## Functions

### `generate_tests_listing(path, ... )`

Processes a single test file and adds or updates listings.

Example:

```r
source("generate_tests_listing.R")

res <- generate_tests_listing(
  path = "tests/testthat/test-alpha.R",
  section_prefix = "# -",
  template = "advanced",
  write = TRUE
)

print(res$listing)
```

### `generate_tests_listing_dir(root, ... )`

Recursively scans a directory (by default `tests/testthat`) and calls `generate_tests_listing()` for each file.

Example:

```r
res_all <- generate_tests_listing_dir(
  root = "tests/testthat",
  template = "advanced",
  write = TRUE
)

head(res_all$listing)
```

---

## Example Test File

Input file (`tests/testthat/test-alpha.R`):

```r
# - Alpha
test_that("alpha one", { expect_true(TRUE) })
test_that('alpha two', { expect_true(TRUE) })

# - Beta
test_that(paste("alpha", "three"), { expect_true(TRUE) })
```

After running `generate_tests_listing("tests/testthat/test-alpha.R")`:

```r
#' @testsList
#' @testsItem 1 alpha one
#' @testsItem 2 alpha two
#' @testsItem 3 paste("alpha", "three")

#' @testsSection Alpha
#' @testsItem 1 alpha one
#' @testsItem 2 alpha two

#' @testsSection Beta
#' @testsItem 1 paste("alpha", "three")
```

---

## Directory Example

```r
res_all <- generate_tests_listing_dir(
  root = "tests/testthat",
  template = "simple",
  make_backup = TRUE,
  write = TRUE
)

print(res_all$listing)
```

---

## Vignette

A detailed vignette is available under:

```
vignettes/tests-listing-vignette.Rmd
```

or online (after pkgdown build):

```
https://urniaz.github.io/testthatdocs/articles/tests-listing-vignette.html
```

---

## Author

Dr. Rafał Urniaż  
Email: rafal.urniaz@gmail.com  
GitHub: https://github.com/urniaz

---
