library(shiny)
shinyApp(
    ui = dashboardPage(
        dashboardHeader(),
        dashboardSidebar(),
        dashboardBody(),
        title = "Dashboard example"
    ),
    server = function(input, output) { }
)
}
