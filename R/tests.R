this_software_is_stock_assessment <- function(of, for_fiscal_year) {
  data(metadata)
  testthat::expect_equal(metadata$species, of)
  testthat::expect_equal(metadata$year, for_fiscal_year)
}
