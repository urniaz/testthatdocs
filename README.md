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

<markdown-accessiblity-table data-catalyst=""><table tabindex="0">
<tbody><tr>
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

<span class="pl-c"><span class="pl-c">#</span>' - Section B</span>
test_that(<span class="pl-e">glue</span><span class="pl-k">::</span>glue(<span class="pl-s"><span class="pl-pds">"</span>B-{x}<span class="pl-pds">"</span></span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>), {
  expect_true(<span class="pl-c1">TRUE</span>)
})

test_that(<span class="pl-s"><span class="pl-pds">"</span>Outside<span class="pl-pds">"</span></span>, {
  expect_true(<span class="pl-c1">TRUE</span>)
})</pre><div class="zeroclipboard-container">
      </div></div>
</td>
</tr>
</tbody></table></markdown-accessiblity-table>
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




