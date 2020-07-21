backgenerate_years <- function(from, length) {
  oldest <- from - (length - 1)
  newest <- from
  force(oldest:newest)
}

fcurrent_years <- function() {
  backgenerate_years(from   = metadata()$year - 1,
                     length = 3)
}

terminal_f_years <- function() {
  backgenerate_years(from   = metadata()$year - 2,
                     length = 5)
}
