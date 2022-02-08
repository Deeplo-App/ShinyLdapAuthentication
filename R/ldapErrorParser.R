#' @title ldapErrorParser
#'
#' @description Returns a human readable string describing the error code.
#'
#' @param status An error code returned by the loginLdap function
#'
#' @return A human readable string describing the error code.
#' @examples result <- loginLdap("user", "pass")
#'     message(ldapErrorParser(result$status))
#' @export
#' @importFrom dplyr "%>%"
ldapErrorParser <- function(status) {
  errors <- list(
    e49 = 'Invalid credentials'
  )

  error_msg <- "Undefined error"

  if (!is.null(errors[[paste0('e', status)]])) {
    error_msg <- errors[[paste0('e', status)]]
  }

  return (error_msg)
}
