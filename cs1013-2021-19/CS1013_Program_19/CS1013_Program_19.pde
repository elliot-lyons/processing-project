import java.net.URL;
import java.io.InputStreamReader;
import java.io.FileOutputStream;
import java.io.BufferedInputStream;
import org.gicentre.geomap.*;
import java.util.Map;

Table covidData;
TableRow covidRow;
Table currentData;
TableRow currentDataRow;

GeoMap geoMap;

PImage blankUSMap;
PImage whiteHouse;
PImage africaVac;
PImage template;
PImage libertyStatue;
PImage covid19HSE;
PImage mapOfStates;
PImage virusImage;

PFont ArialMtTwelve;
PFont ArialMtEight;
PFont ArialMtTen;
PFont ArialBoldItalicMtTwenty;
PFont ArialBoldItalicMtSixteen;
PFont ArialBoldItalicMtEight;
PFont ArialMtTwenty;
PFont ArialMtSixteen;
PFont numbersTextForty;
PFont centuryGothicBoldItalicThirtyFive;
PFont microsoftYaHeiUIThirty;
PFont ArialBoldMT35;

color yellow, lightYellow, grey, blue;

ArrayList totalList;
covidDataRow dataRow;
String[] allMonths;

String inFile;
String currentFile;
public static int currentScreen;

public static boolean graphNeeded;
public static int monthNeeded;
private static boolean breakdownNeeded;
private static String breakdownDate;
private static boolean breakdownUsed;

private static int dateCases;
private static String overallCurrentCases;
private static int overallCurrentDeaths;

private static boolean firstTimeOnStates;
private static boolean firstTimeOnMonths;
private static boolean firstTimeOnDays;
private static int monthScreenNeeded;
private static boolean firstTimeOnHeatMap;

DateGraph aDateGraph;
homeScreen theHomeScreen;
charityScreen theCharity;
HeatMap theHeatMap;
AboutUs theAboutUs;
Quiz theQuiz;
ArrayList widgetList;
ArrayList theDays;                                                  
ArrayList theStates;
String[] theDaysArray;
String[] theStatesArray;
String[] firstHalfOfStates;
String[] secondHalfOfStates;
DateBreakdown aDateBreakdown;
String path;

void settings()
{
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  inFile = "daily-1M.csv";
  //reading in a file from the internet that is updated regularly throughout the day 
  //it creates a new CSV file called livecases in the data tab of the program, and overwrites the old versions
  path = sketchPath();                               //obtains the file path of the sketch (needed to create a livecases.csv file on any system that runs our program)                   
  println(path);
  try
  {
    BufferedInputStream inputStream = new BufferedInputStream(new URL("https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv").openStream());
    FileOutputStream fileOutput = new FileOutputStream(path + "\\data\\livecases.csv");                                  //sketchpath() only returns the path to the sketch not to the data folder so \\data\\livecases.csv is added to specify location we want the file to be created in
    byte byteArray[] = new byte[1024];
    int byteContent;
    while ((byteContent = inputStream.read(byteArray, 0, 1024)) != -1) 
    {
      fileOutput.write(byteArray, 0, byteContent);
    }
  }
  catch (IOException e) 
  {
  }
  currentFile = "livecases.csv";                               // this is an excel file created above that records the total cases and total deaths in USA. 
  covidData = loadTable(inFile, "header");                     //It imports the data from a github file that was made public by the new york times
  currentData = loadTable(currentFile, "header");              //https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv
  totalList = new ArrayList();

  for (int i = 0; i < covidData.getRowCount(); i++)              // this creates an array list filled with covidDataRow objects
  {                                                              // each covidDataRow represents a row from the CSV file and has its own date, state, cases etc.
    covidRow = covidData.getRow(i);
    dataRow = new covidDataRow(covidRow);
    totalList.add(dataRow);
  }

  currentDataRow = currentData.getRow(0);
  overallCurrentCases = currentDataRow.getString(1);              // live feed of total amount of cases
  overallCurrentDeaths = currentDataRow.getInt(2);                         // live feed of today's new cases

  geoMap = new GeoMap(-100, 0, SCREEN_X - 30, SCREEN_Y - 30, this);  // Create the geoMap object.
  geoMap.readFile("States_shapefile");                               // Reads shapefile.

  ArialMtTwelve = loadFont("ArialMT-12.vlw");
  textFont(ArialMtTwelve);
  ArialMtEight =loadFont("ArialMT-8.vlw");
  ArialMtTen = loadFont("ArialMT-10.vlw");
  ArialBoldItalicMtTwenty = loadFont("Arial-BoldItalicMT-20.vlw");
  ArialBoldItalicMtSixteen = loadFont("Arial-BoldItalicMT-16.vlw");
  ArialBoldItalicMtEight = loadFont("Arial-BoldItalicMT-8.vlw");
  ArialMtTwenty = loadFont("ArialMT-20.vlw");
  ArialMtSixteen = loadFont("ArialMT-16.vlw");
  numbersTextForty = loadFont("Skia-Regular_Black-Extended-40.vlw");
  centuryGothicBoldItalicThirtyFive = loadFont("CenturyGothic-BoldItalic-35.vlw");
  microsoftYaHeiUIThirty = loadFont("MicrosoftYaHeiUI-30.vlw");
  ArialBoldMT35 = loadFont("Arial-BoldMT-35.vlw");

  whiteHouse = loadImage("whitehouse.jpg");
  africaVac = loadImage("AfricaVaccine.jpg");
  template = loadImage("aboutusWallpaper.jpg");
  libertyStatue = loadImage("LibertyStatue.jpg");         // image loading
  libertyStatue.resize(1800, 900);      //Background
  covid19HSE = loadImage("CovidHSE.jpg");
  // blankUSMap = loadImage("MutlicolouredUSMap.png");
  // mapOfStates = loadImage("USHEATMAP.jpeg");
  virusImage = loadImage("virus.png");

  yellow = color(255, 255, 0);
  lightYellow = color(255, 255, 153);
  grey = color(211);
  blue = color(176, 196, 222);

  currentScreen = HOME_SCREEN;                  
  graphNeeded = false;
  breakdownNeeded = false;                     
  breakdownDate = "";
  breakdownUsed = false;
  dateCases = 0;
  firstTimeOnStates = true;
  firstTimeOnMonths = true;
  firstTimeOnDays = true;
  firstTimeOnHeatMap = true;
  monthScreenNeeded = 0;

  allMonths = new String[TOTAL_MONTHS];
  fillMonths(allMonths);

  theStates = new ArrayList();
  fillStates(totalList, theStates);
  theStatesArray = stringListToArray(theStates);

  theStates = new ArrayList();
  fillStates(totalList, theStates);
  theStatesArray = stringListToArray(theStates);
  firstHalfOfStates = new String[((theStatesArray.length % 2 == 1 ? ((theStatesArray.length + 1) / 2) : (theStatesArray.length / 2)) )];  // this has the first half of the states array
  secondHalfOfStates = new String[((theStatesArray.length % 2 == 1 ? (((theStatesArray.length + 1) / 2) - 1) : (theStatesArray.length / 2)) )];  // this has the second. The length of the arrays is 
  // determined by how long the statesArray is. If there is an even number of states, the first half of the array has the same number of states as the first array. If there is an uneven amount of 
  // states, the first array has one more string than the second to make up for this.
  stringToTwoStrings(theStatesArray, firstHalfOfStates, secondHalfOfStates);

  theHomeScreen = new homeScreen(currentScreen);
  theCharity = new charityScreen(currentScreen);
  theHeatMap = new HeatMap(currentScreen);
  theAboutUs = new AboutUs(currentScreen);
  theQuiz = new Quiz();
}

