class GraphBar
{
  private double xRatio;                                                                // this class creates a graph bar. It takes in:
  //the name of the data it's representing (data -> dataRepresented)
  private String dataRepresented;                                                       // its width (xRat -> xRatio)
  private int colorNo;                                                                  // its color (colorVar -> colorNo)
  private color strokeColor;
  // the x co-ordinate of the bottom of the bar (xOrg -> xOrigin) 
  private float xOrigin;                                                                // the y co-ordinate of the axis it's on (yLim -> yLimit)
  private float yLimit;                                                                 // and the covidDataRow list (aList -> theList)
  private int currentCases;
  private boolean onBar;
  private int currentPos;

  ArrayList<covidDataRow> theList;

  GraphBar(String data, double xRat, int colorVar, float xOrg, float yLim, ArrayList<covidDataRow> aList, int arrayPos)
  {
    dataRepresented = data;
    xRatio = xRat;
    colorNo = colorVar;
    xOrigin = xOrg;
    yLimit = yLim;
    theList = aList;
    strokeColor = color(0);
    onBar = false;
    currentPos = arrayPos;

    currentCases = getCurrentCases();
  }

  int getCurrentCases()                                                                // this returns the value of the cases for the data in question
  {
    int cases = 0;
    covidDataRow currentRow;

    for (int j = 0; j < theList.size(); j++)
    {
      currentRow = (covidDataRow) totalList.get(j);

      if (currentScreen == MONTH_SCREEN || currentScreen == DAILY_SCREEN)
      {
        if (currentRow.date.contains(dataRepresented))
        {
          cases += currentRow.cases;
        }
      } else
      {
        if (currentRow.state.equals(dataRepresented))
        {
          cases += currentRow.cases;
        }
      }
    }

    return cases;
  }

  void mouseMoved(double barHght) 
  {
    if (mouseX < xOrigin + xRatio  && mouseX > xOrigin && mouseY < yLimit && mouseY > yLimit - barHght)
    {
      strokeWeight(1);
      strokeColor = color(255);
      onBar = true;
    } else
    {
      strokeWeight(1);
      strokeColor = color(0);
      onBar = false;
    }
  }

  void barMousePressed() {
    if (currentScreen == MONTH_SCREEN && onBar)
    {
      currentScreen = DAILY_SCREEN;
      graphNeeded = true;
      monthNeeded = currentPos;
      dateCases = currentCases;
      onBar = false;
    } else if (currentScreen == DAILY_SCREEN && onBar)                    
    {
      currentScreen = DATE_BREAKDOWN_SCREEN;
      breakdownNeeded = true;
      breakdownDate = dataRepresented;
      dateCases = currentCases;
      onBar = false;
    }
  }
}
