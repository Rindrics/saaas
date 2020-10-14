backgenerate_years <- function(from, length) {
  oldest <- from - (length - 1)
  newest <- from
  force(oldest:newest)
}

fcurrent_years <- function(year) {
  backgenerate_years(from   = year - 1,
                     length = 3)
}

terminal_f_years <- function(year) {
  backgenerate_years(from   = year - 2,
                     length = 2)
}
