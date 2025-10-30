#' Generate idempotent listings of test_that() titles with sections
#'
#' Scans an R text file for \code{test_that()} calls, generates a global listing
#' and per-section listings as roxygen comments, and inserts them right after the
#' corresponding markers. The function is **idempotent**: it only replaces content
#' between existing \verb{@testsList} and \verb{@testsSection} markers and leaves
#' other code/comments unchanged. If section headers are given using a plain-text
#' prefix (e.g., \code{"# -"}), they are converted to roxygen markers
#' \verb{#' @testsSection} (with any following text treated as the section title).
#'
#' The title extracted from \code{test_that()} is the first argument as a *raw
#' expression*. If that argument is a single, quoted string (single/double/backtick),
#' the outer quotes are stripped for cleaner listings. If it is constructed via
#' functions like \code{paste()} or \code{glue::glue()}, the raw expression is listed
#' without evaluation (and inner quotes remain).
#'
#' Numbering is customizable via templates using placeholders:
#' \itemize{
#'   \item \code{{g}} – global incremental index across all tests
#'   \item \code{{s}} – section index (1-based, order of appearance)
#'   \item \code{{i}} – local index within a section (1-based)
#'   \item \code{{l}} – line index (line number in the final, modified text)
#'   \item aliases: \code{{local}} \eqn{\rightarrow} \code{{i}}, \code{{line}} \eqn{\rightarrow} \code{{l}}
#' }
#'
#' Two presets are available via \code{template}:
#' \itemize{
#'   \item \code{"simple"} → \code{"{g}"}
#'   \item \code{"advanced"} → \code{"{g}.{s}.{i}"}
#'   \item \code{"full"} → \code{"{g}.{s}.{i}.{l}"}
#' }
#' You may fully override formats using \code{global_fmt} and \code{section_fmt}.
#'
#' After inserting listings, the file is rescanned to compute the **final**
#' \code{test_that()} line numbers reported in the returned data frame.
#'
#' @param path Character. Path to the text file to process (typically a test file).
#' @param section_prefix Character scalar. Lines starting with this prefix denote
#'   sections and are converted to \verb{#' @testsSection}. Default \code{"# -"}.
#' @param template One of \code{c("simple", "advanced", "custom")}. Controls the
#'   default numbering format(s). Default \code{"simple"}.
#' @param global_fmt Character. Numbering template for the global listing. Uses
#'   placeholders \code{{g}}, \code{{s}}, \code{{i}}, \code{{l}}. If \code{NULL},
#'   it is derived from \code{template}.
#' @param section_fmt Character. Numbering template for section listings.
#'   If \code{NULL}, it is derived from \code{template}.
#' @param encoding File encoding for reading and writing. Default \code{"UTF-8"}.
#' @param backup Logical. If \code{TRUE}, save a timestamped backup before
#'   overwriting. Default \code{TRUE}.
#' @param write Logical. If \code{TRUE}, write changes back to \code{path}.
#'   If \code{FALSE}, return the would-be modified text without writing. Default \code{TRUE}.
#' @return A list with components:
#'   \itemize{
#'     \item \code{text}: the final modified text (character vector, one element per line)
#'     \item \code{listing}: data frame of discovered tests with columns
#'       \code{g}, \code{s}, \code{i}, \code{l} (final line), \code{title_raw},
#'       \code{section_title}.
#'     \item \code{written}: logical, whether the file was written
#'     \item \code{backup}: path to backup file (or \code{NULL})
#'   }
#' @examples
#' \dontrun{
#'   res <- document_file("tests/testthat/test-example.R",
#'                                 section_prefix = "# -",
#'                                 template = "advanced")
#'   res$listing
#' }
#' @importFrom stats ave
#' @export
document_file <- function(path,
                          section_prefix = "# -",
                          template = c("simple", "advanced", "full", "custom"),
                          global_fmt = NULL,
                          section_fmt = NULL,
                          encoding = "UTF-8",
                          backup = TRUE,
                          write = TRUE) {
  stopifnot(length(path) == 1L, file.exists(path))
  template <- match.arg(template)
  if (is.null(global_fmt) || is.null(section_fmt)) {
    if (template == "simple") {
      if (is.null(global_fmt))  global_fmt  <- "{g}"
      if (is.null(section_fmt)) section_fmt <- "{g}"
    } else if (template == "advanced") {
      if (is.null(global_fmt))  global_fmt  <- "{g}.{s}.{i}"
      if (is.null(section_fmt)) section_fmt <- "{g}.{s}.{i}"
    } else if (template == "full") {
      if (is.null(global_fmt))  global_fmt  <- "{g}.{s}.{i}.{l}"
      if (is.null(section_fmt)) section_fmt <- "{g}.{s}.{i}.{l}"
    } else {
      if (is.null(global_fmt) || is.null(section_fmt)) {
        stop("For template='custom', please provide both global_fmt and section_fmt.")
      }
    }
  }
  # --- helpers ---------------------------------------------------------------
  read_file <- function(pth, enc) {
    con <- file(pth, open = "r", encoding = enc)
    on.exit(close(con), add = TRUE)
    readLines(con, warn = FALSE)
  }
  write_file <- function(lines, pth, enc) {
    con <- file(pth, open = "w", encoding = enc)
    on.exit(close(con), add = TRUE)
    writeLines(lines, con, useBytes = TRUE)
    invisible(pth)
  }
  timestamp_backup <- function(pth) {
    ts <- format(Sys.time(), "%Y%m%d-%H%M%S")
    ext <- sub("^.*(\\.[[:alnum:]]+)$", "\\1", pth)
    base <- ifelse(grepl("\\.", basename(pth)), sub("(.*)\\.[^.]*$", "\\1", basename(pth)), basename(pth))
    bkp <- file.path(dirname(pth), sprintf("%s.bak-%s%s", base, ts, ifelse(ext == pth, "", ext)))
    file.copy(pth, bkp, overwrite = TRUE)
    bkp
  }
  # Identify @testsItem block after a marker line index
  find_listing_block <- function(lines, start_idx) {
    n <- length(lines)
    i <- start_idx + 1L
    while (i <= n && grepl("^\\s*#'\\s*@testsItem\\b", lines[i])) {
      i <- i + 1L
    }
    c(start_idx + 1L, i - 1L) # inclusive span; could be [x, x-1] if empty
  }
  # Render numbering template
  fmt_number <- function(fmt, g, s, i, l) {
    out <- fmt
    # aliases
    out <- gsub("\\{local\\}", as.character(i), out, perl = TRUE)
    out <- gsub("\\{line\\}",  as.character(l), out, perl = TRUE)
    # primary placeholders
    out <- gsub("\\{g\\}", as.character(g), out, perl = TRUE)
    out <- gsub("\\{s\\}", as.character(s), out, perl = TRUE)
    out <- gsub("\\{i\\}", as.character(i), out, perl = TRUE)
    out <- gsub("\\{l\\}", as.character(l), out, perl = TRUE)
    out
  }
  # Extract raw first argument of test_that(...), stripping outer quotes for plain strings
  extract_title_raw <- function(line) {
    ln <- sub("^\\s*", "", line, perl = TRUE)
    if (!grepl("^test_that\\s*\\(", ln)) return(NA_character_)
    s <- regexpr("\\(", ln)[1]
    rest <- substr(ln, s + 1L, nchar(ln))
    depth <- 0L
    in_sq <- FALSE; in_dq <- FALSE; esc <- FALSE
    arg1 <- character()
    for (ch in strsplit(rest, "")[[1]]) {
      if (esc) { arg1 <- c(arg1, ch); esc <- FALSE; next }
      if (ch == "\\") { arg1 <- c(arg1, ch); esc <- TRUE; next }
      if (!in_dq && ch == "'" ) { in_sq <- !in_sq; arg1 <- c(arg1, ch); next }
      if (!in_sq && ch == '"' ) { in_dq <- !in_dq; arg1 <- c(arg1, ch); next }
      if (!in_sq && !in_dq) {
        if (ch == "(") { depth <- depth + 1L; arg1 <- c(arg1, ch); next }
        if (ch == ")") {
          if (depth == 0L) break
          depth <- depth - 1L; arg1 <- c(arg1, ch); next
        }
        if (ch == "," && depth == 0L) break
      }
      arg1 <- c(arg1, ch)
    }
    raw <- paste(arg1, collapse = "")
    raw <- sub("\\s+$", "", raw, perl = TRUE)
    # --- Strip wrapping parentheses then outer matching quotes (' " `) for plain strings ---
    if (grepl("^\\s*\\(.*\\)\\s*$", raw)) {
      inner <- sub("^\\s*\\((.*)\\)\\s*$", "\\1", raw, perl = TRUE)
      if (nzchar(inner)) raw <- inner
    }
    if (grepl("^\\s*([\"'`]).*\\1\\s*$", raw, perl = TRUE)) {
      raw <- sub("^\\s*([\"'`])(.*)\\1\\s*$", "\\2", raw, perl = TRUE)
    }
    raw
  }
  is_section_marker   <- function(x) grepl("^\\s*#'\\s*@testsSection\\b", x)
  is_testslist_marker <- function(x) grepl("^\\s*#'\\s*@testsList\\b", x)
  make_item <- function(num_str, title) sprintf("#' @testsItem %s %s", num_str, title)
  # --------------------------------------------------------------------------
  original <- read_file(path, encoding)
  lines <- original
  # 1) Convert plain section_prefix lines to roxygen @testsSection markers
  if (!is.null(section_prefix) && nzchar(section_prefix)) {
    prefix_re <- sprintf("^\\s*%s\\s*(.*)$", gsub("([.|()\\^{}+$*?\\[\\]\\\\])", "\\\\\\1", section_prefix))
    lines <- ifelse(grepl(prefix_re, lines, perl = TRUE),
                    sub(prefix_re, "#' @testsSection \\1", lines, perl = TRUE),
                    lines)
  }
  # 2) Ensure there is exactly one global @testsList marker
  list_marker_idx <- which(sapply(lines, is_testslist_marker))
  if (length(list_marker_idx) == 0L) {
    lines <- c("#' @testsList", lines)
    list_marker_idx <- 1L
  } else {
    list_marker_idx <- list_marker_idx[1L]
  }
  # 3) Discover sections and titles
  section_idx <- which(sapply(lines, is_section_marker))
  section_titles <- rep(NA_character_, length(section_idx))
  if (length(section_idx)) {
    for (k in seq_along(section_idx)) {
      tk <- sub("^\\s*#'\\s*@testsSection\\s*", "", lines[section_idx[k]])
      section_titles[k] <- if (nzchar(tk)) tk else NA_character_
    }
  }
  # Map lines to sections
  section_for_line <- rep(0L, length(lines))
  if (length(section_idx)) {
    nxt <- c(section_idx, length(lines) + 1L)
    for (j in seq_along(section_idx)) {
      start <- section_idx[j]
      end <- nxt[j + 1L] - 1L
      section_for_line[start:end] <- j
    }
  }
  # 4) Pre-pass: find tests and their raw titles (before insertion)
  test_line_idx <- which(grepl("^\\s*test_that\\s*\\(", lines))
  titles_raw <- vapply(lines[test_line_idx], extract_title_raw, character(1))
  df <- data.frame(
    line_idx_initial = test_line_idx,
    title_raw = titles_raw,
    s = if (length(test_line_idx)) section_for_line[test_line_idx] else integer(0),
    stringsAsFactors = FALSE
  )
  if (nrow(df)) {
    df$g <- seq_len(nrow(df))
    df$i <- stats::ave(df$g, df$s, FUN = seq_along)
  }
  # 5) Clean out any existing items after @testsList and each @testsSection
  span <- find_listing_block(lines, list_marker_idx)
  if (span[2] >= span[1]) lines <- lines[-seq.int(span[1], span[2])]
  section_idx <- which(sapply(lines, is_section_marker))
  for (idx in rev(section_idx)) {
    sp <- find_listing_block(lines, idx)
    if (sp[2] >= sp[1]) lines <- lines[-seq.int(sp[1], sp[2])]
  }
  # 6) Insert TEMP placeholder items (for correct final line computation)
  if (nrow(df)) {
    # global
    placeholders_g <- sprintf("#' @testsItem {g=%d}", df$g)
    lines <- append(lines, placeholders_g, after = list_marker_idx)
    # sections
    section_idx <- which(sapply(lines, is_section_marker))
    for (sid in seq_along(section_idx)) {
      idx_marker <- section_idx[sid]
      rows <- which(df$s == sid)
      if (length(rows)) {
        placeholders_s <- sprintf("#' @testsItem {g=%s}{s=%s}{i=%s}", df$g[rows], sid, seq_along(rows))
        lines <- append(lines, placeholders_s, after = idx_marker)
      }
    }
  }
  # 7) Second pass: rescan to compute final line numbers
  section_idx <- which(sapply(lines, is_section_marker))
  section_for_line <- rep(0L, length(lines))
  if (length(section_idx)) {
    nxt <- c(section_idx, length(lines) + 1L)
    for (j in seq_along(section_idx)) {
      start <- section_idx[j]
      end <- nxt[j + 1L] - 1L
      section_for_line[start:end] <- j
    }
  }
  test_line_idx2 <- which(grepl("^\\s*test_that\\s*\\(", lines))
  titles_raw2 <- vapply(lines[test_line_idx2], extract_title_raw, character(1))
  df2 <- data.frame(
    g = seq_along(test_line_idx2),
    s = if (length(test_line_idx2)) section_for_line[test_line_idx2] else integer(0),
    i = integer(length(test_line_idx2)),
    l = test_line_idx2,
    title_raw = titles_raw2,
    stringsAsFactors = FALSE
  )
  if (nrow(df2)) df2$i <- stats::ave(df2$g, df2$s, FUN = seq_along)
  # 8) FINAL rebuild of blocks: remove blocks and write formatted items
  list_marker_idx <- which(sapply(lines, is_testslist_marker))[1L]
  span <- find_listing_block(lines, list_marker_idx)
  if (span[2] >= span[1]) lines <- lines[-seq.int(span[1], span[2])]
  if (nrow(df2)) {
    items_global <- vapply(seq_len(nrow(df2)), function(row) {
      num <- fmt_number(global_fmt, df2$g[row], df2$s[row], df2$i[row], df2$l[row])
      make_item(num, df2$title_raw[row])
    }, character(1))
    lines <- append(lines, items_global, after = list_marker_idx)
  }
  section_idx <- which(sapply(lines, is_section_marker))
  for (sid in rev(seq_along(section_idx))) {
    idx_marker <- section_idx[sid]
    sp <- find_listing_block(lines, idx_marker)
    if (sp[2] >= sp[1]) lines <- lines[-seq.int(sp[1], sp[2])]
    rows <- which(df2$s == sid)
    if (length(rows)) {
      items_sec <- vapply(seq_along(rows), function(k) {
        row <- rows[k]
        num <- fmt_number(section_fmt, df2$g[row], df2$s[row], df2$i[row], df2$l[row])
        make_item(num, df2$title_raw[row])
      }, character(1))
      lines <- append(lines, items_sec, after = idx_marker)
    }
  }
  # 9) Defensive cleanup: remove ANY leftover placeholder @testsItem lines globally
  placeholder_re <- "^\\s*#'\\s*@testsItem\\s*\\{g=\\d+\\}(?:\\{s=\\d+\\}\\{i=\\d+\\})?\\s*$"
  lines <- lines[!grepl(placeholder_re, lines, perl = TRUE)]
  # 10) Prepare result df with section titles
  section_idx <- which(sapply(lines, is_section_marker))
  section_titles <- if (length(section_idx)) sub("^\\s*#'\\s*@testsSection\\s*", "", lines[section_idx]) else character(0)
  df2$section_title <- if (nrow(df2)) {
    vapply(df2$s, function(ss) if (ss == 0L || ss > length(section_titles)) NA_character_ else section_titles[ss], character(1))
  } else character(0)
  # 11) Optionally write
  backup_path <- NULL
  if (write) {
    if (isTRUE(backup)) backup_path <- timestamp_backup(path)
    write_file(lines, path, encoding)
  }
  rownames(df2) <- NULL
  out <- list(text = lines, listing = df2, written = isTRUE(write), backup = backup_path)
  class(out) <- c("tests_listing_result", class(out))
  out
}
