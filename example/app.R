devtools::install_github("deeplo-app/ShinyLdapAuthentication")
library(shinyLdapAuthentication)

ui <- fluidPage(
  titlePanel("Shiny Ldap test"),

  sidebarLayout(
    sidebarPanel(
      shiny::verbatimTextOutput("login_error_text"),
      shiny::textInput("username_input", "Username", ""),
      shiny::passwordInput("password_input", "Password", ""),
      shiny::actionButton("submit_login", "Sign In")
    ),

    mainPanel(
      h1(shiny::uiOutput('login_content'))
    )
  )
)

server <- function(input, output, session) {
  go_click <- shiny::observeEvent(input[["submit_login"]], {
    output[["login_error_text"]] <- NULL
    output[["login_content"]] <- NULL

    user <- input[["username_input"]]
    pass <- input[["password_input"]]

    if (user == "" || pass == "") {
      output[["login_error_text"]] <- shiny::renderText("Both fields are required")
      return (FALSE)
    }

    result <- loginLdap(user, pass)

    if (!result$success) {
      output[['login_error_text']] <- shiny::renderText(result$msg)
    } else {
      output[['login_content']] <- shiny::renderText(paste0('Hello ', result$data$sn, ' (', result$data$uidNumber, ')'))
      session$userData$user <- result$data$sn
    }
  })
}

shinyApp(ui = ui, server = server)
