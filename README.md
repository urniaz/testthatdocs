[![CRAN status](https://www.r-pkg.org/badges/version/testthatdocs)](https://CRAN.R-project.org/package=testthatdocs)
[![R-CMD-check](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67)](https://app.codacy.com/gh/urniaz/ShinyWizard/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade) 
![CRAN/METACRAN License](https://img.shields.io/cran/l/testthatdocs)  

<a href="#"><img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="30%" style="pointer-events: none; z-index:999;"/></a>

# One-click documentation for testthat

### Installation

```
install.packages("testthatdocs")
```

### Usage 

```
testthatdocs::document()
```

### Example

TBA

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




