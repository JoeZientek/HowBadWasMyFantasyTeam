
server <- function(input, output, session){
  
  # intialize reactive selectedRoster object
  selectedRoster <- reactiveValues()
  
  # create all roster selection inputs
  output$rosterSelections <- renderUI({
    lapply(1:length(rosterFormation), function(x){
      pos <- rosterFormation[x]
      do.call(selectInput, 
              list(inputId = paste0(pos, x), 
                   label = pos, 
                   choices = c("None", unique(scores_2019[which(scores_2019$Pos == pos), "Player"]))
              )
      )# end do.call
    })# end lapply
  })# end renderUI
  
  # go through all inputs and add them to a reactive values object
  observeEvent(
    # trigger this observeEvent when any of the dynamically generated inputs are changed
    lapply(1:length(rosterFormation), function(x)
      input[[paste0(rosterFormation[x], x)]]
    ),{
      
      for(x in 1:length(rosterFormation)){
        pos <- rosterFormation[x]
        selectedRoster[[paste0(pos, x)]] <- input[[paste0(pos, x)]]
      }# end for x loop
      
  })# end observeEvent
  
  # add server logic
  mod_figures_server("figures", selectedRoster)
  
}# end server