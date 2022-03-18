
mod_figures_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("PointDifferenceLine")),
    plotlyOutput(ns("PointDifferenceBox"))
  )
  
}# end of mod_fiugres_ui



# Server logic ------------------------------------------------------------

mod_figures_server <- function(id, selectedRoster) {
  moduleServer(
    id, 
    function(input, output, session) {
      
      players <- unlist(reactiveValuesToList(selectedRoster))
      
      df <- scores_2019 %>%
        filter(Player %in% players)
      
      if(nrow(df) > 0){
        output$PointDifferenceLine <- plotly::renderPlotly(
          ggplotly(
            ggplot(df, aes(x=Week, y=Difference, color=Player)) +
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
        output$PointDifferenceLine <- plotly::renderPlotly(ggplotly(ggplot()))
        output$PointDifferenceBox <- plotly::renderPlotly(ggplotly(ggplot()))
      }
      
    })# end moduleServer
}# end of mod_figures_server
