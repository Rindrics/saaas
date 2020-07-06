#' Ultra great function to calculate stock abundance from catch data
#'
#' @param catchdata Catch data
#' @param coef Mulitiplication coefficient (dummy calculation)
#' @export
calculate <- function(catchdata, coef) {
  assertthat::assert_that(
    assertthat::has_name(catchdata, c("Year", "Catch"))
  )
  data.frame(Year = catchdata$Year,
             Abundance = catchdata$Catch * coef)
}
