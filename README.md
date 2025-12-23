[![CRAN status](https://www.r-pkg.org/badges/version/testthatdocs)](https://CRAN.R-project.org/package=testthatdocs)
[![R-CMD-check](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67)](https://app.codacy.com/gh/urniaz/ShinyWizard/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade) 
[![Circle CI Badge](https://img.shields.io/badge/build-passing-brightgreen?style=flat&label=circleci)](https://app.circleci.com/pipelines/github/urniaz?circle-token=79db963de7c13c1570f70cb8ac1c77a5) 
![CRAN/METACRAN License](https://img.shields.io/cran/l/testthatdocs)  
![CRAN/METACRAN Version](https://img.shields.io/cran/v/testthatdocs)

<a href="#"><img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="30%" style="pointer-events: none"/></a>
One-click documentation for testthat

### Installation

`install.packages("testthatdocs")`

### Usage 

`testthatdocs::document()`

### Key Features


- Automatically generates roxygen-style listings:
  - `#' @testsList` – global list of all tests.
  - `#' @testsSection` – section-specific lists.
  - `#' @testsItem` – numbered entries for each test.
- Two numbering templates:
  - `"simple"` → `{g}`
  - `"advanced"` → `{g}.{s}.{i}.{l}`


