context("System test")

test_that("everything goes well",{
  this_software_is_stock_assessment_of("Japanese sardine")
  the_asssessment_is_conducted_in(fiscal_year = 2018)
})

test_that("data year is correct", {
  years_are_consistent(load_data(), metadata())
})