void draw()
{
  switch(currentScreen) {                                          // this determines what will be drawn onto the screen
  case HOME_SCREEN:
    theHomeScreen.draw();
    break;

  case MONTH_SCREEN:
    if (graphNeeded && monthScreenNeeded == 1)                                                // the booleans in this switch statement create a graph or a breakdown if needed
    {                                                               // ie if a new graph is needed, create a new graph. graphNeeded is only to trigger the constructor
      aDateGraph = new DateGraph(totalList, allMonths);             // This is because it will continue to draw that same graph until the screen is changed and/or a new graph is needed
      graphNeeded = false;
    }
    aDateGraph.draw();
    break;

  case DAILY_SCREEN:
    if (graphNeeded)
    {
      theDays = new ArrayList();
      fillDays(allMonths[monthNeeded], theDays);                          
      theDaysArray = stringListToArray(theDays);
      aDateGraph = new DateGraph(totalList, theDaysArray);          // this just constructs a daily graph based on the month the user selects
      graphNeeded = false;
    }

    firstTimeOnMonths = false;
    aDateGraph.draw();
    break;

  case STATE_SCREEN_1:
    if (graphNeeded)
    {
      aDateGraph = new DateGraph(totalList, firstHalfOfStates);
      graphNeeded = false;
    }
    aDateGraph.draw();
    break;

  case STATE_SCREEN_2:
    if (graphNeeded)
    {
      aDateGraph = new DateGraph(totalList, secondHalfOfStates);
      graphNeeded = false;
    }

    firstTimeOnStates = false;
    aDateGraph.draw();
    break;

  case DATE_BREAKDOWN_SCREEN:
    {
      if (breakdownNeeded)
      {
        aDateBreakdown = new DateBreakdown(totalList, breakdownDate, theStates);         // this constructs a breakdown of a date that a user selects from the daily graph           
        breakdownNeeded = false;
        breakdownUsed = true;
      }
      firstTimeOnDays = false;
      aDateBreakdown.draw();
      break;
    }

  case CHARITY_SCREEN:
    {
      theCharity.draw();
      break;
    }

  case HEATMAP_SCREEN:
    {
      theHeatMap.draw();
      break;
    }

  case ABOUTUS_SCREEN:
    {
      theAboutUs.draw();
      break;
    }

  case QUIZ_SCREEN_1:
    {
    }
  case QUIZ_SCREEN_2:
  case QUIZ_SCREEN_3:
  case QUIZ_SCREEN_4:
  case QUIZ_SCREEN_5:
  case QUIZ_SCREEN_6:
  case QUIZ_SCREEN_7:
  case QUIZ_SCREEN_8:
  case QUIZ_RESULTS_SCREEN:
    {
      theQuiz.draw();
      break;
    }
  }
}

