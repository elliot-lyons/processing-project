class AboutUs {

  int screen;
  ArrayList widgetList;
  boolean backMp = false;

  Widget Title, Name, AboutUs, Email, Ali, Ana, Elliot, Wicky, aboutAli, aboutAna, aboutElliot, aboutWicky, AliEmail, AnaEmail, ElliotEmail, WickyEmail;

  PFont widgetFont;

  AboutUs (int screen) {
    this.screen = screen;

    widgetFont = loadFont("AgencyFont.vlw");
    textFont(widgetFont);

    widgetList = new ArrayList();

    Title = new Widget (550, 10, 725, 75, "Who are we?", 
      color (255, 255, 255), widgetFont, TITLE);
    Name = new Widget (85, 200, 350, 60, "Name:", 
      color (255, 255, 255), widgetFont, TITLE);
    AboutUs = new Widget (945, 200, 760, 60, "About us:", 
      color (255, 255, 255), widgetFont, TITLE);
    Email = new Widget (515, 200, 350, 60, "Email:", 
      color (255, 255, 255), widgetFont, TITLE);
    


    Ali = new Widget (85, 355, 350, 60, "Ali Al Ani", 
      color (255, 255, 255), widgetFont, TITLE);  
    Ana = new Widget (85, 455, 350, 120, "Anastasiya" + "\n" + "Bogoslovskaya", 
      color (255, 255, 255), widgetFont, TITLE);  
    Elliot = new Widget (85, 625, 350, 60, "Elliot Lyons", 
      color (255, 255, 255), widgetFont, TITLE);  
    Wicky = new Widget (85, 760, 350, 60, "Wiktoria Fabijaniak", 
      color (255, 255, 255), widgetFont, TITLE);  


    aboutAli = new Widget (945, 320, 760, 120, "21, Love gaming, football and of course" + "\n" + "programming", 
      color (255, 255, 255), widgetFont, TITLE);  
    aboutAna = new Widget (945, 455, 760, 120, "18, Irish, plays tennis and "  + "\n" + "loves chocolate", 
      color (255, 255, 255), widgetFont, TITLE);  
    aboutElliot = new Widget (945, 590, 760, 120,"19, Irish, Against poorly named" + "\n" + "variables and the ESL", 
      color (255, 255, 255), widgetFont, TITLE);  
    aboutWicky = new Widget (945, 725, 760, 120, "19, Polish, love pasta and" + "\n" + "against Lewandowski", 
      color (255, 255, 255), widgetFont, TITLE);  

    AliEmail = new Widget (515, 355, 350, 60, "alania@tcd.ie", 
      color (255, 255, 255), widgetFont, TITLE);  
    AnaEmail = new Widget (515, 490, 350, 60, "bogosloa@tcd.ie", 
      color (255, 255, 255), widgetFont, TITLE); 
    ElliotEmail = new Widget (515, 625, 350, 60, "lyonse7@tcd.ie", 
      color (255, 255, 255), widgetFont, TITLE);  
    WickyEmail = new Widget (515, 760, 350, 60, "fabijanw@tcd.ie", 
      color (255, 255, 255), widgetFont, TITLE);  


    backMp = false;
  }

  void settings() {
    size(SCREEN_X, SCREEN_Y);
  }

  void draw() {
    image(template, 1, 1);                                 
    template.resize(1800, 900);      //Background
    Title.draw();
    Name.draw();
    AboutUs.draw();
    Email.draw();
    Ali.draw();
    Elliot.draw();
    Ana.draw();
    Wicky.draw();
    aboutAli.draw();
    aboutAna.draw();
    aboutElliot.draw();
    aboutWicky.draw();
    AliEmail.draw();
    AnaEmail.draw();
    ElliotEmail.draw();
    WickyEmail.draw();
    backButton(mouseX, mouseY);
    backMp = false;
  }
  void backButton(int mX, int mY)                                        // this is a back button which lets the user return to the previous screen
  {
    if (mX >= BACK_BUTTON_X_ORG && mX <= BACK_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y) 
    {
      stroke(255);

      if (backMp)
      {  
        backMp = false;
        currentScreen = HOME_SCREEN;
      }
    } else
    {
      stroke(0);
    }

    fill(grey);
    rect(BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text("Home", BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    stroke(0);
  }
}
