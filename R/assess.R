load_data <- function() {
  read_csv_ <- function(fname) {
    read.csv(system.file("extdata", fname, package = "saaas"), row.names = 1)
  }
  frasyr::data.handler(caa = read_csv_("catch_at_age.csv"),
                       waa = read_csv_("weight_at_age.csv"),
                       maa = read_csv_("maturity_at_age.csv"),
                       M   = 0.4)
}
