years_are_consistent <- function(dat, metadata) {
  assertthat::assert_that(
    assertthat::has_name(metadata, "year"),
    assertthat::has_name(dat, c("caa", "maa", "waa", "index", "M"))
  )

  lag_expected <- 1 # Lag between assessment year and data year
  latest_year  <- max(as.numeric(colnames(dat$caa)))
  lag_actual   <- metadata$year - latest_year
  try(testthat::expect_equal(lag_expected, lag_actual),
      stop("Latest year of data is different from 'year' of metadata()."))
}
