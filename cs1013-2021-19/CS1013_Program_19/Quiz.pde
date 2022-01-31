class Quiz
{
  private boolean backMp;
  private boolean[] theAnswers;
  
  Virus theVirus1[];
  Virus theVirus2[];

  Quiz()
  {
    theVirus1 = new Virus[5];
    theVirus2 = new Virus[5];
    initialiseArray1(theVirus1);
    initialiseArray2(theVirus2);
    backMp = false;
    theAnswers = new boolean[7];        // this array records responses. You are unable to undo responses. E.g. if you answer 'yes' to q1 and then realise you wanted to answer 'no'. You can 
  }                                     // return to q1 using the back button on q2. (if you are on another question, you can press back until you are on q1 again), and then answer 'no'. Your
                                        // 'no' response will over write your original response
  void draw()
  {
    background(247, 255, 0);
    image(covid19HSE, 375, 10);
    drawArray(theVirus1);
    drawArray(theVirus2);
    moveArray(theVirus1);
    moveArray(theVirus2);
    displayScreen(currentScreen);
    
    if (currentScreen != QUIZ_SCREEN_1 && currentScreen != QUIZ_RESULTS_SCREEN)
    {
      yesButton(mouseX, mouseY);
      noButton(mouseX, mouseY);
    }
    
    else
    {
      if (currentScreen == QUIZ_SCREEN_1)
      {
        beginButton(mouseX, mouseY);
      }
    }
    
    backButton(mouseX, mouseY);
    backMp = false;
  }

  void displayScreen(int theScreen)
  {
    String currentSymptom = "";

    stroke(0);
    //fill(240, 0, 255);
    fill(blue);
    rect(QUIZ_TEXT_BOX_X_ORIGIN, QUIZ_TEXT_BOX_Y_ORIGIN, QUIZ_TEXT_BOX_X, QUIZ_TEXT_BOX_Y);
    textFont(ArialBoldItalicMtTwenty);
    fill(255);

    switch (theScreen)              // this switch statement determines what to put on the screen. If you are on the begin / results screen, you will see the text detailed in this statement pop up on
    {                               // your screen. If you are on a question screen (QUIZ_SCREEN_2 - QUIZ_SCREEN_8), this switch statement just sets the currentSymptom to be a common COVID-19 symptom.
      case (QUIZ_SCREEN_1):         // This is then used to output a generic question asking you if you have had that symptom. The symptom asked changes, depending on the screen 
      {
        text("Welcome to the COVID-19 Symptom quiz.\nClick 'Begin' to start.", QUIZ_TEXT_BOX_X_ORIGIN + QUIZ_TEXT_MARGIN, QUIZ_TEXT_BOX_Y_ORIGIN + QUIZ_TEXT_MARGIN + 40);
        break;
      }

      case (QUIZ_SCREEN_2):
      {
        currentSymptom = "a fever";
        break;
      }

      case (QUIZ_SCREEN_3):
      {
        currentSymptom = "a dry cough";
        break;
      }

      case (QUIZ_SCREEN_4):
      {
        currentSymptom = "tiredness";
        break;
      }

      case (QUIZ_SCREEN_5):
      {
        currentSymptom = "a sore throat";
        break;
      }

      case (QUIZ_SCREEN_6):
      {
        currentSymptom = "headaches";
        break;
      }

      case (QUIZ_SCREEN_7):
      {
        currentSymptom = "a loss of taste or smell";
        break;
      }

      case (QUIZ_SCREEN_8):
      {
        currentSymptom = "difficulty breathing or a shortness of breath";
        break;
      }

      case (QUIZ_RESULTS_SCREEN):
      {
        if (checkAnswers(theAnswers))      // this checks the answers you submitted to the test. If you said you had any symptom the following message is shown
        {
          text("You have shown common sympotoms of COVID-19.\nWe recommend you self-isolate and contact your GP, if necessary.", QUIZ_TEXT_BOX_X_ORIGIN + QUIZ_TEXT_MARGIN, 
            QUIZ_TEXT_BOX_Y_ORIGIN + 40 + QUIZ_TEXT_MARGIN);
        }
        
        else        // if you haven't had any symptoms the following message shows
        {
          text("You haven't shown common sympotoms of COVID-19 in the last few days.\nHowever, you may be asymptomatic.\nWe still recommend you continue to stay safe and follow government guidelines.",
            QUIZ_TEXT_BOX_X_ORIGIN + QUIZ_TEXT_MARGIN - 30, QUIZ_TEXT_BOX_Y_ORIGIN + QUIZ_TEXT_MARGIN + 50);
        }
        break;
      }
    }
    
    if (currentScreen != QUIZ_SCREEN_1 && currentScreen != QUIZ_RESULTS_SCREEN)        // this asks whether you have experienced a certain symptom
    {
      text("Have you experienced " + currentSymptom + " \nin the last few days?", QUIZ_TEXT_BOX_X_ORIGIN + QUIZ_TEXT_MARGIN, QUIZ_TEXT_BOX_Y_ORIGIN + QUIZ_TEXT_MARGIN + 30);
    }
  }
  
  void yesButton(int mX, int mY)            // this desplays the 'Yes' response button below a question
  {
    if (mX >= YES_BUTTON_X_ORIGIN && mX <= YES_BUTTON_X_ORIGIN + ANSWER_BUTTON_X && mY >= ANSWER_BUTTON_Y_ORIGIN && mY <= ANSWER_BUTTON_Y_ORIGIN + ANSWER_BUTTON_Y)
    {
      stroke(255);
      
      if (backMp == true)
      {
        theAnswers[currentScreen - 11] = true;            // if you click yes to a symptom, your resonse is stored in the array
        currentScreen++;
      }
    }
    
    else
    {
      stroke(0);
    }
    
    fill(0, 255, 0);
    rect(YES_BUTTON_X_ORIGIN, ANSWER_BUTTON_Y_ORIGIN, ANSWER_BUTTON_X, ANSWER_BUTTON_Y);
    fill(0);
    textFont(centuryGothicBoldItalicThirtyFive);
    text("Yes", YES_BUTTON_X_ORIGIN + QUIZ_TEXT_MARGIN + 70, ANSWER_BUTTON_Y_ORIGIN + QUIZ_TEXT_MARGIN);
  }
  
  void noButton(int mX, int mY)                // this desplays the 'No' response button below a question
  {
    if (mX >= NO_BUTTON_X_ORIGIN && mX <= NO_BUTTON_X_ORIGIN + ANSWER_BUTTON_X && mY >= ANSWER_BUTTON_Y_ORIGIN && mY <= ANSWER_BUTTON_Y_ORIGIN + ANSWER_BUTTON_Y)
    {
      stroke(255);
      
      if (backMp == true)
      {
        theAnswers[currentScreen - 11] = false;          // if you click no to a symptom your response is recorded here
        currentScreen++;
      }
    }
    
    else
    {
      stroke(0);
    }
    
    fill(255, 0, 0);
    rect(NO_BUTTON_X_ORIGIN, ANSWER_BUTTON_Y_ORIGIN, ANSWER_BUTTON_X, ANSWER_BUTTON_Y);
    fill(0);
    textFont(centuryGothicBoldItalicThirtyFive);
    text("No", NO_BUTTON_X_ORIGIN + QUIZ_TEXT_MARGIN + 70, ANSWER_BUTTON_Y_ORIGIN + QUIZ_TEXT_MARGIN);
  }
  
  void backButton(int mX, int mY)                                        // this is a back button which lets the user return to the previous question
  {                                                                      // if they are either on the 'begin' screen, the first question or the 'results' screen, the user returns to the home screen
    String buttonText;
    
    if (currentScreen == QUIZ_RESULTS_SCREEN || currentScreen == QUIZ_SCREEN_1 || currentScreen == QUIZ_SCREEN_2)
    {
      buttonText = "Home";
    }
    
    else
    {
      buttonText = "Back";
    }
    
    
    if (mX >= BACK_BUTTON_X_ORG && mX <= BACK_BUTTON_X_ORG + BACK_BUTTON_X && mY >= BACK_BUTTON_Y_ORG && mY <= BACK_BUTTON_Y_ORG + BACK_BUTTON_Y) 
    {
      stroke(255);

      if (backMp)
      {  
        backMp = false;
        
        if (currentScreen == QUIZ_RESULTS_SCREEN || currentScreen == QUIZ_SCREEN_1 || currentScreen == QUIZ_SCREEN_2)
        {
          currentScreen = HOME_SCREEN;
          buttonText = "Home";
        }
        
        else
        {
          currentScreen--;
        }
      }
    } 
    
    else
    {
      stroke(0);
    }

    fill(grey);
    rect(BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);

    fill(0);
    textFont(ArialBoldItalicMtTwenty);
    textAlign(CENTER, CENTER);
    text(buttonText, BACK_BUTTON_X_ORG, BACK_BUTTON_Y_ORG, BACK_BUTTON_X, BACK_BUTTON_Y);
    textAlign(LEFT, BOTTOM);
    stroke(0);
  }
  
  void beginButton(int mX, int mY)        // this is the begin button at the start of the quiz. Clicking it will start the quiz
  {
    if (mX >= BEGIN_BUTTON_X_ORIGIN && mX <= BEGIN_BUTTON_X_ORIGIN + BEGIN_BUTTON_X && mY >= BEGIN_BUTTON_Y_ORIGIN && mY <= BEGIN_BUTTON_Y_ORIGIN + BEGIN_BUTTON_Y)
    {
      stroke(255);
      
      if (backMp)
      {
        backMp = false;
        currentScreen++;
      }
    }
    
    else
    {
      stroke(0);
    }
    
    fill(blue);
    rect(BEGIN_BUTTON_X_ORIGIN, BEGIN_BUTTON_Y_ORIGIN, BEGIN_BUTTON_X, BEGIN_BUTTON_Y);
    
    textFont(centuryGothicBoldItalicThirtyFive);
    fill(lightYellow);
    text("Begin!", BEGIN_BUTTON_X_ORIGIN + 150, BEGIN_BUTTON_Y_ORIGIN + 70);
  }
  
  boolean checkAnswers(boolean[] theArray)          // this cycles through the list of responses submitted. If there is a single 'Yes' response, you will be told you have had common COVID-19 
  {                                                 // symptoms
    for (int i = 0; i < theArray.length; i++)
    {
      if (theArray[i] == true)
      {
        return true;
      }
    }
    
    return false;
  }
  
  void initialiseArray1(Virus myVirus[]) {     // initialises array in a positive direction
  for (int i = 0; i < myVirus.length; i++)
  {
    myVirus[i] = new Virus((int)random(60,SCREEN_X - 60), (int)random(60,SCREEN_Y - 60), 1, 1);
  }
}

void initialiseArray2(Virus myVirus[]) { // initialises array in a negative direction
  for (int i = 0; i < myVirus.length; i++)
  {
    myVirus[i] = new Virus((int)random(60,SCREEN_X - 60), (int)random(60,SCREEN_Y - 60), -1, -1);
  }
}

void drawArray(Virus myVirus[]) {   //draws array
  for (int i = 0; i < myVirus.length; i++)
  {
    myVirus[i].draw();
  }
}

void moveArray(Virus myVirus[]) {  //moves array
  for (int i = 0; i < myVirus.length; i++)
  {
    myVirus[i].move();
  }
}
}
