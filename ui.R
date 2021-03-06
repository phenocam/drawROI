


fluidPage(
  shinyjs::useShinyjs(),  
  tags$head(tags$style(HTML( "#Select1 ~ .selectize-control.single .selectize-input {border: 1px solid #fff;}"))),
  tabsetPanel(
    tabPanel('ROI Tool',
             headerPanel("PhenoCam ROI Tool"),
             sidebarPanel(width = 4,
                          fluidRow(
                            column(10, 
                                   selectInput("siteName", "Site", choices = 'acadia')
                            ),
                            br(),
                            column(2, strong(actionButton('siteInfo', label = NULL, icon = icon('info'), width = '100%', style="border-color: #f5f5f5; align:center; background-color:#f5f5f5; color:#337ab7; font-size: 200%;font-weight: bold;")),
                                   bsModal("modalSiteInfo", "Site Info", "siteInfo", 
                                           size = "medium",
                                           footer = NULL, 
                                           tableOutput("tblSiteInfo")
                                   )
                            )
                          ),
                          fluidRow(
                            column(10, selectInput("roiName", "ROI", 'New ROI')),
                            br(),
                            br(),
                            # column(2, actionButton('refreshROI', label = NULL, icon = icon('refresh'), width = '100%', style="border-color: #f5f5f5; align:center; background-color:#f5f5f5; color:#337ab7; font-size: 150%;font-weight: bold;"))
                            column(2, strong(textOutput('noROI')))
                          ),
                          selectInput("vegType", "Vegetation Type", choices = list('Agriculture (AG)'='AG')),
                          textInput('siteDescription','Description', placeholder = 'Enter a description for the ROI'),
                          textInput('roiOwner','Owner', placeholder = 'Enter your name'),
                          hr(),
                          strong(textOutput('roiFileName')),
                          br(),
                          selectInput("maskName", label = 'Mask', choices = 'New mask'),
                          # textOutput('maskfilename'),
                          strong('Sample Image:'),
                          textOutput('sampleImagePath'),
                          br(),
                          fluidRow(
                            column(6, actionButton( 'matchStart', 'Match start', width = '100%', style='background-color:#666; color:#fff;font-weight: bold;')),
                            column(6, actionButton( 'matchEnd', 'Match end', width = '100%', style='background-color:#666; color:#fff;font-weight: bold;'))
                          ),
                          br(),
                          
                          fluidRow(
                            column(1, strong('from', style='font-size:70%;font-weight: bold;')),
                            column(5, dateInput('maskStartDate', label = NULL, value =  '2001-01-01', startview = 'day')),
                            column(4, textInput('maskStartTime', label = NULL, value = '00:08:00')),
                            column(1, '')
                          ),
                          fluidRow(
                            column(1, strong('to', style='font-size:70%')),
                            column(5, dateInput('maskEndDate', label = NULL, value =  '2099-01-01', startview = 'day')),
                            column(4, textInput('maskEndTime', label = NULL, value = '00:20:00')),
                            column(1, checkboxInput('openEnd', label = '', value = F))
                          ),
                          
                          
                          br(),
                          fluidRow(
                            column(6, downloadButton("downloadROI", "Download ROI files")),
                            column(6, actionButton("emailROI", "Submit for review", icon = icon('send'), width = "100%"))
                          ),
                          br(),
                          br(),
                          passwordInput("password", label = NULL, placeholder = 'Password to save in the database'),
                          actionButton("saveROI", "Save ROI files in the database", icon = icon('list-alt'), width = "100%")
                          
             ),
             
             
             
             
             
             
             mainPanel(              
               br(),
               fluidRow(
                 column(2, sliderInput('hazeThreshold', label = 'Haze threshold', min = 0, max = 1, value = .45, step = .01)),
                 
                 column(3, selectInput('shiftsList1', label = 'Horizon Shifts', choices = c(Choose=''), width = '100%')),
                 # column(1, actionButton('goShift1', label = NULL, icon = icon('refresh'), width = '100%', 
                 #                        style="border-color: #fff; align:center; font-size: 200%;font-weight: bold;")),
                 # column(2, selectInput('shiftsList1.Threshold', label = 'Threshold (px)', choices = c(1:10, 15:30), selectize = T, selected = 10)),
                 column(2, sliderInput('shiftsList1.Threshold', label = 'Threshold (px)', min = 1, max = 50, value = 10, step = 1)),
                 
                 column(3, selectInput('shiftsList2', label = 'Correlation Shifts', choices = c(Choose=''), width = '100%')),
                 # column(1, actionButton('goShift2', label = NULL, icon = icon('refresh'), width = '100%', 
                 #                        style="border-color: #fff; align:center; font-size: 200%;font-weight: bold;"))
                 # column(2, selectInput('shiftsList2.Threshold', label = 'Threshold', selectize = T, choices = c(.01, 0.02, .05, .1, .15, .2, .3, .4, .5, .6, .75), selected = .05))
                 column(2, sliderInput('shiftsList2.Threshold', label = 'Threshold (R)', min = 0, max = 1, value = .5, step = .05))
               ),
               
               tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max {visibility: hidden !important;}'))),
               conditionalPanel(
                 condition = "input.cliShow",
                 sliderInput(inputId = "clRange",
                             label =  NULL,
                             min = 1, max = 2,
                             ticks = F,
                             animate=F,
                             value = c(1, 2),
                             step = 1,
                             width = '100%'),
                 plotOutput("clPlot", click = "clPoint", height = 'auto'),
                 br()
               ),
               
               fluidRow( 
                 column(3, 
                        fluidRow( 
                          column(8, strong(dateInput('gotoDate', label = ''), style='font-size:20%;font-weight: bold;')),
                          column(4, actionButton('gotoDateButton', label = NULL, icon = icon('refresh'), width = '100%', style="border-color: #fff; align:center; font-size: 200%;font-weight: bold;"))
                        )
                 ),
                 column(9, sliderInput(inputId = "contID",
                                       label =  NULL,
                                       min = 1, max = 1,
                                       ticks = F,
                                       animate=F,
                                       value = 1,
                                       step = 1,
                                       width = '100%'))
               ),
               
               
               fluidRow(
                 column(1, strong()),
                 column(1, actionButton("back", "", icon = icon('minus'), width = '100%', style="border-color: #fff")),
                 column(1, actionButton("backplay", "", icon = icon('backward'), width = '100%', style="border-color: #fff; align:center")),
                 column(1, actionButton("pause", "", icon = icon('stop'), width = '100%',  style="border-color: #fff")),
                 column(1, actionButton("play", "", icon = icon('forward'), width = '100%', style="border-color: #fff; align:center")),
                 column(1, actionButton("forw", "", icon = icon('plus'), width = '100%',  style="border-color: #fff")),
                 # column(1, strong()),
                 column(1, actionButton("linkedImage", "", icon = icon('copy'), style='font-weight: bold;border-color: #fff')),
                 column(2, checkboxInput("lastNextDayShow", label = 'Before/After', value = F)),
                 column(2, checkboxInput("cliShow", label = 'CL Image', value = F)),
                 column(1, strong())
                 
               ),
               fluidRow(
                 column(1, actionButton('previousSite', label = NULL, icon = icon('arrow-circle-left'), width = '100%',  style="border-color: #fff; font-size: 175%")),
                 column(5, plotOutput("imagePlot", click = "newPoint", dblclick = 'gapPoint', height = 'auto')),
                 column(5, plotOutput("imagePlot2", height = 'auto')),
                 column(1, actionButton('nextSite', label = NULL, icon = icon('arrow-circle-right'), width = '100%',  style="border-color: #fff; font-size: 175%"))
               ),
               
               conditionalPanel(
                 condition = "input.lastNextDayShow",
                 br(),
                 fluidRow(
                   column(1, strong()),
                   column(5, plotOutput("previousDay", height = 'auto')),
                   column(5, plotOutput("nextDay", height = 'auto')),
                   column(1, strong())
                 )
               ) ,
               
               fluidRow(
                 br(),
                 
                 column(1, strong()),
                 column(5, plotOutput("maskPlot", height = 'auto')),
                 # column(1, strong()),
                 column(1, 
                        br(),
                        colourpicker::colourInput(inputId = 'roiColors', 
                                                  allowTransparent=T, 
                                                  # transparentText = 'clear',
                                                  label = NULL,
                                                  value = '#ab522200', 
                                                  showColour = 'background')
                 ),
                 column(1, strong()),
                 column(2, 
                        br(),
                        actionButton("clearCanvas", "Erase", icon = icon('eraser'), class="btn-primary", width = "110px", style='font-weight: bold;'),
                        br(),br(),
                        actionButton("undoCanvas", "Undo", icon = icon('undo'), class="btn-primary", width = "110px", style='font-weight: bold;'),
                        br(),br(),
                        actionButton("acceptCanvas", "Accept", icon = icon('thumbs-up'), class="btn-primary", width = "110px", style='font-weight: bold;')
                 ),
                 column(2, strong())
               ),
               br(),
               
               # fluidRow(
               #   column(1, strong()),
               #   column(5, 
               #          fluidRow(
               #            column(4, actionButton("clearCanvas", "Erase", icon = icon('eraser'), class="btn-primary", width = "100%", style='font-weight: bold;')),
               #            column(4, actionButton("undoCanvas", "Undo", icon = icon('undo'), class="btn-primary", width = "100%", style='font-weight: bold;')),
               #            column(4, actionButton("acceptCanvas", "Accept", icon = icon('thumbs-up'), class="btn-primary", width = "100%", style='font-weight: bold;'))
               #          )),
               #   column(5,
               #          fluidRow(
               #            column( 5, shinyjs::colourInput(inputId = 'roiColors', allowTransparent=T, 
               #                                                 transparentText = 'clear',
               #                                                 label = NULL,value = '#ab5222', showColour = 'background'))
               #            # column( 7, p())
               #          )
               #   ),
               #   column(1, strong())
               # ),
               
               
               hr(),
               
               fluidRow(
                 column(2, 
                        radioButtons('ccRange', label = NULL, choices = c('Week', 'Month', 'Year', 'Entire data'), width = "330px",inline = F),
                        
                        selectInput('ccInterval', label = 'Interval', choices = c(1:7, 10, 15, 20, 30), selected = 1, width = '50px'),
                        
                        actionButton("startExtractCC", "Extract", icon = icon('line-chart'), onclick="Shiny.onInputChange('stopThis',false)", width = "110px", style="background-color:#666; color:#fff;font-weight: bold;"),
                        hr(),
                        checkboxGroupInput('ccBand', label = NULL, choices = c(Red='R', Green='G', Blue='B', Haze= 'H'), selected = c('R','G','B'), width = '100%', inline = F),
                        hr(),
                        downloadButton("downloadTSData", "Download\t")
                 ),
                 column(10, plotlyOutput(outputId = "timeSeriesPlotly", height = "500px", width = "100%"))
                 
               )
               
               
             )
    ),
    
    tabPanel('Report Errors', 
             fluidPage(
               headerPanel('Report an error'),
               br(),
               sidebarPanel(    
                 textInput('errorUser', label = 'Your contact info', placeholder = 'Name', width = '100%'),
                 textInput('errorEmail', label = NULL, placeholder = 'Email', width = '100%'),
                 selectInput('errorSite', label = 'Site', choices = ''),
                 selectizeInput('errorOS', label = 'System info', choices = c('Windows','Linux','MacOS', 'Android', 'iOS')),
                 selectizeInput('errorBrowser', label = NULL, choices = c('Firefox', 'Google Chrome', 'Internet Explorer', 'Opera','Safari','Others')),
                 dateInput("errorDate", label = "Error date/time", value = Sys.Date()),
                 textInput("errorTime", label = NULL, value = strftime(Sys.time(), format = '%H:%M:%S'), placeholder = 'What time did the error occure?'),
                 selectInput('errorType', label = 'It crashed?', choices = c('Yes, it crashed.', 
                                                                             'No, it just returned an error message.',
                                                                             'No, but the output does not make sense.',
                                                                             'No, I have some suggestions.'), selected = ''),
                 actionButton("errorSend", "Submit", width = '100%', icon = icon('send'), class="btn-primary")
               ),
               
               mainPanel( 
                 textAreaInput('errorMessage', label = 'Explain the error please.', cols = 200, rows = 20) 
               )               
             )
    # ),
    # 
    # tabPanel('Simple Tutorial', 
    #          fluidPage(
    #            # HTML('<img src="phenoCamROI.guide.png"  alt="This is alternate text" , width="100%">')
    #            includeMarkdown('drawROI.Guide.md')
    #          )
    )
    
  )
)



