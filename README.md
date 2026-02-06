<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Documentation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css">
    <style>
        body {
            font-family: -apple-system, sans-serif;
            line-height: 1.6;
            max-width: 850px;
            margin: auto;
            padding: 40px 20px;
            color: #24292f;
        }

        /* Nagłówek i Logo */
        .header { display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; }
        .logo { width: 120px; height: auto; }
        .badges { margin-bottom: 20px; }
        .badges img { margin-right: 5px; margin-bottom: 5px; }

        /* Tabela porównawcza */
        .comparison-table { width: 100%; border-collapse: collapse; margin: 25px 0; table-layout: fixed; }
        .comparison-table th, .comparison-table td { 
            border: 1px solid #d0d7de; padding: 10px; vertical-align: top; background: #fff;
        }
        .comparison-table th { background: #f6f8fa; }
        .comparison-table pre { margin: 0; padding: 0; background: transparent; font-size: 12px; }

        /* Alerty (Note/Tip) - Czysty Styl */
        .alert {
            padding: 15px;
            margin: 20px 0;
            border-left: 5px solid;
            border-radius: 3px;
            background: #f8f9fa;
        }
        .alert-note { border-color: #0969da; background: #f0f7ff; }
        .alert-tip { border-color: #1a7f37; background: #f0fff4; }
        .alert-title { font-weight: bold; margin-bottom: 5px; display: block; }

        /* Ogólne */
        code { background: #f3f3f3; padding: 2px 4px; border-radius: 3px; font-family: monospace; }
        pre code { display: block; padding: 15px; overflow-x: auto; background: #f6f8fa; border-radius: 6px; }
        h1 { border-bottom: 1px solid #eaecef; padding-bottom: 10px; }
    </style>
</head>
<body>

<div class="header">
    <div class="badges">
        <a href="https://CRAN.R-project.org/package=testthatdocs"><img src="https://www.r-pkg.org/badges/version/testthatdocs" alt="CRAN"></a>
        <a href="https://github.com/urniaz/testthatdoc/actions"><img src="https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg" alt="Check"></a>
        <img src="https://img.shields.io/cran/l/testthatdocs" alt="License">
    </div>
    <img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" class="logo">
</div>

<h1>One-click documentation for testthat</h1>

<h3>Installation</h3>
<pre><code class="language-r">install.packages("testthatdocs")</code></pre>

<h3>Usage</h3>
<pre><code class="language-r">testthatdocs::document()</code></pre>

<table class="comparison-table">
    <tr>
        <th>Before</th>
        <th>After</th>
    </tr>
    <tr>
        <td><pre><code class="language-r"># - Section A
context("demo")
test_that("A: one", {
  expect_true(TRUE)
})</code></pre></td>
        <td><pre><code class="language-r">#' @testsList
#' @testsItem 1.1.1 A: one
context("demo")
test_that("A: one", {
  expect_true(TRUE)
})</code></pre></td>
    </tr>
</table>

<div class="alert alert-note">
    <span class="alert-title">ℹ️ NOTE</span>
    Generuje globalną listę testów oraz sekcje jako komentarze roxygen. Wstawia je bezpośrednio pod markerami.
</div>

<div class="alert alert-tip">
    <span class="alert-title">💡 TIP</span>
    Funkcja jest <b>idempotentna</b> – nadpisuje tylko treść między markerami, nie dotykając reszty Twojego kodu.
</div>

<h3>Templates</h3>
<p>Dostępne szablony numeracji:</p>
<ul>
    <li><code>"simple"</code>: <code>{g}</code></li>
    <li><code>"advanced"</code>: <code>{g}.{s}.{i}</code></li>
</ul>

<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/r.min.js"></script>
<script>hljs.highlightAll();</script>

</body>
</html>
