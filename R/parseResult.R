#' @title parseResult
#'
#' @description Parses the string returned by the ldap command to extract fields.
#'
#' @param blob The multiline text returned by the ldap command
#'
#' @return A dictionary with the fields available in the blob.
#' @examples result <- loginLdap("user", "pass")
#'     fields <- parseResult(result$data)
#' @export
#' @importFrom dplyr "%>%"
parseResult <- function(blob) {
  blob <- gsub('#(.*?)\n', '', blob)
  lines <- unlist(unique(strsplit(blob, split = '\n')))

  ret <- list()
  for (item in lines) {
    if (item != "") {
      a <- strsplit(item, ':')[[1]]
      ret[a[1]] <- sub(' ', '', a[2])
    }
  }

  return (ret)
}
