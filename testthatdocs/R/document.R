#' Recursively generate test listings across a testthat tree
#'
#' Walks the \code{tests/testthat} directory (by default), finds test files,
#' and runs \code{\link{document_file}} on each matching file. All
#' options from \code{document_file()} are available here as pass-through
#' parameters.
#'
#' @param root Character. Root directory to search. Default \code{"tests/testthat"}.
#' @param pattern Regular expression used with \code{list.files(..., pattern=)} to
#'   select test files. Default matches typical testthat files: \code{"^[Tt]est.*\\.[rR]$"}.
#' @param recurse Logical. Whether to search subdirectories recursively. Default \code{TRUE}.
#' @param exclude Character vector of basenames to exclude (e.g., \code{"testthat.R"}).
#'   Default \code{c("testthat.R")}.
#' @param quiet Logical. If \code{FALSE} (default), prints progress messages.
#' @inheritParams document_file
#'
#' @return A list with components:
#' \itemize{
#'   \item \code{files}: character vector of processed file paths
#'   \item \code{results}: named list of \code{tests_listing_result} objects per file
#'   \item \code{listing}: combined data frame with a \code{file} column
#'   \item \code{backups}: character vector of backup paths (for files that were written)
#' }
#' @examples
#' \dontrun{
#'   all_res <- document(
#'     root = "tests/testthat",
#'     template = "advanced",
#'     backup = TRUE,
#'     write = TRUE
#'   )
#'   head(all_res$listing)
#' }
#' @export
document <- function(root = "tests/testthat",
                     pattern = "^[Tt]est.*\\.[rR]$",
                     recurse = TRUE,
                     exclude = c("testthat.R"),
                     section_prefix = "# -",
                     template = c("simple", "advanced", "custom"),
                     global_fmt = NULL,
                     section_fmt = NULL,
                     encoding = "UTF-8",
                     backup = TRUE,
                     write = TRUE,
                     quiet = FALSE) {
  template <- match.arg(template)
  if (!dir.exists(root)) stop(sprintf("Root directory not found: %s", root))
  files <- list.files(root, pattern = pattern, recursive = isTRUE(recurse),
                      full.names = TRUE, include.dirs = FALSE, all.files = FALSE)
  if (length(exclude)) {
    files <- files[!(basename(files) %in% exclude)]
  }
  # Keep only files that exist and are readable text files
  files <- files[file.exists(files)]
  if (!length(files)) {
    if (!quiet) message("No test files matched under: ", root)
    return(list(files = character(0), results = list(), listing = utils::head(data.frame()), backups = character(0)))
  }
  results <- vector("list", length(files))
  names(results) <- files
  backups <- rep(NA_character_, length(files))
  combined <- NULL
  for (k in seq_along(files)) {
    f <- files[k]
    if (!quiet) message(sprintf("[%d/%d] %s", k, length(files), f))
    res <- document_file(
      path = f,
      section_prefix = section_prefix,
      template = template,
      global_fmt = global_fmt,
      section_fmt = section_fmt,
      encoding = encoding,
      backup = backup,
      write = write
    )
    results[[k]] <- res
    backups[k] <- if (isTRUE(write) && !is.null(res$backup)) as.character(res$backup) else NA_character_
    if (is.null(combined)) {
      combined <- res$listing
      if (!is.null(combined) && nrow(combined)) combined$file <- f
    } else {
      df <- res$listing
      if (!is.null(df) && nrow(df)) {
        df$file <- f
        combined <- rbind(combined, df, stringsAsFactors = FALSE)
      }
    }
  }
  if (is.null(combined)) combined <- data.frame()
  out <- list(files = files, results = results, listing = combined, backups = backups)
  class(out) <- c("document", class(out))
  out
}
