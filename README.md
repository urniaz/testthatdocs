<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Testthatdocs Documentation</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css">

    <style>
        /* --- Główny kontener a'la GitHub --- */
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
            font-size: 16px;
            line-height: 1.5;
            color: #24292f;
            background-color: #ffffff;
            max-width: 980px;
            margin: 0 auto;
            padding: 32px;
        }

        h1, h2, h3 {
            margin-top: 24px;
            margin-bottom: 16px;
            font-weight: 600;
            line-height: 1.25;
            border-bottom: 1px solid #d0d7de;
            padding-bottom: .3em;
        }
        h1 { font-size: 2em; border-bottom: none; } /* Główny tytuł bez linii */
        h3 { font-size: 1.25em; border-bottom: none; }

        a { color: #0969da; text-decoration: none; }
        a:hover { text-decoration: underline; }
        
        p { margin-bottom: 16px; }

        /* --- Header (Badges + Logo) --- */
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 32px;
            gap: 20px;
        }
        .badges {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            align-items: center;
        }
        .logo-container img {
            max-width: 200px; /* Ograniczenie wielkości logo */
            width: 100%;
            height: auto;
        }

        /* --- Blok Kodu --- */
        pre {
            background-color: #f6f8fa;
            border-radius: 6px;
            padding: 16px;
            overflow: auto;
            font-size: 85%;
            line-height: 1.45;
            margin-bottom: 16px;
        }
        code {
            font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
        }

        /* --- Tabela Porównawcza --- */
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 16px;
            table-layout: fixed; /* Równe kolumny */
        }
        th, td {
            padding: 6px 13px;
            border: 1px solid #d0d7de;
        }
        th {
            background-color: #f6f8fa;
            font-weight: 600;
        }
        /* Kod wewnątrz tabeli - usuwamy marginesy */
        td pre {
            margin: 0;
            padding: 8px;
            border: none;
            background: transparent;
        }

        /* --- GitHub Alerts (Note & Tip) --- */
        .markdown-alert {
            padding: 8px 16px;
            margin-bottom: 16px;
            color: inherit;
            border-left: 0.25em solid;
            border-radius: 0 6px 6px 0;
            font-size: inherit;
        }
        
        .markdown-alert > :first-child { margin-top: 0; }
        .markdown-alert > :last-child { margin-bottom: 0; }

        .markdown-alert-title {
            display: flex;
            font-weight: 600;
            align-items: center;
            line-height: 1;
            margin-bottom: 8px;
        }

        .markdown-alert-title svg {
            margin-right: 8px;
            fill: currentColor;
        }

        /* Styl NOTE */
        .markdown-alert.note {
            border-color: #0969da;
            background-color: #f1f8ff; /* Bardzo jasny niebieski */
        }
        .markdown-alert.note .markdown-alert-title { color: #0969da; }

        /* Styl TIP */
        .markdown-alert.tip {
            border-color: #1a7f37;
            background-color: #f3fcf5; /* Bardzo jasny zielony */
        }
        .markdown-alert.tip .markdown-alert-title { color: #1a7f37; }

        ul { padding-left: 2em; margin-bottom: 16px; }
        li { margin-bottom: 4px; }
    </style>
</head>
<body>

    <div class="header-container">
        <div class="badges">
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
        </div>
        
        <div class="logo-container">
            <a href="#">
                <img src="https://github.com/urniaz/testthatdocs/blob/main/testthatdocs/man/figures/logo.png?raw=true" alt="logo">
            </a>
        </div>
    </div>

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
                <th width="50%">Before</th>
                <th width="50%">After</th>
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

    <div class="markdown-alert note">
        <div class="markdown-alert-title">
            <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-info">
                <path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm8-6.5a6.5 6.5 0 1 0 0 13 6.5 6.5 0 0 0 0-13ZM6.5 7.75A.75.75 0 0 1 7.25 7h1a.75.75 0 0 1 .75.75v2.75h.25a.75.75 0 0 1 0 1.5h-2a.75.75 0 0 1 0-1.5h.25v-2h-.25a.75.75 0 0 1-.75-.75ZM8 6a1 1 0 1 1 0-2 1 1
