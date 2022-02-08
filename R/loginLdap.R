#' @title loginLdap
#'
#' @description Logs to user in against the ldap server
#'
#' @param user a string describing the user's name
#' @param pass a string describing the user's password
#'
#' @return success (Boolean), msg (string, error explanation), data (fields about the user)
#' @examples result <- loginLdap("user", "pass")
#' @export
#' @importFrom dplyr "%>%"
loginLdap <- function(user, pass) {
  checkAvailability()

  message("Trying to login with user ", user)
  domain <- "ou=users,dc=example,dc=org"
  dn <- paste0("cn=", user, ",", domain)

  param <- c('-H', 'ldap://localhost:1389', '-x', '-b', dn, '-w', pass, '-D', dn)
  result <- processx::run(shinyLdapCommand, param, error_on_status = FALSE)

  ret <- list()
  if (result$status == 0) {
    message("Success")
    ret$success <- TRUE
    ret$data <- parseResult(result$stdout)

  } else {
    ret$msg <- ldapErrorParser(result$status)
    ret$success <- FALSE
    message(ret$msg)
  }

  return (ret)
}
