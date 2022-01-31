class HeatMap {

  int screen;
  ArrayList widgetList;
  private boolean backMp;
  private String state;
  color minColour, maxColour;       // heatmap colour palette
  float dataMax;
  String State_Name;
  String state_Name;
  int noOfCases;
  int addNewCases;

  HashMap<String, Integer> stateCases;
  HashMap<String, Integer> areaCases;

  PieChart aPieChart;

  String stateName;
  int stateId;

  String nameOfState;
  String[] Areas;
  int[] CasesInAreas;
  String[] StateAreaNames;

  int numberOfCases;
  int addMoreCases;
  String areas;

  int i = 0;

  int[] Cases;
  String[] States;
  int CasesNumber;
  String StateNames;

  HeatMap(int screen) {
    this.screen = screen;
    this.casesPerState();
    this.arrayCasesPerState();
    minColour = color(254, 176, 176);
    maxColour = color(178, 14, 14);
    backMp = false;
  }

  void casesPerState() {

    stateCases = new HashMap<String, Integer>(); // cases within a state

    // AB: set up hashmap keys using the state names
    for (TableRow row : covidData.rows()) {
      stateCases.put(row.getString(2).toUpperCase(), 0);
    }

    // AB: enter cases per state into the hashmap
    for (TableRow row : covidData.rows()) {
      state = row.getString(2).toUpperCase();
      if (stateCases.containsKey(state)) {
        noOfCases = stateCases.get(state);
        addNewCases = row.getInt(4);
        noOfCases += addNewCases;
        stateCases.put(state, noOfCases);
      }
    }

    // AB: find the highest number of cases
    for (Map.Entry<String, Integer> me5 : stateCases.entrySet()) {
      dataMax = max(dataMax, me5.getValue());
    }
  }

  // AB: creates hashmap for the areas in a state specified by mouse pressed
  void casesPerArea(String nameOfArea) {
    areaCases = new HashMap<String, Integer>();

    String newNameOfArea = convertToUpperCamelCase(nameOfArea);
    for (TableRow row : covidData.rows()) {
      if (row.getString(2).equals(newNameOfArea)) {  // loop through necessay state
        areaCases.put(row.getString(1), 0);
      }
    }

    //AB: inserts the number of cases per area into hashMap
    for (TableRow row : covidData.rows()) {
      areas = row.getString(1);
      if (areaCases.containsKey(areas)) {
        numberOfCases = areaCases.get(areas);
        addMoreCases = row.getInt(4);
        numberOfCases += addMoreCases;
        areaCases.put(areas, numberOfCases);
      }
    }


    CasesInAreas = new int[areaCases.size()];   
    StateAreaNames = new String[areaCases.size()];

    int index2 = 0;
    for (Map.Entry<String, Integer> me2 : areaCases.entrySet()) {
      int theCasesInAnArea = me2.getValue();
      CasesInAreas[index2] = theCasesInAnArea;
      String StateAreaName = me2.getKey();
      StateAreaNames[index2] = StateAreaName;
      index2++;
    }

    //state area names in a string array for pie chart labels
    String nameOfStateUpr = convertToUpperCamelCase(nameOfState);
    // creating a call for the piechart
    aPieChart = new PieChart((float) 350, CasesInAreas, StateAreaNames, nameOfStateUpr, areaCases);// call piechart
  }

  void draw() {
    background(blue);
    strokeWeight(1.5);

    if (firstTimeOnHeatMap)              // displays a small prompt telling the user they can view the state's breakdown of cases by hovering the mouse over a state.
    {                                    // this message will disappear once the user does hover their mouse over a state
      fill(0, 255, 65);
      stroke(0);
      rect(1150, 80, 600, 130);
      fill(0);
      textFont(microsoftYaHeiUIThirty);
      text("Hover the mouse over a state to see\nto see the most affected counties\nwithin that state!", 1450, 140);
    }

    backMp = false;
    backButton(mouseX, mouseY);
    backMp = false;

    // mousePressed();
    makePieChart(mouseX, mouseY);

    stroke(0);
    fill(0);
    textSize(50);
    textFont(microsoftYaHeiUIThirty); 

    //AB: draw the map
    for (int id : geoMap.getFeatures().keySet()) {
      state_Name = geoMap.getAttributeTable().findRow(str(id), 0).getString("State_Name");
      if (stateCases.containsKey(state_Name)) {
        int caseAtState = stateCases.get(state_Name);
        float normStateName = caseAtState/dataMax;
        fill (lerpColor(minColour, maxColour, normStateName));
      } else {
        fill (255);
      }
      geoMap.draw(id);
    }
    fill(21, 60, 220);          // Land colour

    // Find the country at mouse position and draw in different colour.
    stateId = geoMap.getID(mouseX, mouseY);
    if (stateId != -1)
    {
      fill(45, 237, 251);      // Highlighted land colour.
      geoMap.draw(stateId);
      stateName = geoMap.getAttributeTable().findRow(str(stateId), 0).getString("State_Name");    
      fill(0);
      String theStatesName = convertToUpperCamelCase(stateName);
      textSize(20);
      text(theStatesName + ": ", mouseX, mouseY - 20);
      text(stateCases.get(stateName)+" cases", mouseX, mouseY);
    }

    int x = 850;
    int y = 300;
    // color transition block labels
    fill(0);
    textSize(16);
    text("0", x - 2, y - 25);
    text(str(round(dataMax)), 1340, y - 25);
    text(str(round(dataMax/2)), 1095, y - 25);
    textFont(microsoftYaHeiUIThirty);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Heat Map of the US States", width/2, 50);       // title
    line(852, 300, 852, 280);
    line(1125, 300, 1125, 280);
    line(1373, 300, 1373, 280);

    textSize(20);

    // the key that transitions the colors
    for (int i = 0; i < 35; i++) {
      noStroke();
      noFill();
      fill(lerpColor(minColour, maxColour, (float) i / 34));
      rect(x +  i * 15, y, 15, 15); 
      //  fill(0);
      textAlign(CENTER, CENTER);
      //  text((i + 1) * 10 + "%", x + i * 50, y + 55, 60, 50);
    }
  }

  void makePieChart(int mouseXPos, int mouseYPos) {
    int stateID = geoMap.getID(mouseXPos, mouseYPos);
    if (stateID != -1 && stateId > 0) {
      nameOfState = geoMap.getAttributeTable().findRow(str(stateId), 0).getString("State_Name");
      if (nameOfState != "null") {
        casesPerArea(nameOfState);             // call the hashmap to make one for that state with those cases and areas
        aPieChart.draw();
      }
    }
  }

  void backButton(int mX, int mY)                                                    // this is a back button which lets the user return to the previous screen
  {
    if (mX >= BACK_BUTTON_X_ORG && mX <= BACK_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG - 5 && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y - 5)
    {
      stroke(255);

      if (mousePressed)
      {  
        currentScreen = HOME_SCREEN;
        backMp = false;
      }
    } else
    {
      stroke(0);
    }

    fill(grey);
    rect(BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG - 5, BACK_BUTTON_X, BACK_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text("Home", BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG - 5, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    stroke(0);
  }

  // CASES in a praticular state as specified by the mouse
  void arrayCasesPerState() {
    Cases = new int[stateCases.size()];       //cases per state
    States = new String[stateCases.size()];   //states
    int i = 0;

    for (Map.Entry<String, Integer> me : stateCases.entrySet()) {
      CasesNumber = me.getValue();
      Cases[i] = CasesNumber;
      StateNames = me.getKey();
      States[i] = StateNames;
      i++;
    }

    //convert int[] cases per state into float[] to be used for pie chart
    float[] floatCases = new float[stateCases.size()];
    int index = 0;
    for (final Integer value : Cases) {
      floatCases[index] = value;
      index++;
    }
  }

  // AB: converts strings to upper camel case for the users to read it easier and friendlier
  String convertToUpperCamelCase(String stringToBeConverted) {
    if (stringToBeConverted == null || stringToBeConverted.isEmpty()) {
      return stringToBeConverted;
    }
    StringBuilder converted = new StringBuilder();
    boolean convertToUpper = true;
    for (char ch : stringToBeConverted.toCharArray()) {
      if (Character.isSpaceChar(ch)) {
        convertToUpper = true;
      } else if (convertToUpper) {
        ch = Character.toTitleCase(ch);
        convertToUpper = false;
      } else {
        ch = Character.toLowerCase(ch);
      }
      converted.append(ch);
    }
    return converted.toString();
  }
}
