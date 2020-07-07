#' Ultra great function to calculate stock abundance from catch data
#'
#' @param catchdata Catch data
#' @param coef Mulitiplication coefficient (dummy calculation)
#' @export
assess <- function(catchdata, coef, metadata) {
  test_catchdata(catchdata, metadata)

  data.frame(Year = catchdata$Year,
             Abundance = catchdata$Catch * coef,
             Type = "Assessed")
}

project <- function(abundance, n) {
  assertthat::assert_that(
    assertthat::has_name(abundance, c("Year", "Abundance", "Type"))
  )
  return_ <- function() {
    rbind(abundance, projected_())
  }

  projected_ <- function() {
    yr_start <- max(abundance$Year) + 1
    data.frame(Year = yr_start:(yr_start + (n - 1)),
               Abundance = project_(abundance$Abundance, n),
               Type = "Projected")
  }
  project_ <- function(abund, n) {
    rep(mean(abund), n)
  }
  return_()
}
