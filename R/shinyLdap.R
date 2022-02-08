shinyLdapCommand <- 'ldapsearch'

# Checks that the needed commands are installed on the system
# Should be executed on start up in an application where ldap is critical
# Param: fail (boolean, default=TRUE) stop program if not not available
# Returns: boolean
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

# Converts error codes to human readable messages
# Param: Error code
# Returns: Message (string)
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


# Parse the result from the ldap server
# All keys are exported in the returned dictionary
# Params: blob (string returned by the ldap server)
# Returns: dictionary with all keys available in the server blob.
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

# Logs to user in against the ldap server
# Params: username and password (strings)
# Returns success (Boolean), msg (string, error explanation), data (fields about the user)
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
