class PieChart {

  //Anastasiya
  float diameter;
  float lastAngle = 0;
  float sumOfData = 0;
  float mouseAngle;

  int[] data;
  float[] angles;
  float gray;
  String[] labels;
  String[] labelNames;
  color minColor, maxColor;
  float shadeOfGreen, shadeOfRed, shadeOfBlue;

  ArrayList<covidDataRow> dataList;
  String[] statesArray;
  String date;
  String percent;
  ArrayList topTenIntList;
  int[] topTenInt;
  int[] topTenSorted;
  String[] percentageSlices;
  String[] labelsForAreas;
  String nameOfState;
  HashMap<String, Integer> areaCases;

  //piechart Constructor
  PieChart(float diameter, int[] data, String[] labelNames, String nameOfState, HashMap<String, Integer> areaCases) {
    this.diameter = diameter;
    this.data = data;
    this.labelNames = labelNames;
    this.nameOfState = nameOfState;
    this.areaCases = areaCases;
    this.topTenStates();
    this.areaLabels();
    minColor = color(222, 235, 247);
    maxColor = color(49, 130, 189);
    firstTimeOnHeatMap = false;
  }

  void draw() {
    background(blue);
    textFont(ArialBoldItalicMtTwenty);
    createPieChart();
  }

  // AB: array of the most affected admin areas
  void areaLabels() {
    labelsForAreas = new String[topTenSorted.length];
    for (int i = 0; i < topTenSorted.length; i++) {
      if (areaCases.containsValue(topTenSorted[i])) {
        labelsForAreas[i] = getAreaName(topTenSorted[i]);
      }
    }
  }

  // AB: checks if the entry is valid and returns the admin area name
  String getAreaName(int valueToCheck) {
    for (Map.Entry<String, Integer> entry : areaCases.entrySet()) {
      if (entry.getValue() != null) {
        if (entry.getValue() == valueToCheck) {
          return entry.getKey();
        }
      }
    }
    return "null";
  }

  // AB: creates the pie chart that gets called in the draw
  void createPieChart() {
    for (int i = 0; i < topTenSorted.length; i++) {
      sumOfData += topTenSorted[i];
    }

    // convert data to angles
    angles = new float[topTenSorted.length];
    for (int i = 0; i < topTenSorted.length; i++) {
      angles[i] = ((topTenSorted[i] / sumOfData) * 360);
    }

    percentageSlices();

    //draw the piechart
    shadeOfRed = 255;
    shadeOfGreen = 0;
    shadeOfBlue = 0;

    // the color scheme for the piechart which goes from red to yellow to green
    for (int i = 0; i < angles.length; i++) {
      shadeOfGreen = i * (255/topTenSorted.length * 2);
      shadeOfRed = 255;
      shadeOfBlue = 0;
      if (shadeOfGreen >= 255) {
        shadeOfRed = (255 - (i - topTenSorted.length/2) * (255/topTenSorted.length * 2));
      }
      // colors
      fill(shadeOfRed, shadeOfGreen, shadeOfBlue);
      // pie chart slices
      arc(250, 575, diameter, diameter, lastAngle, lastAngle + radians(angles[i]));
      lastAngle += radians(angles[i]);

      // key for the pie chart
      rect(460, 425 + 30 * i, 30, 30);
      fill(0);
      textAlign(LEFT, CENTER);
      text(labelsForAreas[i], 560, 425 + 30 * i, 200, 30);
      text(percentageSlices[i] + "%", 500, 425 + 30 * i, 80, 30);
    }
    fill(0);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("Top " + topTenSorted.length + " areas of " + nameOfState, 255, 350);
    textAlign(LEFT, BOTTOM);
  }

  void topTenStates()                      // this goes through each state and figures out the states with the top 3 highest cases on that day
  {
    if (data.length > 10)
    {
      topTenInt = new int[data.length];
      topTenInt = sort(data);
      topTenSorted = new int[10];
      for (int j = 0; j < 10; j++)
      {
        topTenSorted[j] = topTenInt[topTenInt.length - j - 1];
      }
    } else {
      topTenSorted = data;
    }
  }

  // AB: gets the percentages of all the area cases with regards to the state
  void percentageSlices() {
    percentageSlices = new String[topTenSorted.length];
    for (int i = 0; i < topTenSorted.length; i++) {
      float percentage = topTenSorted[i]/sumOfData * 100;
      if (percentage < 2 && percentage > 1) { // if 1.something print to 1 decimal place
        percent = nf(percentage, 0, 1);
      } else if (percentage < 1) {           // if less than 1 print to 2 decimal place
        percent = nf(percentage, 0, 2);
      } else {                               // if greater than 2 we print the whole number
        percent = str(round(percentage));
      }
      percentageSlices[i] = percent;
    }
  }
}
