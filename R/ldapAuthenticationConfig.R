config <- list(
  'ldapServerUrl' = 'ldap://localhost:1389',
  'ldapDomain' = 'ou=users,dc=example,dc=org'
)

#' @title setLdapServerUrl
#'
#' @description Sets the ldap server url
#'
#' @param url The ldap server url
#'
#' @return Nothing
#' @examples setLdapServerUrl('ldap://localhost:1389')
#' @export
#' @importFrom dplyr "%>%"
setLdapServerUrl <- function(url) {
  config$ldapServerUrl <- url
}

#' @title setLdapServerUrl
#'
#' @description Sets the ldap server domain
#'
#' @param domain The ldap server domain
#'
#' @return Nothing
#' @examples setLdapDomain('ou=users,dc=example,dc=org')
#' @export
#' @importFrom dplyr "%>%"
setLdapDomain <- function(domain) {
  config$ldapDomain <- domain
}
