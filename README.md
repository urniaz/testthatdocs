<!doctype html>
<html lang="pl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>testthatdocs – One-click documentation for testthat</title>

  <!-- Minimal, Pages-friendly styling -->
  <style>
    :root {
      --border: #d0d7de;
      --note: #0969da;
      --tip: #1a7f37;
      --text: #24292f;
      --muted: #57606a;
      --bg: #ffffff;
    }

    body {
      margin: 0;
      padding: 28px 18px;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
      color: var(--text);
      background: var(--bg);
      line-height: 1.5;
    }

    .container {
      max-width: 980px;
      margin: 0 auto;
    }

    /* Badges */
    .badges img {
      height: 20px;
      vertical-align: middle;
      margin: 0 6px 8px 0;
    }

    /* Float logo with text wrap (opływające) */
    .logo-wrap {
      float: right;
      width: 30%;
      max-width: 260px;
      min-width: 140px;
      margin: 6px 0 14px 18px; /* space between text and image */
    }
    .logo-wrap img {
      width: 100%;
      height: auto;
      display: block;
      pointer-events: none;
    }

    /* Clear float after the intro section */
    .clearfix::after {
      content: "";
      display: block;
      clear: both;
    }

    h1 { margin: 8px 0 10px; font-size: 2rem; }
    h3 { margin: 22px 0 10px; font-size: 1.25rem; }

    p { margin: 10px 0; color: var(--text); }
    small, .muted { color: var(--muted); }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 16px 0;
      table-layout: fixed;
    }
    th, td {
      border: 1px solid var(--border);
      padding: 10px;
      vertical-align: top;
    }
    th { background: #f6f8fa; text-align: left; }

    /* Callouts */
    .callout {
      border: 1px solid var(--border);
      border-left-width: 6px;
      padding: 12px 14px;
      border-radius: 10px;
      margin: 16px 0;
      background: #fbfbfc;
    }
    .callout strong {
      display: inline-block;
      margin-bottom: 6px;
      letter-spacing: .2px;
    }
    .callout.note { border-left-color: var(--note); }
    .callout.tip  { border-left-color: var(--tip); }

    code { font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace; }
    pre { overflow: auto; margin: 0; }

    /* Make code blocks look good even without Prism */
    pre code {
      display: block;
      padding: 12px 14px;
      border-radius: 10px;
      border: 1px solid var(--border);
      background: #f6f8fa;
      font-size: 0.95rem;
      line-height: 1.45;
      white-space: pre;
    }

    /* Optional: slightly reduce code size inside table cells */
    td pre code { font-size: 0.9rem; }

    /* Mobile tweaks */
    @media (max-width: 860px) {
      .logo-wrap { float: none; width: 220px; margin: 6px 0 14px 0; }
      table { table-layout: auto; }
    }
  </style>

  <!-- Syntax highlighting (GitHub Pages-friendly). GitHub README may ignore external scripts; Pages will work. -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/themes/prism.min.css">
  <script defer src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/prism.min.js"></script>
  <script defer src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-r.min.js"></script>
</head>

<body>
  <div class="container">

    <!-- Badges -->
    <p class="badges">
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

    <div class="clearfix">
      <!-- Float logo (opływające) -->
      <a class="logo-wrap" href="#">
        <img
          src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true"
          alt="logo"
        />
      </a>

      <h1>One-click documentation for testthat</h1>
    </div>

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

    <div class="callout note">
      <strong>NOTE</strong>
      <ul>
        <li>Generates a <strong>global list of tests</strong> and <strong>per-section test listings</strong> as roxygen comments.</li>
        <li>Inserts the generated listings immediately after the corresponding markers.</li>
      </ul>
    </div>

    <div class="callout tip">
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

  </div>
</body>
</html>
