#' Ultra great function to calculate stock abundance from catch data
#'
#' @param catchdata Catch data
#' @param coef Mulitiplication coefficient (dummy calculation)
#' @param variable Variable to return
assess <- function(catchdata, coef, variable) {
  test_catchdata(catchdata, metadata())

  biomass_ <- function() {
    value <- catchdata$Catch * coef
    data.frame(Year = catchdata$Year,
               Variable = "Biomass",
               Abundance = value,
               Type = "Assessed")
  }
  ssb_ <- function() {
    maturation_rate <- 0.6
    value <- biomass_()$Abundance * maturation_rate
    data.frame(Year = catchdata$Year,
               Variable = "SSB",
               Abundance = value,
               Type = "Assessed")
  }
  if (variable == "Biomass") {
    force(biomass_())
  } else if (variable == "SSB") {
    force(ssb_())
  }
}

project <- function(abundance, n, method) {
  assertthat::assert_that(
    assertthat::has_name(abundance, c("Year", "Variable", "Abundance", "Type"))
  )
  return_ <- function() {
    dplyr::bind_rows(abundance, projected_()) %>%
      dplyr::mutate(Method = method)
  }

  projected_ <- function() {
    yr_start <- max(abundance$Year) + 1
    data.frame(Year = yr_start:(yr_start + (n - 1)),
               Variable = unique(abundance$Variable),
               Abundance = project_(abundance$Abundance, n, var = "mean"),
               Upper = project_(abundance$Abundance, n, var = "upper"),
               Lower = project_(abundance$Abundance, n, var = "lower"),
               Type = "Projected")
  }
  project_ <- function(abund, n, var) {
    if (method == "arima") {
      forecast <- abund %>%
              forecast::auto.arima() %>%
              forecast::forecast(h = n, level = 80)
    } else if (method == "randwalk") {
      forecast <- forecast::rwf(abund, h = n, level = 80, drift = TRUE)
    }
      force(unname(forecast[[var]]))
  }
  return_()
}

assess_and_project <- function(catch) {
  assess_and_project_ <- function(var, method) {
    catch %>%
      assess(coef = 2, variable = var) %>%
      project(n = 10, method)
  }
  vars    <- c("Biomass", "SSB")
  methods <- c("arima", "randwalk")
  purrr::pmap_df(list(var = rep(vars, length(methods)),
                      method = rep(methods, each = length(vars))),
                 assess_and_project_)
}
