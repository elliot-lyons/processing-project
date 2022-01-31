class charityScreen {
  int screen;
  ArrayList widgetList;
  PFont widgetFont;

  Widget Back, Link, Title, Info;


  charityScreen(int screen) {
    this.screen = screen;

    widgetFont = loadFont("AgencyFont.vlw");
    textFont(widgetFont);

    widgetList = new ArrayList();                                                        //creating buttons for charity screen
    Back = new Widget (1500, 510, 280, 70, "Back", 
      color (0, 255, 160), widgetFont, BACK);
    Link = new Widget (1500, 430, 280, 70, "Link To Donate!", 
      color (0, 255, 160), widgetFont, DONATE);
    Title = new Widget (350, 25, 875, 70, "6,000 Children Could Die Every Day Because of COVID-19", 
      color (40, 255, 40), widgetFont, TITLE);
    Info = new Widget (25, 130, 1260, 600, "Children are at risk of becoming the hidden victims of COVID-19 because whilst" + "\n" + "they won't die from it they will die because of it." 
      + "\n" + "In fact, 6,000 more children could die every single day as a direct result of the" + "\n" + "coronavirus pandemic. That's one child every 15 seconds." + "\n" + 
      "The coronavirus (COVID-19) pandemic has upended the lives of children and" + "\n" + "their families around the world. Health systems have buckled, broders have" + "\n" +
      "closed, supply chains are cut-off, schools are shut and businesses have closed."  + "\n" + "That is why we must act immediately to give children, and their families," +
      "access to" + "\n" + "clean water, sanitation, life-saving food and medicine so they can protect" + "\n" + "themselves during this dangerous time.", 
      color (0, 160, 160), widgetFont, INFO); 

    widgetList.add(Link);
    widgetList.add(Back);
  }

  void draw() {
    image(africaVac, 1, 1);                                 
    africaVac.resize(1800, 900);      //Background
    Back.draw();
    Link.draw();
    Title.draw();
    Info.draw();
  }
  void whenMousePressed() {
    int event;
    if (currentScreen == CHARITY_SCREEN)
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        event = aWidget.getEvent(mouseX, mouseY);
        if (event == BACK) {
          println("pressed");
          currentScreen = HOME_SCREEN;
        } 
        if (event == DONATE) {
          println("pressed");
          link("https://www.unicef.ie/donate/coronavirus/?ch=GA&gclid=CjwKCAjw3pWDBhB3EiwAV1c5rOhWktcCgQMmhwIc6xcHo01u_yp7FJnEnxe3t6FoxPgMIgo07olUDhoCoqkQAvD_BwE#1");
        }
      }
    }
  }
  void whenMouseMoved(int x, int y) {                        //Mouse hovering over buttons for widget highlight
    int event;
    for (int i = 0; i < widgetList.size(); i++) {
      Widget theWidget = (Widget) widgetList.get(i);
      event = theWidget.getEvent(x, y);
      switch(event) {
      case BACK:
      case DONATE:
        theWidget.strokeColor=(color(255));
        break;
      case EVENT_NULL:
        theWidget.strokeColor=(color(0));
        break;
      }
    }
  }
}
