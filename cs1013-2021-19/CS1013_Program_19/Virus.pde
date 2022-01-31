class Virus {                                    // covid virus image bouncing around quiz screen
  int xPosition;
  int yPosition;
  float xDirection;
  float yDirection;
  
  Virus (int x,int y, int xDir, int yDir) {
    xPosition = x;
    yPosition = y;
    xDirection = xDir;
    yDirection = yDir;
  }
  
  void draw() 
  {
    image(virusImage, xPosition, yPosition);
  }
  
 void move()                    //moves virus image
  {
    if (xPosition >= 0 && xPosition <= SCREEN_X && yPosition >= 0 && yPosition <= SCREEN_Y) 
    {
     if (yDirection == 1)
     {
       yPosition++;
       yPosition++;
       if (xDirection == 1)
       {
         xPosition++;
         xPosition++;
       }
       else if (xDirection == -1)
       {
         xPosition--;
         xPosition--;
       }
     }
     else if (yDirection == -1)
     {
       yPosition--;
       yPosition--;
       if (xDirection == 1)
       {
         xPosition++;
         xPosition++;
       }
       else if (xDirection == -1)
       {
         xPosition--;
         xPosition--;
       }
     }
    }
    if (xPosition <= 1 || xPosition + VIRUS_LENGTH >= SCREEN_X)
    {
        xDirection = -xDirection;
    }
    else if (yPosition <= 1 || yPosition + VIRUS_HEIGHT >= SCREEN_Y)
    {
        yDirection = -yDirection;
    }
  }
}
