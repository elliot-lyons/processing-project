class homeScreen {
  int screen;
  ArrayList widgetList;
  color strokeColour;

  Widget Charity, Monthly, Yearly, States, Welcome, Heatmap, AboutUs, Quiz;
  PFont widgetFont;

  homeScreen(int screen)
  { 
    this.screen = screen;
    strokeColour = color(0, 0, 255);
    widgetFont = loadFont("AgencyFont.vlw");
    textFont(widgetFont);

    widgetList = new ArrayList();

    Monthly = new Widget (1500, 300, 280, 70, "Monthly Statistics", 
      yellow, widgetFont, MONTHLY);

    States = new Widget (1500, 380, 280, 70, "State Statistics", 
      yellow, widgetFont, STATES);

    Heatmap = new Widget (1500, 460, 280, 70, "Heat Map", 
      yellow, widgetFont, HEATMAP);

    Charity = new Widget (1500, 620, 280, 70, "Charity", 
      yellow, widgetFont, CHARITY);

    AboutUs = new Widget (1500, 700, 280, 70, "About us",
      yellow, widgetFont, ABOUTUS);

    Welcome = new Widget (520, 15, 830, 60, "Welcome to the US Covid-19 Data and Statistics App", 
      color (255, 255, 255), widgetFont, WELCOME);

    Quiz = new Widget(1500, 540, 280, 70, "Quiz", yellow, widgetFont, QUIZ);  

    widgetList.add(Welcome);
    widgetList.add(Charity);
    widgetList.add(AboutUs);
    widgetList.add(Monthly);
    widgetList.add(States);
    widgetList.add(Heatmap);
    widgetList.add(Quiz);
  }

  void settings() {
    size(SCREEN_X, SCREEN_Y);
  }

  void draw() {
    
    image(libertyStatue, 0, 0);                                 

    //image(covid19HSE, 688, 700);          //Bottom right image
    //covid19HSE.resize(512, 256);

    strokeWeight(4);
    Welcome.draw();
    Charity.draw();
    Monthly.draw();
    AboutUs.draw();
    States.draw();
    Heatmap.draw();
    Quiz.draw();

    fill(255);                          // these few lines of code print out today's cases and deaths, and the total cases and deaths because of it        
    text("As of today, the total number of reported Covid-19 cases in the US is " + overallCurrentCases + ",", 225, 200);
    text("and the overall death count is " + overallCurrentDeaths + ".", 420, 250);
    textFont(ArialBoldItalicMtTwenty);
    text("(Source: https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv)", 370, 275);
  }

  void whenMouseMoved(int x, int y) {                        //Mouse hovering over buttons for widget highlight
    int event;
    for (int i = 0; i < widgetList.size(); i++) {
      Widget theWidget = (Widget) widgetList.get(i);
      event = theWidget.getEvent(x, y);
      switch(event) {
      case CHARITY:
      case MONTHLY:
      case ABOUTUS:
      case STATES:
      case HEATMAP:
      case QUIZ:
        theWidget.strokeColor=(color(255));
        break;
      case EVENT_NULL:
        theWidget.strokeColor=(color(0));
        break;
      }
    }
  }

  void whenMousePressed() {
    int event;
    if (currentScreen == HOME_SCREEN)
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        event = aWidget.getEvent(mouseX, mouseY);
        switch(event) {
        case CHARITY:
          currentScreen = CHARITY_SCREEN;
          break;
        case MONTHLY:
          currentScreen = MONTH_SCREEN;
          monthScreenNeeded = 1;
          graphNeeded = true;
          break;
        case STATES:
          currentScreen = STATE_SCREEN_1;
          graphNeeded = true;
          break;
        case HEATMAP:
          currentScreen = HEATMAP_SCREEN;
          break;
        case ABOUTUS:
          currentScreen = ABOUTUS_SCREEN;
          break;
        case QUIZ:
          currentScreen = QUIZ_SCREEN_1;
          break;
        }
      }
    }
  }
}
