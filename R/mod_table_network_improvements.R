#' table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom DT DTOutput renderDT
mod_table_network_improvements_ui <- function(id) {
  ns <- NS(id)
  tagList(
    DT::DTOutput(
      ns("table"),
      width = "75%",
      height = "auto"
    )
  )
}

#' table Server Function
#'
#' @noRd
mod_table_network_improvements_server <- function(input, output, session, slider_input) {
  ns <- session$ns

  table_data <- reactive({
    scenario_def_long[scenario_id == slider_input$slider, ]
  })

  output$table <- renderDT({
    DT::datatable(
      data = table_data()[, .(scenario_text, value, improvement_example)],
      rownames = FALSE,
      colnames = c(
        "Improvement Type",
        paste0("Scenario ", slider_input$slider),
        "Example"
      ),
      fillContainer = FALSE,
      filter = "none",
      options = list(
        dom = "t",
        columnDefs = list(list(className = "dt-center", targets = 1))
      )
    )
    # %>%
    #   DT::formatStyle(
    #     columns = "value",
    #     # color = "black",
    #     # backgroundColor = "pink",
    #     borderColor = "white",
    #     borderTop = "2px",
    #     borderTopStyle = "solid",
    #     borderTopColor = "white"
    #   )
  })
}

## To be copied in the UI
# mod_table_network_improvements_ui("table_ui_1")

## To be copied in the server
# callModule(mod_table_network_improvements_server, "table_ui_1")