void mousePressed() {                              // this determines what happens when the mouse is pressed based on the screen
  switch(currentScreen) {

  case HOME_SCREEN:
    theHomeScreen.whenMousePressed();
    break;

  case MONTH_SCREEN:
    //aDateGraph.checkBarPress();
    //aDateGraph.backMp = true;
    //break;

  case DAILY_SCREEN:
    aDateGraph.checkBarPress();
    aDateGraph.backMp = true;
    break;

  case STATE_SCREEN_1:

  case STATE_SCREEN_2: 
    aDateGraph.backMp = true;
    break;

  case DATE_BREAKDOWN_SCREEN:
    aDateBreakdown.backMp = true;
    break;

  case CHARITY_SCREEN:
    theCharity.whenMousePressed();
    break;

  case HEATMAP_SCREEN:
    theHeatMap.backMp = true;
    break;

  case ABOUTUS_SCREEN:
    theAboutUs.backMp = true;
    break;

  case QUIZ_SCREEN_1:
  case QUIZ_SCREEN_2:
  case QUIZ_SCREEN_3:
  case QUIZ_SCREEN_4:
  case QUIZ_SCREEN_5:
  case QUIZ_SCREEN_6:
  case QUIZ_SCREEN_7:
  case QUIZ_SCREEN_8:
  case QUIZ_RESULTS_SCREEN:
    {
      theQuiz.backMp = true;
    }
  }
}
void mouseMoved() {                                                                          //mouseMoved is used when changing Widget outline
  if (currentScreen == HOME_SCREEN)
  {
    theHomeScreen.whenMouseMoved(mouseX, mouseY);
  } else if (currentScreen == CHARITY_SCREEN)
  {
    theCharity.whenMouseMoved(mouseX, mouseY);
  }
}

void fillMonths(String[] months)
{
  int yearsRequired = months.length / 12;

  if (months.length % 12 > 0)
  {
    yearsRequired++;                                                                                                  // this adds another year on if there are extra months
  }

  int currentYear = START_YEAR;
  yearsRequired += currentYear;
  int i = 0;

  while (currentYear < yearsRequired)                                                                                
  {
    for (int currentMonth = 1; currentMonth <= 12 && i < months.length; currentMonth++)
    {
      String selectedMonth = "" + (currentMonth < 10 ? "0" + currentMonth: + currentMonth) + "/" + currentYear;
      months[i] = selectedMonth;                                                                                      // this stores the month in the allMonth String in the format
      i++;                                                                                                            // MM/YY
    }
    currentYear++;                                                                                                    // the for loop concludes when all the months have been done for one year
  }                                                                                                                   // the while loop concludes when all the years have been covered
}

void fillDays(String month, ArrayList<String> myList)                                                                 // creates an ArrayList for a specific month
{
  String currentDay = "";
  int dayLimit = 0;

  switch (month)
  {
  case "02/21":
    dayLimit = 28;
    break;

  case "02/20":
    dayLimit = 29;
    break;

  case "04/20":
  case "06/20":
  case "09/20":
  case "11/20":
    dayLimit = 30;
    break;

  default:
    dayLimit = 31;
    break;
  }

  for (int i = 1; i < dayLimit; i++)
  {
    currentDay = (i < 10 ? "0" + i : "" + i) + "/" + month;
    myList.add(currentDay);
  }
}

void fillStates(ArrayList<covidDataRow> theList, ArrayList<String> myList)              // this puts the states into an array list
{
  String currentState = "";
  covidDataRow currentRow; 
  boolean needsAdding = true;

  for (int i = 0; i < theList.size(); i++)
  {
    currentRow = theList.get(i);
    currentState = currentRow.state;

    for (int j = 0; j < myList.size(); j++)
    {
      if (currentState.equals(myList.get(j)))
      {
        needsAdding = false;
      }
    }
    if (needsAdding)
    {
      myList.add(currentState);
    }
    needsAdding = true;
  }
}

String[] stringListToArray(ArrayList<String> myList)                            // turns an ArrayList of Strings into a String array
{
  String[] theArray = new String[myList.size()];
  for (int i = 0; i < myList.size(); i++)
  {
    theArray[i] = myList.get(i);
  }
  return theArray;
}

void stringToTwoStrings(String[] originalString, String[] firstString, String[] secondString)          // this takes one array and fills half of it contents into one array and the other half into 
{                                                                                                      // another array. All strisngs passed must have their lengths pre-determined
  int i = 0;

  while (i < firstString.length)
  {
    firstString[i] = originalString[i];
    i++;
  }

  for (int j = 0; j < secondString.length; j++)
  {
    secondString[j] = originalString[i];
    i++;
  }
}
