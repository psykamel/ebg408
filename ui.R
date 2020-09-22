library(shiny)
library(plotly)

ui <- navbarPage(
  title = "Ebg408 Data Analysis Ver2.0",
  #page1-key result briefing ####
  tabPanel("phenomenon",
           headerPanel("phenomenon"),
           sidebarPanel(
             selectInput("group.ph",
                         label = "select group",
                         choices = c(1:80))
           ),
           mainPanel(
             tabsetPanel(
               tabPanel("final cash", plotlyOutput("ph.finalcash"), 
                        fluidRow(
                          column(6, tableOutput("ph.finalcashtbl")),
                          column(6, tableOutput("ph.finalcashsum"))
                        )),
               tabPanel("final stock", plotlyOutput("ph.finalstock"),
                        fluidRow(
                          column(6, tableOutput("ph.finalstocktbl")),
                          column(6, tableOutput("ph.finalstocksum"))
                        )),
               tabPanel("stock phasemap",plotlyOutput("ph.finastockphasemap")),
               tabPanel("price", plotlyOutput("ph.priceboxplot"))
             )
           )
           ),
  #page2-Patterns and Points of change setting ####
  tabPanel("behavior-analysis",
           headerPanel("behavior-analysis"),
           sidebarPanel(
             selectInput("group.ba",
                         label = "select group",
                         choices = c(1:80)),
             radioButtons("movavg.ba",
                          label = "movavg no.",
                          choices = list("1","2","3","4","5","6","7","8","9","10"),
                          selected = "5",
                          inline = TRUE)
           ),
           mainPanel(
               fluidRow(
                 splitLayout(
                   tabPanel("p1action_type", tableOutput("p1action_type")),
                   tabPanel("p2action_type", tableOutput("p2action_type"))
                 ),
                 splitLayout(
                   tabPanel("p1change_point", tableOutput("p1change_point")),
                   tabPanel("p2change_point", tableOutput("p2change_point"))
                 )
               )
             
           )),
  #page3-Correlations and Causalities finding ####
  tabPanel("causalities finding & labeling",
           headerPanel("causalities finding & labeling"),
           sidebarPanel(
             selectInput("group.cf",
                         label = "select group",
                         choices = c(1:80)),
             sliderInput("trials.cf",
                         label = "trial range",
                         min = 1,
                         max = 100,
                         value = c(1,100)),
             radioButtons("threshold", 
                          label = "alpha",
                          choices = list("0.001",
                                         "0.01", 
                                         "0.05",
                                         "1"),
                          selected = "0.01",
                          inline = TRUE)
           ),
           mainPanel(
             tabsetPanel(
               tabPanel("stockprice",
                        fluidRow(
                          column(6, plotlyOutput("exp.plot1"),
                                 tableOutput("exp.tbl1"),
                                 plotlyOutput("exp.plot2"),
                                 tableOutput("exp.tbl2")
                                 ),
                          column(6,
                                 plotlyOutput("paplot1"),
                                 splitLayout(cellWidths = c("30%","70%"),
                                   numericInput("price.pa1",
                                                 label = "cut-off point",
                                                 value = 100),
                                   tableOutput("padata1")
                                   ),
                                 plotlyOutput("paplot2"),
                                 splitLayout(cellWidths = c("30%","70%"),
                                             numericInput("price.pa2",
                                                          label = "cut-off point",
                                                          value = 100),
                                             tableOutput("padata2")
                                 )
                                 )
                                )
                        ),
               tabPanel("dprice",
                        fluidRow(
                          column(6, plotlyOutput("dprice.plot1"), tableOutput("dprice.table1")),
                          column(6, plotlyOutput("dprice.plot2"), tableOutput("dprice.table2"))
                        )),
               tabPanel("action",
                        h1("action"),
                        fluidRow(
                          column(6, plotlyOutput("dstck.plot1"), tableOutput("dstck.tbl1")),
                          column(6, plotlyOutput("dstck.plot2"), tableOutput("dstck.tbl2"))
                                ),
                        h1("action.j"),
                        fluidRow(
                          column(6, plotlyOutput("dstckj.plot1"), tableOutput("dstckj.tbl1")),
                          column(6, plotlyOutput("dstckj.plot2"), tableOutput("dstckj.tbl2"))
                                )
                        ),
               tabPanel("attitude",
                        h1("持股長短"),
                        radioButtons("movavg.ba",
                                     label = "movavg no.",
                                     choices = list("1","2","3","4","5","6","7","8","9","10"),
                                     selected = "5",
                                     inline = TRUE),
                        plotlyOutput("movavg"),
                        tableOutput("action_type"),
                        
                        h1("No Trade與決策"),
                        fluidRow(
                          column(6, plotlyOutput("naplot1")),
                          column(6, plotlyOutput("naplot2"))
                        ),
                        
                        h1("資產差與決策"),
                        fluidRow(
                          column(6, plotlyOutput("asstij.plot1")),
                          column(6, plotlyOutput("asstij.plot2"))
                        ),
                        h1("資產差變動與決策"),
                        fluidRow(
                          column(6, plotlyOutput("dasstij.plot1")),
                          column(6, plotlyOutput("dasstij.plot2"))
                        )),
               tabPanel("labeling",
                        tableOutput("label.info"),
                        fluidRow(
                          column(6, h1("p1 labels"), tableOutput("label.table.p1")),
                          column(6, h1("p2 labels"), tableOutput("label.table.p2"))
                        )
             )
           )
          ),
  #page4-Types labeling ####

  )
)