class DateGraph
{
  private double xRatio;
  private double maxHeight;
  private double barHeight;
  String[] representedArray;
  private boolean backMp;
  private String xAxisTitle;                      

  ArrayList theList;
  covidDataRow currentRow;

  GraphBar graphBar;
  GraphBar[] graphBarList;

  DateGraph(ArrayList<covidDataRow> aList, String[] anArray)
  { 
    theList = aList;                                
    graphBarList = new GraphBar[anArray.length];
    representedArray = anArray;

    xRatio = (double) GRAPH_X / (double) representedArray.length;                                                       // this determines the spacing on the x-axis for the month labels
    initArray(graphBarList, representedArray);                                                                         
    maxHeight = maxCases();
    backMp = false;
  }

  void draw()
  {
    strokeWeight(1);
    background(blue);
    stroke(0);
    textFont(ArialMtTwelve);
    line(LEFT_GRAPH_X_ORIGIN, GRAPH_Y_ORIGIN, LEFT_GRAPH_X_ORIGIN + GRAPH_X, GRAPH_Y_ORIGIN);                  // this draws the x-axis

    line(LEFT_GRAPH_X_ORIGIN, GRAPH_Y_ORIGIN, LEFT_GRAPH_X_ORIGIN, GRAPH_Y_ORIGIN - GRAPH_Y);                  // this draws the y-axis

    createAxes(representedArray, xRatio);                                                                      // this adds the appropriate labels to the axes
    textFont(representedArray.length == TOTAL_MONTHS ? (ArialMtSixteen) : (ArialMtEight));

    for (int i = 0; i < graphBarList.length; i++)
    {
      graphBar = graphBarList[i];
      barHeight  = graphBar.currentCases * (GRAPH_Y / maxHeight);
      graphBarList[i].mouseMoved(barHeight);
      stroke(graphBarList[i].strokeColor);
      fill(255, graphBar.colorNo, 0);

      rect((float) (graphBar.xOrigin), (float) (graphBar.yLimit - (graphBar.currentCases * (GRAPH_Y / maxHeight))), (float) graphBar.xRatio - 1, // draws the bars
        (float) barHeight);                                                                                      

      fill(0);
      text(graphBar.currentCases, (float) 
        (representedArray.length == TOTAL_MONTHS ? (graphBar.currentCases < 1000000 ? (graphBar.xOrigin + 25) : graphBar.xOrigin + 10) : graphBar.xOrigin), (float)               // draws the number of cases                                                     
        (graphBar.yLimit - (graphBar.currentCases * (GRAPH_Y / maxHeight)) - GRAPH_X_TEXT_MARGIN));

      text("cases", (float) (graphBar.xOrigin +(representedArray.length == TOTAL_MONTHS ? 20 : 0)), (float) (graphBar.yLimit - (graphBar.currentCases * (GRAPH_Y / maxHeight)) - 5));   // draws "cases"
    }

    firstMessage(currentScreen);

    graphTitle(currentScreen);

    if (breakdownUsed)                                              // this is just a bug fix, so that you can go from the date breakdown to the daily screen
    {
      backMp = false;
      breakdownUsed = false;
    }

    backButton(mouseX, mouseY);

    if (currentScreen == STATE_SCREEN_1)
    {
      nextButton(mouseX, mouseY);
    }

    if (currentScreen == DAILY_SCREEN || currentScreen == STATE_SCREEN_2)
    {
      homeButton(mouseX, mouseY);
    }

    backMp = false;
  }


