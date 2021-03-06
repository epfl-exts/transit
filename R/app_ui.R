
#' @import shiny
app_ui <- function() {
  bootstraplib::bs_theme_new(version = "4+3",
                             bootswatch = "cosmo")

  bootstraplib::bs_theme_add_variables(
    primary = "#d30a09",
    "body-bg" = "#fff",
    "font-family-base" = "monospace"
  )

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    fluidPage(
      class = "content",
      bootstraplib::bootstrap(),
      div(class = "container",
          titlePanel(span("transit",
                          class = "title text-right"),
                     windowTitle = "transit"),
          div(
            class = "jumbotron",
            h1(class = "display-4",
               "All aboard!",
               tags$br(),
               tags$small("Select your trip below.")),
            p(
              class = "lead",
              "You can choose from any station or stop in Switzerland: train, tram, bus, or boat!"
            ),
            tags$hr(class = "my-4"),
            mod_trip_selector_ui("trip_selector")
          )),
        mod_details_wrapper_ui("details_wrapper")
    ),
    tags$footer(
      div(
        class = "container",
        p(
          class = "mb-4",
          "This app was built by TeamR at the",
          a(href = "https://www.extensionschool.ch/", "EPFL Extension School.", target = "_blank"),
          tags$br(),
          "We'd like to say a special thank you the maintainers of"
        ),
        uiOutput("footer_logos")
      )
    )
  )
}

sass::sass(
  sass::sass_file("scss/main.scss"),
  output = "inst/app/www/main.css"
)

#' @import shiny
golem_add_external_resources <- function(){

  addResourcePath(
    'www', system.file('app/www', package = 'transit')
  )

  tags$head(
    golem::activate_js(),
    golem::favicon(),
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
    tags$link(rel = "stylesheet", type = "text/css", href = "www/main.css")
  )
}
