library(tidyverse)
library(survival)
library(fs)

#' Start Function
#'
#' This function writes the `jasa` data frame to a specified output path.
#' If the directory does not exist, it creates the directory.
#'
#' @param output_path A character string specifying the path to save
#' the CSV file.
#'
#' @return None
#' @export
#'
initiate <- function(output_path) {
  dir_path <- dirname(output_path)
  if (!dir_exists(dir_path)) dir_create(dir_path)
  today_date <- Sys.Date()
  file_name <- basename(output_path)
  file_extension <- tools::file_ext(file_name)
  file_base <- tools::file_path_sans_ext(file_name)
  new_file_name <- paste0(file_base, "_", today_date, ".", file_extension)
  new_output_path <- file.path(dir_path, new_file_name)
  write_csv(jasa, new_output_path)
}