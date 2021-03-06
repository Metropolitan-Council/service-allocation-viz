#' plot_new_access UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_new_access_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("new_access"))
  )
}

#' plot_new_access Server Function
#'
#' @noRd
mod_plot_new_access_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting
) {
  ns <- session$ns

  output$new_access <- plotly::renderPlotly({

    # browser()
    ggplotly(
      tooltip = "text",
      ggplot(data_for_plotting$summary_context_data[expand_improve == "Expand", ]) +
        geom_col(
          aes(
            x = scenario_short,
            y = total,
            fill = type,
            group = type,
            text = hover_text
          ),
          position = position_dodge2(
            padding = 0.1
          )
        ) +
        geom_col(
          data_for_plotting$summary_context_data[expand_improve == "Expand", ][selected == 0, ],
          mapping = aes(
            x = scenario_short,
            y = total,
            group = type,
            text = hover_text
          ),
          position = position_dodge2(
            padding = 0.1
          ),
          fill = "gray",
          alpha = 1
        ) +
        scale_y_continuous(
          labels = scales::label_comma(prefix = "+"),
          breaks = c(
            50 * 1000,
            100 * 1000,
            150 * 1000
          )
        ) +
        scale_fill_manual(
          values = coverage_colors,
          labels = c(
            "People",
            "Jobs"
          ),
          name = ""
        ) +
        labs(
          title = "People and Jobs with New Access to All Day Transit",
          x = "",
          y = ""
        ) +
        app_theme() +
        theme(
          # axis.title.x = ggplot2::element_text(
          #   vjust = -1,
          #   family = font_families$font_family_axis_title,
          #   size = font_sizes$font_size_axis_title
          # ),
          # axis.title.y = ggplot2::element_text(
          #   vjust = 2,
          #   family = font_families$font_family_axis_title,
          #   size = font_sizes$font_size_axis_title
          # ),
          axis.text.x = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 0.5
          ),
          axis.text.y = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 1
          )
        )
    ) %>%
      plotly::layout(
        margin = list(l = 0, r = 0, b = 10, t = 50, pad = 10),
        # l = left; r = right; t = top; b = bottom
        # xaxis = axis_options,
        # yaxis = axis_options,
        showlegend = TRUE,
        legend = list(
          orientation = "h",
          y = -0.12,
          traceorder = "normal"
        ),
        annotations = list(
          visible = FALSE,
          font = list(
            family = font_family_list,
            size = 30,
            color = councilR::colors$suppBlack
          )
        ),
        # hovermode = "x-unified",
        hoverdistance = "5",
        hoverlabel = list(
          #----
          font = list(
            size = font_sizes$font_size_strip_title,
            family = font_family_list,
            color = "black"
          ),
          bgcolor = "white",
          bordercolor = "white",
          padding = list(l = 10, r = 10, b = 10, t = 10)
        )
      ) %>%
      plotly::config(
        displaylogo = F,
        showSendToCloud = F,
        displayModeBar = F
      )
  })
}

## To be copied in the UI
# mod_plot_new_access_ui("plot_new_access_ui_1")

## To be copied in the server
# callModule(mod_plot_new_access_server, "plot_new_access_ui_1")
