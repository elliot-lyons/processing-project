class DateBreakdown                                          // this is a breakdown of the amount of cases on a specific day
{
  String date;
  ArrayList<covidDataRow> theList;
  ArrayList<String> allStates;
  String first;
  String second;
  String third;
  int firstCases;
  int secondCases;
  int thirdCases;
  boolean backMp;
  double firstPercentage;
  int firstPercent;
  double secondPercentage;
  int secondPercent;
  double thirdPercentage;
  int thirdPercent;

  DateBreakdown(ArrayList<covidDataRow> theList, String date, ArrayList<String> allStates)
  {
    this.date = date;
    this.theList = theList;
    this.allStates = allStates;
    backMp = false;

    first = "";
    second = "";
    third = "";
    firstCases = 0;
    secondCases = 0;
    thirdCases = 0;

    this.rankings();
  }

  void rankings()                                                  // this goes through each state and figures out the states with the top 3 highest cases on that day
  {
    covidDataRow currentRow;
    int currentCases = 0;

    for (int i = 0; i < allStates.size(); i++)
    {
      for (int j = 0; j < theList.size(); j++)
      {
        currentRow = theList.get(j);

        if (allStates.get(i).equals(currentRow.state) && currentRow.date.equals(date))
        {
          currentCases += currentRow.cases;
        }
      }

      if (currentCases >= firstCases)
      {
        secondCases = firstCases;
        firstCases = currentCases;
        second = first;
        first = allStates.get(i);
      } else if (currentCases >= secondCases) {
        thirdCases = secondCases;
        secondCases = currentCases;
        third = second;
        second = allStates.get(i);
      } else if (currentCases >= thirdCases) {
        thirdCases = currentCases;
        third = allStates.get(i);
      }

      currentCases = 0;
    }
  }

  void draw()                                                            // this just draws the top 3 cases to the screen
  {
    stroke(0);
    whiteHouse.resize(1800,900);
    image(whiteHouse, 1, 1);
    firstPercentage = (((double) firstCases / (double) dateCases) * 100);
    firstPercent = (int) firstPercentage;

    secondPercentage = (((double) secondCases / (double) dateCases) * 100);
    secondPercent = (int) secondPercentage;

    thirdPercentage = (((double) thirdCases / (double) dateCases) * 100);
    thirdPercent = (int) thirdPercentage;

    fill(0);
    textFont(ArialBoldItalicMtTwenty);

    backButton(mouseX, mouseY);
    homeButton(mouseX, mouseY);

    //Anastasiya
    fill(0);
    textFont(ArialBoldMT35);
    text("Top cases on the " + date, (SCREEN_X / 2) - 250, 50);
    textFont(ArialBoldItalicMtSixteen);
    text("state, cases, percent of total cases", (SCREEN_X / 2) - 140, 70); 


    // AB: 2ND PLACE BOX
    fill(192, 192, 192); //silver
    rect(410, 720, 300, 100);

    //2ND PLACE NUMBER
    fill(255);
    textFont(numbersTextForty);
    textSize(65);
    textAlign(CENTER, CENTER);
    text("2", 410, 720, 300, 100);

    //2nd place text
    textSize(35);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text(second + ": " + secondCases + ", " + secondPercent + "%", 560, 700);

    //1ST PLACE BOX
    fill(255, 215, 0); //gold
    rect(710, 670, 370, 150);

    //FIRST PLACE NUMBER
    fill(255);
    textFont(numbersTextForty);
    textSize(120);
    textAlign(CENTER, CENTER);
    text("1", 740, 660, 300, 150);

    // AB: 1st place text
    textSize(35);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text(first + ": " + firstCases + ", " + firstPercent + "%", 900, 650);

    //3RD PLACE BOX
    fill(205, 127, 50); //bronze
    rect(1080, 740, 300, 80);

    //3RD PLACE NUMBER
    fill(255);
    textFont(numbersTextForty);
    textSize(55);
    textAlign(CENTER, CENTER);
    text("3", 1080, 730, 300, 80);

    // AB: 3rd place text
    textSize(35);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text(third + ": " + thirdCases + ", " + thirdPercent + "%", 1230, 720);

    textAlign(LEFT, BOTTOM);
  }

  void backButton(int mX, int mY)                                        // this is a back button which lets the user return to the previous screen
  {
    if (mX >= BACK_BUTTON_X_ORG && mX <= BACK_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y) 
    {
      stroke(255);

      if (backMp)
      {  
        backMp = false;
        currentScreen = DAILY_SCREEN;
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
    text("Back", BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    stroke(0);
  }
  
  void homeButton(int mX, int mY)                      // simple button to take the user back to the home screen
  {
    if (mX >= HOME_BUTTON_X_ORG && mX <= HOME_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y) 
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
    rect(HOME_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text("Home", HOME_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    stroke(0);
  }
    
}