  void createAxes(String[] anArray, double xRatio)
  {
    double xRat = xRatio;
    fill(0);
    textFont(anArray.length == TOTAL_MONTHS ? (ArialBoldItalicMtSixteen) : (ArialBoldItalicMtEight));
    for (int i = 0; i < anArray.length; i++)
    {
      String currentString = "" + anArray[i];
      
      if (currentString.equals("District of Columbia"))
      {
        currentString = "D.C.";
      }
      
      text(currentString, (float) (LEFT_GRAPH_X_ORIGIN + (i * xRat) + (currentScreen == MONTH_SCREEN ? (xRat / 4) : 0)), // this outputs each x variable onto the screen and puts it into the correct
        (float) (GRAPH_Y_ORIGIN + GRAPH_X_TEXT_MARGIN));                                                              // position onto the x-axis as a label 

      line((float) (LEFT_GRAPH_X_ORIGIN +(xRat * (i + 1))), (float) GRAPH_Y_ORIGIN, // this adds a little vertical line divider between the x-axis labels 
        (float) (LEFT_GRAPH_X_ORIGIN +(xRat * (i + 1))), (float) GRAPH_Y_ORIGIN - 5);
    }

    textFont(ArialBoldItalicMtSixteen);
    text((int) maxHeight, (float) LEFT_GRAPH_X_ORIGIN - GRAPH_Y_TEXT_MARGIN - (maxHeight > 1000000 ? 15 : 0), 
      (float) GRAPH_Y_ORIGIN - GRAPH_Y + DIVIDER_LINE);                                                               // this prints the number of the heighest cases at the top of the y-axis
    line((float) LEFT_GRAPH_X_ORIGIN, (float) (GRAPH_Y_ORIGIN - GRAPH_Y), 
      (float) LEFT_GRAPH_X_ORIGIN + DIVIDER_LINE, (float) (GRAPH_Y_ORIGIN - GRAPH_Y));                                // this adds a little horizontal divider line to the top of the y-axis

    yAxisIntervals((int)maxHeight);                                                                                   // this labels the y-axis in even intervals 

    textFont(ArialBoldItalicMtTwenty);
    text("Cases", (float) (LEFT_GRAPH_X_ORIGIN - AXES_LABEL_TEXT_MARGIN), // this draws "Cases" above the y-axis. It's the title of the axis
      (float) (GRAPH_Y_ORIGIN - GRAPH_Y - 20));

    xAxisTitle = xTitle(currentScreen);                // this determines what title will be displayed along the x-axis

    text(xAxisTitle, (float) (LEFT_GRAPH_X_ORIGIN + (GRAPH_X / 2)), // this draws the title of the x-axis below the x-axis
      (float) (GRAPH_Y_ORIGIN + AXES_LABEL_TEXT_MARGIN)-15);
  }                                                                                                            

  void initArray(GraphBar[] theBars, String[]anArray)                                                                 // this creates an array, of type GraphBar, of graph bars
  {
    for (int i = 0; i < theBars.length; i++)
    {
      theBars[i] = new GraphBar(anArray[i], xRatio, (theBars.length > 15 ? (i * 10) : (i * 20)), (float) (LEFT_GRAPH_X_ORIGIN + (i * xRatio)), (float) GRAPH_Y_ORIGIN, theList, i);
      //theBars[i] = new GraphBar(anArray[i], xRatio, (theBars.length > 15 ? (i * 10) : (i * 20)), (float) (LEFT_GRAPH_X_ORIGIN + (i * xRatio)), (float) GRAPH_Y_ORIGIN, theList, i);
    }
  }

  double maxCases()                                                                                                     // this returns the max amount of cases in an array
  {
    double max = 0;

    for (int i = 0; i < graphBarList.length; i++)
    {
      double current = graphBarList[i].getCurrentCases();

      if (current > max)
      {
        max = current;
      }
    }

    return max;
  }

  void checkBarPress() {
    for (int i = 0; i < graphBarList.length; i++) 
    {
      graphBarList[i].barMousePressed();
    }
  }

  void yAxisIntervals(int maxH)                                                  // this creates y axis labels based on the amount of cases to be presented
  {                                                                              // it bases the labels based off the max cases. (eg if the max cases is 700,000 
    int i = maxH;                                                                // it will label the graph in intervals of 100,000
    int interval = 1;                                                            // for 7,000 the interval will be 1,000 etc.
    int tenCount = 0;

    while (i >= 10)
    {
      i /= 10;
      tenCount++;
    }

    while (tenCount > 0)
    {
      interval *= 10;
      tenCount--;
    }

    fill(0);

    for (int j = 0; j < maxHeight; j += interval)                                                                 // this loop labels the y-axis in intervals of x cases
    {                                                                                                                 
      text(j, (float) (j == 0 ? LEFT_GRAPH_X_ORIGIN - 10 : LEFT_GRAPH_X_ORIGIN - GRAPH_Y_TEXT_MARGIN - (interval > 1000000 ? 15 : 0)), 
        (float) (GRAPH_Y_ORIGIN - (j * (GRAPH_Y / maxHeight))) + DIVIDER_LINE);

      line((float) LEFT_GRAPH_X_ORIGIN, (float) (GRAPH_Y_ORIGIN - (j * (GRAPH_Y / maxHeight))), // it also puts a little horizontal divider at those intervals
        (float) LEFT_GRAPH_X_ORIGIN + DIVIDER_LINE, (float) (GRAPH_Y_ORIGIN - (j * (GRAPH_Y / maxHeight))));
    }
  }

