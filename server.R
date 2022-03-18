
server <- function(input, output, session){
  
  # create all roster selection inputs
  output$rosterSelections <- renderUI({
    
    shinydashboard::box(title = "Select your roster:", solidHeader = TRUE, width = 12, 
                        status = "info", height = "100%", 
                        lapply(1:length(rosterFormation), function(x){
                          pos <- rosterFormation[x]
                          do.call(selectInput, 
                                  list(inputId = paste0(pos, x), 
                                       label = pos, 
                                       choices = c("None", unique(scores_2019[which(scores_2019$Pos == pos), "Player"]))
                                  )
                          )# end do.call
                        })# end lapply
    )# end box
  })# end renderUI
  
  observeEvent(
    # trigger this observeEvent when any of the dynamically generated inputs are changed
    lapply(1:length(rosterFormation), function(x)
      input[[paste0(rosterFormation[x], x)]]
    ),{
      
      # initialize players vector
      players <- c()
      
      # go through all inputs and add them to a reactive values object
      for(x in 1:length(rosterFormation)){
        pos <- rosterFormation[x]
        players <- c(players, input[[paste0(pos, x)]])
      }# end for x loop
      
      # add logic for figures
      mod_figures_server("figures", players)
      
  })# end observeEvent
  
}# end server