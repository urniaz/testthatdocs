# This is a demo test file

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
})