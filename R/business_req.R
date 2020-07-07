test_catchdata <- function(catchdata, metadata) {
  assertthat::assert_that(
    assertthat::has_name(metadata, "year"),
    assertthat::has_name(catchdata, c("Year", "Catch"))
  )

  lag_expected <- 1 # Lag between assessment year and data year
  lag_actual   <- metadata$year - max(catchdata$Year)
  if (lag_expected != lag_actual) {
    stop(paste("Latest year of 'catchdata' is different from 'year' of metadata()."))
  }
}

