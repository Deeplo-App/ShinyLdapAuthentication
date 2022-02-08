#' @title checkAvailability
#'
#' @description Checks that the needed commands are installed on the system
#'     Should be executed on start up in an application where ldap is critical
#'
#' @param fail A Boolean (default true) whether the program exits if the command is not available
#'
#' @return A Boolean whether the command is available on the system.
#' @examples checkAvailability()
#' @export
#' @importFrom dplyr "%>%"
checkAvailability <- function(fail=TRUE) {
  tmp <- Sys.which(shinyLdapCommand)

  if ((tmp == '')) {
    if (fail) {
      stop(paste0("You are missing ", shinyLdapCommand, " on your system (install ldap-utils)."))
    }
    return (FALSE)
  }

  return (TRUE)
}