  void backButton(int mX, int mY)                                  // this is a back button which lets the user return to the previous screen, copy and paste to main
  {
    String displayedString = "";

    if (mX >= BACK_BUTTON_X_ORG && mX <= BACK_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y)  
    {
      stroke(255);

      if (backMp)
      {
        if (currentScreen == DAILY_SCREEN || currentScreen == STATE_SCREEN_2)
        {
          graphNeeded = true;
          currentScreen--;
        } 
        
        else 
        {
          currentScreen = HOME_SCREEN;
        }
      }
    } 
    
    else
    {
      stroke(0);
    }

    if (currentScreen == DAILY_SCREEN || currentScreen == STATE_SCREEN_2)
    {
     displayedString = "Back";
    } 
    
    else 
    {
      displayedString = "Home";
    }

    fill(grey);
    rect(BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text(displayedString, BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    //text("Back", BACK_BUTTON_ORG + 5, BACK_BUTTON_ORG + 25);
  }

  void homeButton(int mX, int mY)                    // simple button to take the user back to the home screen
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

  void nextButton(int mX, int mY)          // adds a simple next button, only for use in the states_1 screen
  {
    if (mX >= NEXT_BUTTON_X_ORG && mX <= NEXT_BUTTON_X_ORG + NEXT_BUTTON_X && mY >= NEXT_BUTTON_Y_ORG && mY <= NEXT_BUTTON_Y_ORG + NEXT_BUTTON_Y) 
    {
      stroke(255);

      if (backMp)
      {
        graphNeeded = true;
        currentScreen++;
      }
    } else
    {
      stroke(0);
    }

    fill(grey);
    rect(NEXT_BUTTON_X_ORG, NEXT_BUTTON_Y_ORG, NEXT_BUTTON_X, NEXT_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text("Next", NEXT_BUTTON_X_ORG, NEXT_BUTTON_Y_ORG, NEXT_BUTTON_X, NEXT_BUTTON_Y);
    textAlign(LEFT, BOTTOM);

    if (firstTimeOnStates)
    {
      text("Press next to view the statistics for the other states!", 1100, 100);
      stroke(0);
      line(1550, 70, (float) NEXT_BUTTON_X_ORG - 5, (float) NEXT_BUTTON_Y_ORG + 20);
    }
  }

  void firstMessage(int theScreen)                    // this is a little prompt that will tell you that you can press on a bar and see the another screen. It disappears if you go to that screen 
  {
    if (theScreen == MONTH_SCREEN && firstTimeOnMonths)
    {
      stroke(0);
      fill(80);
      rect(210, 160, 580, 100);
      textFont(microsoftYaHeiUIThirty);
      fill(255, 10, 125);

      text("Click on a bar to see the\ndaily breakdown for that month!", 250, 250);
    }

    if (theScreen == DAILY_SCREEN && firstTimeOnDays)
    {
      stroke(0);
      fill(255);
      rect(810, 720, 520, 100);
      textFont(microsoftYaHeiUIThirty);
      fill(0);

      text("Click on a bar to see which states\nhad the most cases that day!", 840, 810);
    }
  } 

  void graphTitle(int theScreen)                          // this adds a title for the whole graph, depending on the current screen
  {
    fill(yellow);

    textFont(centuryGothicBoldItalicThirtyFive);

    switch(theScreen)
    {
    case MONTH_SCREEN:
      {
        text("Monthly Breakdown of Cases", 725, 60);
        break;
      }

    case DAILY_SCREEN:
      {
        text("Daily Breakdown of Cases for the Month of " + allMonths[monthNeeded], 570, 60);
        break;
      }

    case STATE_SCREEN_1:

    case STATE_SCREEN_2:
      {
        text("Breakdown of the Cases per State", 700, 60);
        break;
      }
    }
  }

  String xTitle(int theScreen)            // this adds the appropriate title to the x-axis
  {
    String theTitle = "";

    switch(theScreen)                                  
    {
    case MONTH_SCREEN:
      {
        theTitle = "Months";
        break;
      }

    case DAILY_SCREEN:
      {
        theTitle = "Days";
        break;
      }

    case STATE_SCREEN_1:
    case STATE_SCREEN_2:
      {
        theTitle = "States";
        break;
      }
    }

    return theTitle;
  }
}
