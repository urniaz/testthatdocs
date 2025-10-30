# tests/testthat/test-document.R
# Unit tests for document()

`%||%` <- function(x, y) if (is.null(x)) y else x

test_that("document() walks tree, inserts listings, and is idempotent", {
  skip_if_not_installed("withr")
  skip_if_not_installed("glue")

  # Temporary test tree
  td <- withr::local_tempdir()
  root <- file.path(td, "tests", "testthat")
  dir.create(root, recursive = TRUE, showWarnings = FALSE)

  # Sample files
  f1 <- file.path(root, "test-alpha.R")
  f2 <- file.path(root, "nested", "test-beta.R")
  dir.create(dirname(f2), recursive = TRUE, showWarnings = FALSE)

  writeLines(c(
    "# alpha file",
    "# - Section A",
    "test_that(\"alpha one\", { expect_true(TRUE) })",
    "test_that('alpha two',  { expect_true(TRUE) })",
    "# - Section B",
    "test_that(paste('alpha', 'three'), { expect_true(TRUE) })"
  ), f1, useBytes = TRUE)

  writeLines(c(
    "# beta file",
    "# - Beta Sec",
    "test_that(glue::glue('beta {1+1}'), { expect_true(TRUE) })",
    "test_that(\"plain beta\", { expect_true(TRUE) })"
  ), f2, useBytes = TRUE)

  # 1) Run directory generator (write)
  res <- document(
    root = root,
    template = "advanced",
    backup = FALSE,
    write = TRUE,
    quiet = TRUE
  )

  expect_type(res, "list")
  expect_true(all(file.exists(res$files)))
  expect_true(is.data.frame(res$listing))
  expect_true(length(res$results) == length(res$files))

  # Combined listing should have file column if any rows
  if (nrow(res$listing)) expect_true("file" %in% names(res$listing))

  # 2) Files should now contain @testsList and @testsItem lines, no placeholders
  txt1 <- readLines(f1, warn = FALSE)
  txt2 <- readLines(f2, warn = FALSE)
  expect_true(any(grepl("^\\s*#'\\s*@testsList\\b", txt1)))
  expect_true(any(grepl("^\\s*#'\\s*@testsItem\\b", txt1)))
  expect_false(any(grepl("\\{g=\\d+\\}", txt1)))  # placeholders must be gone
  expect_false(any(grepl("\\{g=\\d+\\}", txt2)))

  # No raw {g}/{s}/{i}/{l} literals should survive
  expect_false(any(grepl("\\{g\\}|\\{s\\}|\\{i\\}|\\{l\\}", txt1)))
  expect_false(any(grepl("\\{g\\}|\\{s\\}|\\{i\\}|\\{l\\}", txt2)))

  # 3) Idempotency: re-run should not change content
  before1 <- paste(txt1, collapse = "\n")
  before2 <- paste(txt2, collapse = "\n")
  res2 <- document(root = root, template = "advanced", backup = FALSE, write = TRUE, quiet = TRUE)
  txt1b <- readLines(f1, warn = FALSE)
  txt2b <- readLines(f2, warn = FALSE)
  after1 <- paste(txt1b, collapse = "\n")
  after2 <- paste(txt2b, collapse = "\n")
  expect_identical(before1, after1)
  expect_identical(before2, after2)

  # 4) Titles in listing should not be fully wrapped in quotes
  if (nrow(res$listing)) {
    fully_quoted <- grepl('^\\s*([\"\']).*\\1\\s*$', res$listing$title_raw %||% "")
    expect_false(any(fully_quoted, na.rm = TRUE))
  }

  # 5) Dry run should not modify files
  txt1_pre <- readLines(f1, warn = FALSE)
  res3 <- document(root = root, template = "advanced", backup = FALSE, write = FALSE, quiet = TRUE)
  txt1_post <- readLines(f1, warn = FALSE)
  expect_identical(txt1_pre, txt1_post)
})
