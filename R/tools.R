return_file_type <- function(fname) {
  if (stringr::str_detect(fname, "csv$")) {
    "csv"
  } else {
    stop("Unknown file type", fname)
  }
}

extract_filename <- function(path) {
  stringr::str_extract(path, "(?<=/)(\\w|\\.)+\\.[a-z]+$")
}

#' @importFrom utils read.csv
load_data <- function(fname) {
  request_from_developers <- stringr::str_detect(fname, "/inst/extdata")
  if (request_from_developers) {
    fname <- system.file("extdata", extract_filename(fname), package = "saaas")
  }
  ftype <- return_file_type(fname)
  if (ftype == "csv") {
    return(read.csv(fname))
  } else {
    stop("Unknown filetype", call. = TRUE)
  }
}
