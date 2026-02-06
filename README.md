[![CRAN status](https://www.r-pkg.org/badges/version/testthatdocs)](https://CRAN.R-project.org/package=testthatdocs)
[![R-CMD-check](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67)](https://app.codacy.com/gh/urniaz/testthatdocs/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade) 
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

<table>
<tr>
<th>Before</th>
<th>After</th>
</tr>
<tr>
<td>
<div class="highlight highlight-source-r notranslate position-relative overflow-auto" dir="auto"><pre><span class="pl-c"><span class="pl-c">#</span> This is a demo test file</span>

<span class="pl-c"><span class="pl-c">#</span> - Section A</span>
context(<span class="pl-s"><span class="pl-pds">"</span>demo<span class="pl-pds">"</span></span>)
test_that(<span class="pl-s"><span class="pl-pds">"</span>A: literal one<span class="pl-pds">"</span></span>, {
  expect_true(<span class="pl-c1">TRUE</span>)
})

test_that(paste(<span class="pl-s"><span class="pl-pds">"</span>A:<span class="pl-pds">"</span></span>, <span class="pl-c1">2</span>), {
  expect_true(<span class="pl-c1">TRUE</span>)
})

<span class="pl-c"><span class="pl-c">#</span>' @testsSection Section B</span>
<span class="pl-c"><span class="pl-c">#</span>' @testsItem OLD to be removed</span>
<span class="pl-c"><span class="pl-c">#</span>' @testsItem OLD 2</span>
test_that(<span class="pl-e">glue</span><span class="pl-k">::</span>glue(<span class="pl-s"><span class="pl-pds">"</span>B-{x}<span class="pl-pds">"</span></span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>), {
  expect_true(<span class="pl-c1">TRUE</span>)
})

test_that(<span class="pl-s"><span class="pl-pds">"</span>Outside<span class="pl-pds">"</span></span>, {
  expect_true(<span class="pl-c1">TRUE</span>)
})</pre><div class="zeroclipboard-container">
    <clipboard-copy aria-label="Copy" class="ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 d-flex flex-justify-center flex-items-center" data-copy-feedback="Copied!" data-tooltip-direction="w" value="# This is a demo test file

# - Section A
context(&quot;demo&quot;)
test_that(&quot;A: literal one&quot;, {
  expect_true(TRUE)
})

test_that(paste(&quot;A:&quot;, 2), {
  expect_true(TRUE)
})

#' @testsSection Section B
#' @testsItem OLD to be removed
#' @testsItem OLD 2
test_that(glue::glue(&quot;B-{x}&quot;, x = 3), {
  expect_true(TRUE)
})

test_that(&quot;Outside&quot;, {
  expect_true(TRUE)
})" tabindex="0" role="button">
      <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-copy js-clipboard-copy-icon">
    <path d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 0 1 0 1.5h-1.5a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-1.5a.75.75 0 0 1 1.5 0v1.5A1.75 1.75 0 0 1 9.25 16h-7.5A1.75 1.75 0 0 1 0 14.25Z"></path><path d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0 1 14.25 11h-7.5A1.75 1.75 0 0 1 5 9.25Zm1.75-.25a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z"></path>
</svg>
      <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-check js-clipboard-check-icon color-fg-success d-none">
    <path d="M13.78 4.22a.75.75 0 0 1 0 1.06l-7.25 7.25a.75.75 0 0 1-1.06 0L2.22 9.28a.751.751 0 0 1 .018-1.042.751.751 0 0 1 1.042-.018L6 10.94l6.72-6.72a.75.75 0 0 1 1.06 0Z"></path>
</svg>
    </clipboard-copy>
  </div></div>
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

> [!NOTE] 
> - Generates a **global list of tests** and **per-section test listings** as roxygen comments.
> - Inserts the generated listings immediately after the corresponding markers.

> [!TIP]
> - The function is **idempotent**:
>   + Only replaces content between existing `@testsList` and `@testsSection` markers.
>   + Leaves all other code and comments unchanged.
> - If section headers are provided using a plain-text prefix (e.g. `# -`):
>   + They are automatically converted to roxygen markers `#' @testsSection`.
>   + Any text following the prefix is treated as the **section title**.

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




