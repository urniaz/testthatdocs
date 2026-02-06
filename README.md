<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Testthatdocs Documentation</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css">

    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: #24292f;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Podstawowe style dla linków i obrazków */
        a { color: #0969da; text-decoration: none; }
        a:hover { text-decoration: underline; }
        img { max-width: 100%; }

        /* Style dla bloków kodu */
        pre {
            background-color: #f6f8fa;
            border-radius: 6px;
            padding: 16px;
            overflow: auto;
        }

        /* Style dla tabeli (Before/After) */
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #d0d7de;
            padding: 8px;
            vertical-align: top; /* Ważne dla porównania kodu */
        }
        th {
            background-color: #f6f8fa;
            text-align: left;
        }

        /* --- Style a'la GitHub Alerts (Note & Tip) --- */
        blockquote.alert {
            border-left: 4px solid;
            padding: 10px 15px;
            margin: 20px 0;
            border-radius: 0 6px 6px 0;
            position: relative;
        }
        
        blockquote.alert p { margin: 5px 0; }
        blockquote.alert strong { display: block; margin-bottom: 8px; }

        /* Styl dla NOTE (Niebieski) */
        blockquote.alert-note {
            background-color: #ddf4ff;
            border-left-color: #0969da;
            color: #0969da;
        }
        blockquote.alert-note p, blockquote.alert-note ul {
            color: #1f2328; /* Powrót do czarnego tekstu dla treści */
        }

        /* Styl dla TIP (Zielony) */
        blockquote.alert-tip {
            background-color: #dafbe1;
            border-left-color: #1a7f37;
            color: #1a7f37;
        }
        blockquote.alert-tip p, blockquote.alert-tip ul {
            color: #1f2328;
        }
    </style>
</head>
<body>

    <p>
      <a href="https://CRAN.R-project.org/package=testthatdocs">
        <img src="https://www.r-pkg.org/badges/version/testthatdocs" alt="CRAN status">
      </a>
      <a href="https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml">
        <img src="https://github.com/urniaz/testthatdoc/actions/workflows/R-CMD-check.yaml/badge.svg" alt="R-CMD-check">
      </a>
      <a href="https://app.codacy.com/gh/urniaz/testthatdocs/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade">
        <img src="https://app.codacy.com/project/badge/Grade/108904994aa84de89b5f933b0f33bc67" alt="Codacy Badge">
      </a> 
      <img src="https://img.shields.io/cran/l/testthatdocs" alt="CRAN/METACRAN License">
    </p>

    <a href="#">
      <img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo" align="right" width="30%" style="pointer-events: none; z-index:999;"/>
    </a>

    <h1>One-click documentation for testthat</h1>

    <h3>Installation</h3>
    <pre><code class="language-r">install.packages("testthatdocs")</code></pre>

    <h3>Usage</h3>
    <pre><code class="language-r">testthatdocs::document()</code></pre>

    <h3>Example</h3>
    <pre><code class="language-r">testthatdocs::document(template = "advanced")</code></pre>

    <table>
    <tr>
    <th>Before</th>
    <th>After</th>
    </tr>
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
    </table>

    <blockquote class="alert alert-note">
      <strong>NOTE</strong>
      <ul>
        <li>Generates a <strong>global list of tests</strong> and <strong>per-section test listings</strong> as roxygen comments.</li>
        <li>Inserts the generated listings immediately after the corresponding markers.</li>
      </ul>
    </blockquote>

    <blockquote class="alert alert-tip">
      <strong>TIP</strong>
      <ul>
        <li>The function is <strong>idempotent</strong>:
          <ul>
            <li>Only replaces content between existing <code>@testsList</code> and <code>@testsSection</code> markers.</li>
            <li>Leaves all other code and comments unchanged.</li>
          </ul>
        </li>
        <li>
