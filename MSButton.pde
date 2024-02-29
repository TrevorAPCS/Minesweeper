class MSButton extends Button{
  private int lenX, lenY, xPos, yPos;
  private double xOffset, yOffset;
  private boolean isBomb, inArray;
  private ButtonState state;
  public MSButton(int xPos, int yPos, int lenX, int lenY, double tr, double xOffset, double yOffset, String bText){
    super(width * xPos / lenX, height * yPos / lenY, width / lenX, height / lenY, tr, bText, false);
    this.xPos = xPos;
    this.yPos = yPos;
    this.lenX = lenX;
    this.lenY = lenY;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
    isBomb = false;
    state = ButtonState.OFF;
    inArray = true;
  }
  public boolean click(boolean mPos){
    //returns new state
    if(!mPos || mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
      if(state == ButtonState.OFF){
        state = ButtonState.ON;
        return true;
      }
    }
    return false;
  }
  public ButtonState flag(){
    if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
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
      if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
        fill(0, 0, 155);
      }
      else{
        fill(0, 0, 255);
      }
    }
    else{
      if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
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
