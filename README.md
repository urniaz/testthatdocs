<!-- Badges -->
<p>
  <a href="https://CRAN.R-project.org/package=testthatdocs">
    <img alt="CRAN status" src="https://www.r-pkg.org/badges/version/testthatdocs">
  </a>
  <a href="https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml">
    <img alt="R-CMD-check" src="https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg">
  </a>
  <a href="https://app.codacy.com/gh/urniaz/testthatdocs/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade">
    <img alt="Codacy Badge" src="https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67">
  </a>
  <img alt="CRAN/METACRAN License" src="https://img.shields.io/cran/l/testthatdocs">
</p>

<!-- Logo (right aligned) -->
<p align="right">
  <a href="#">
    <img
      src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true"
      alt="logo"
      width="30%"
    />
  </a>
</p>

<h1>One-click documentation for testthat</h1>

<h3>Installation</h3>

<pre><code class="language-r">install.packages("testthatdocs")</code></pre>

<h3>Usage</h3>

<pre><code class="language-r">testthatdocs::document()</code></pre>

<h3>Example</h3>

<pre><code class="language-r">testthatdocs::document(template = "advanced")</code></pre>

<table>
  <thead>
    <tr>
      <th>Before</th>
      <th>After</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <pre><code class="language-r"># This is a demo test file

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
})</code></pre>
      </td>
      <td>
        <pre><code class="language-r">#' @testsList
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
})</code></pre>
      </td>
    </tr>
  </tbody>
</table>

<!-- NOTE box -->
<div style="border:1px solid #d0d7de; border-left:6px solid #0969da; padding:12px 14px; border-radius:8px; margin:16px 0;">
  <strong>NOTE</strong>
  <ul>
    <li>Generates a <strong>global list of tests</strong> and <strong>per-section test listings</strong> as roxygen comments.</li>
    <li>Inserts the generated listings immediately after the corresponding markers.</li>
  </ul>
</div>

<!-- TIP box -->
<div style="border:1px solid #d0d7de; border-left:6px solid #1a7f37; padding:12px 14px; border-radius:8px; margin:16px 0;">
  <strong>TIP</strong>
  <ul>
    <li>The function is <strong>idempotent</strong>:
      <ul>
        <li>Only replaces content between existing <code>@testsList</code> and <code>@testsSection</code> markers.</li>
        <li>Leaves all other code and comments unchanged.</li>
      </ul>
    </li>
    <li>If section headers are provided using a plain-text prefix (e.g. <code># -</code>):
      <ul>
        <li>They are automatically converted to roxygen markers <code>#' @testsSection</code>.</li>
        <li>Any text following the prefix is treated as the <strong>section title</strong>.</li>
      </ul>
    </li>
  </ul>
</div>

<h3>Numbering and Templates</h3>

<p>Numbering is customisable via <strong>templates</strong> that use <strong>placeholders</strong>:</p>

<ul>
  <li><code>{g}</code> – global incremental index across all tests</li>
  <li><code>{s}</code> – section index (1-based, in order of appearance)</li>
  <li><code>{i}</code> – local index within a section (1-based)</li>
  <li><code>{l}</code> – line index (line number in the final, modified text)</li>
</ul>

<p>The following templates are available:</p>

<ul>
  <li><code>"simple"</code> → <code>{g}</code></li>
  <li><code>"advanced"</code> → <code>{g}.{s}.{i}</code></li>
  <li><code>"full"</code> → <code>{g}.{s}.{i}.{l}</code></li>
</ul>

<p>You can fully override the numbering format by providing custom values for:</p>

<ul>
  <li><code>global_fmt</code></li>
  <li><code>section_fmt</code></li>
</ul>

<p>This allows complete control over how numbers are generated.</p>
