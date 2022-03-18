
# ui ----------------------------------------------------------------
mod_figures_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinydashboard::box(title = "", width = 12, 
                        plotly::plotlyOutput(ns("PointDifferenceLine")),
                        br(), 
                        plotly::plotlyOutput(ns("PointDifferenceBox")),
                        br()
    )# end box
  )# end tagList
}# end of mod_fiugres_ui



# server ------------------------------------------------------------

mod_figures_server <- function(id, players) {
  moduleServer(
    id, 
    function(input, output, session) {
      
      df <- scores_2019 %>%
        dplyr::filter(Player %in% players)
      
      if(nrow(df) > 0){
        output$PointDifferenceLine <- plotly::renderPlotly(
          plotly::ggplotly(
            ggplot2::ggplot(df, aes(x=Week, y=Difference, color=Player)) +
              geom_line(lwd = 1) +
              geom_point() +
              labs(title = "Difference in Actual and Projected Points by Week")
          )# end ggplotly
        )# end renderPlotly
        
        output$PointDifferenceBox <- plotly::renderPlotly(
          ggplotly(
            ggplot(df, aes(x=Player, y=Difference, color=Player)) +
              geom_boxplot() +
              labs(title = "Difference in Actual and Projected Points")
          )# end ggplotly
        )# end renderPlotly
        
      } else {
        # show empty figures if no player is selected
        output$PointDifferenceLine <- plotly::renderPlotly(
          plotly::ggplotly(ggplot2::ggplot())
        )
        
        output$PointDifferenceBox <- plotly::renderPlotly(
          plotly::ggplotly(ggplot2::ggplot())
        )
      }
      
    })# end moduleServer
}# end of mod_figures_server
