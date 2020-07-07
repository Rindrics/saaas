this_software_is_stock_assessment_of <- function(spcs) {
  testthat::expect_equal(metadata()$species, spcs)
}

the_asssessment_is_conducted_in <- function(fiscal_year) {
  testthat::expect_equal(metadata()$year, fiscal_year)
}
