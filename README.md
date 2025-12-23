[![CRAN status](https://www.r-pkg.org/badges/version/testthatdocs)](https://CRAN.R-project.org/package=testthatdocs)
[![R-CMD-check](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67)](https://app.codacy.com/gh/urniaz/ShinyWizard/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade) 
![CRAN/METACRAN License](https://img.shields.io/cran/l/testthatdocs)  

<a href="#"><img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="30%" style="pointer-events: none; z-index:999;"/></a>

# One-click documentation for testthat

### Installation

```r
install.packages("testthatdocs")
```

### Usage 

```r
testthatdocs::document()
```

### Example

```r
testthatdocs::document(template = "advanced")
```
> [!NOTE] 
> - Generates a **global list of tests** and **per-section test listings** as roxygen comments.
> -Inserts the generated listings immediately after the corresponding markers.

> [!TIP]
> - The function is **idempotent**:
>  - Only replaces content between existing `@testsList` and `@testsSection` markers.
>  - Leaves all other code and comments unchanged.
> - If section headers are provided using a plain-text prefix (e.g. `# -`):
>  - They are automatically converted to roxygen markers `#' @testsSection`.
 >  - Any text following the prefix is treated as the **section title**.

<table>
<tr>
<th>Before</th>
<th>After</th>
</tr>
<tr>
<td>

```r
# This is a demo test file

# - Section A
context("demo")
test_that("A: literal one", {
  expect_true(TRUE)
})

test_that(paste("A:", 2), {
  expect_true(TRUE)
})

#' @testsSection Section B
#' @testsItem OLD to be removed
#' @testsItem OLD 2
test_that(glue::glue("B-{x}", x = 3), {
  expect_true(TRUE)
})

test_that("Outside", {
  expect_true(TRUE)
})
```
</td>
<td>

```r
#' @testsList
#' @testsItem 1.1.1 A: literal one
#' @testsItem 2.1.2 paste("A:", 2)
#' @testsItem 3.2.1 glue::glue("B-{x}", x = 3)
#' @testsItem 4.2.2 Outside
# This is a demo test file

#' @testsSection Section A
#' @testsItem 1.1.1 A: literal one
#' @testsItem 2.1.2 paste("A:", 2)
context("demo")
test_that("A: literal one", {
  expect_true(TRUE)
})

test_that(paste("A:", 2), {
  expect_true(TRUE)
})

#' @testsSection Section B
#' @testsItem 3.2.1 glue::glue("B-{x}", x = 3)
#' @testsItem 4.2.2 Outside
test_that(glue::glue("B-{x}", x = 3), {
  expect_true(TRUE)
})

test_that("Outside", {
  expect_true(TRUE)
})
```

</td>
</tr>
</table>

### Numbering and Templates

Numbering is customisable via **templates** that use **placeholders**:

- `{g}` – global incremental index across all tests  
- `{s}` – section index (1-based, in order of appearance)  
- `{i}` – local index within a section (1-based)  
- `{l}` – line index (line number in the final, modified text)

The following templates are available:

- `"simple"` → `{g}`
- `"advanced"` → `{g}.{s}.{i}`
- `"full"` → `{g}.{s}.{i}.{l}`

You can fully override the numbering format by providing custom values for:

- `global_fmt`
- `section_fmt`

This allows complete control over how numbers are generated.




