class MSButton extends Button{
  private int lenX, lenY, xPos, yPos;
  private double xOffset, yOffset;
  private boolean isBomb, inArray;
  private ButtonState state;
  public MSButton(int xPosp, int yPosp, int lenXp, int lenYp, double trp, double xOffsetp, double yOffsetp, String bTextp){
    super(width * xPosp / lenXp, height * yPosp / lenYp, width / lenXp, height / lenYp, trp, bTextp, false);
    xPos = xPosp;
    yPos = yPosp;
    lenX = lenXp;
    lenY = lenYp;
    xOffset = xOffsetp;
    yOffset = yOffsetp;
    isBomb = false;
    state = ButtonState.OFF;
    inArray = true;
  }
  public boolean click(boolean mPos){
    //returns new state
    if(!mPos || mousePos()){
      if(state == ButtonState.OFF){
        state = ButtonState.ON;
        return true;
      }
    }
    return false;
  }
  public ButtonState flag(){
    if(mousePos()){
      if(state == ButtonState.FLAGGED){
        state = ButtonState.OFF;
      }
      else if(state == ButtonState.OFF){
        state = ButtonState.FLAGGED;
      }
      return state;
    }
    return null;
  }
  public void show(){
    textAlign(CENTER);
    textSize(TEXT_SIZE * (float)tr);
    if(state == ButtonState.ON){
      if(isBomb)
        fill(255, 0, 0);
      else
        fill(65);
    }
    else if(state == ButtonState.FLAGGED){
      if(mousePos()){
        fill(0, 0, 155);
      }
      else{
        fill(0, 0, 255);
      }
    }
    else{
      if(mousePos()){
        fill(75);
      }
      else{
        fill(100);
      }
    }
    if(inArray){
      x = (int)((width) * xPos / lenX * xOffset);
      y = (int)((height) * yPos / lenY * yOffset);
      sX = (int)((width) / lenX * xOffset);
      sY = (int)((height) / lenY * yOffset);
    }
    rect(x, y, sX, sY);
    fill(0);
    text(bText, x + sX/2, y + sY/(1.5));
  }
  public ButtonState getState(){
    return state;
  }
  public void setBomb(boolean b){
    isBomb = b;
  }
  public boolean getBomb(){
    return isBomb;
  }
}
