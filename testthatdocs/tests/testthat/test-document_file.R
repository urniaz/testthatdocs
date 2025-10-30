
test_that("quoted titles are extracted as plain text and globally numbered", {
  skip_if_not(exists("document_file"), "Function not loaded.")

  txt <- c(
    "#' Some header",
    "test_that(\"alpha test\", { expect_true(TRUE) })",
    "test_that('beta test', { expect_true(TRUE) })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  res <- document_file(f, write = FALSE)
  expect_match(res$text[1], "^#' @testsList$")

  items <- grep("^#' @testsItem ", res$text, value = TRUE)
  expect_length(items, 2L)
  expect_true(any(grepl("@testsItem 1 alpha test", items)))
  expect_true(any(grepl("@testsItem 2 beta test", items)))
})

test_that("expression titles are preserved as raw expressions", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' @testsList",
    "test_that(paste('A', 1), { expect_true(TRUE) })",
    "test_that(glue::glue('B{2}'), { expect_true(TRUE) })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  res <- document_file(f, write = FALSE)
  items <- grep("^#' @testsItem ", res$text, value = TRUE)
  expect_true(any(grepl("@testsItem 1 paste\\(", items)))
  expect_true(any(grepl("@testsItem 2 glue::glue\\(", items)))
})

test_that("section prefix converts to @testsSection and items follow markers", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' Title",
    "# - First Section",
    "test_that('s1-t1', { })",
    "test_that('s1-t2', { })",
    "# - Second Section",
    "test_that('s2-t1', { })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  res <- document_file(f, write = FALSE)
  expect_true(any(grepl("^#' @testsSection First Section$", res$text)))
  expect_true(any(grepl("^#' @testsSection Second Section$", res$text)))

  sec1_pos <- grep("^#' @testsSection First Section$", res$text)
  expect_match(res$text[sec1_pos + 1], "^#' @testsItem ")
  sec2_pos <- grep("^#' @testsSection Second Section$", res$text)
  expect_match(res$text[sec2_pos + 1], "^#' @testsItem ")
})

test_that("adds @testsList if missing and is idempotent", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' Header above all",
    "test_that('t1', { })",
    "test_that('t2', { })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  invisible(document_file(f, write = TRUE, backup = FALSE))
  text1 <- readLines(f, warn = FALSE, encoding = "UTF-8")

  invisible(document_file(f, write = TRUE, backup = FALSE))
  text2 <- readLines(f, warn = FALSE, encoding = "UTF-8")

  expect_identical(text1, text2)
  expect_equal(sum(grepl("^#' @testsList$", text1)), 1L)
  list_pos <- grep("^#' @testsList$", text1)
  following <- text1[(list_pos + 1):min(length(text1), list_pos + 10)]
  expect_equal(sum(grepl("^#' @testsItem ", following)), 2L)
})

test_that("fmt_global = {gidx}.{sidx}.{lidx} works; sections start at 1", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' @testsList",
    "test_that('pre-t1', { })",
    "# - A",
    "test_that('a1', { })",
    "test_that('a2', { })",
    "# - B",
    "test_that(paste('b', 1), { })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  res <- document_file(f, global_fmt = "{g}.{s}.{i}", write = FALSE)
  items <- grep("^#' @testsItem ", res$text, value = TRUE)

  expect_true(any(grepl("@testsItem 1.0.1 pre-t1$", items)))  # preamble section sidx=0
  expect_true(any(grepl("@testsItem 2.1.1 a1$", items)))     # first real section sidx=1
  expect_true(any(grepl("@testsItem 3.1.2 a2$", items)))
  expect_true(any(grepl("@testsItem 4.2.1 paste", items, fixed = TRUE))) # second section sidx=2
})

test_that("custom fmt_section placeholders work", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' @testsList",
    "# - X",
    "test_that('x1', { })",
    "# - Y",
    "test_that('y1', { })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)
  res <- document_file(f, section_fmt = "S{s}-T{i}", write = FALSE)

  x_pos <- grep("^#' @testsSection X$", res$text)
  expect_match(res$text[x_pos + 1], "^#' @testsItem S1-T1 x1$")
  y_pos <- grep("^#' @testsSection Y$", res$text)
  expect_match(res$text[y_pos + 1], "^#' @testsItem S2-T1 y1$")
})

test_that("backup=TRUE creates a .bak file", {
  skip_if_not(exists("document_file"))

  txt <- c("#' @testsList", "test_that('z', { })")
  dir <- withr::local_tempdir()
  f <- file.path(dir, "file.R")
  writeLines(txt, f, useBytes = TRUE)

  invisible(document_file(f, write = TRUE, backup = FALSE))
  invisible(document_file(f, write = TRUE, backup = TRUE))

  bak <- list.files(dir, pattern = "\\.bak", full.names = TRUE)
  expect_true(length(bak) >= 1L)
})

test_that("only @testsItem blocks are replaced; other code/comments intact", {
  skip_if_not(exists("document_file"))

  txt <- c(
    "#' @testsList",
    "#' NOTE: keep me",
    "x <- 1L  # code stays",
    "test_that('one', { })",
    "# - S",
    "# a normal comment that should remain",
    "test_that('two', { })"
  )
  f <- withr::local_tempfile(fileext = ".R")
  writeLines(txt, f, useBytes = TRUE)

  invisible(document_file(f, write = TRUE))
  after1 <- readLines(f, warn = FALSE, encoding = "UTF-8")
  invisible(document_file(f, write = TRUE))
  after2 <- readLines(f, warn = FALSE, encoding = "UTF-8")

  expect_identical(after1, after2)
  expect_true(any(grepl("^#' NOTE: keep me$", after2)))
  expect_true(any(grepl("^x <- 1L  # code stays$", after2)))
  expect_true(any(grepl("^# a normal comment that should remain$", after2)))
})
