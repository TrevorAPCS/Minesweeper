class MSButton extends Button{
  // states : 0 = off, 1 = on, 2 = flagged
  private int lenX, lenY, xPos, yPos, state;
  private double xOffset, yOffset;
  private boolean isBomb, inArray;
  public MSButton(int xPosp, int yPosp, int lenXp, int lenYp, double trp, double xOffsetp, double yOffsetp, String bTextp){
    super(width * xPosp / lenXp, height * yPosp / lenYp, width / lenXp, height / lenYp, trp, bTextp, false);
    xPos = xPosp;
    yPos = yPosp;
    lenX = lenXp;
    lenY = lenYp;
    xOffset = xOffsetp;
    yOffset = yOffsetp;
    isBomb = false;
    state = 0;
    inArray = true;
  }
  public boolean click(boolean mPos){
    //returns new state
    if(!mPos || mousePos()){
      if(state == 0){
        state = 1;
        return true;
      }
    }
    return false;
  }
  public int flag(){
    if(mousePos()){
      if(state == 2){
        state = 0;
      }
      else if(state == 0){
        state = 2;
      }
      return state;
    }
    return -1;
  }
  public void show(){
    textAlign(CENTER);
    textSize(tSize * (float)tr);
    if(state == 1){
      if(isBomb)
        fill(255, 0, 0);
      else
        fill(65);
    }
    else if(state == 2){
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
  public int getState(){
    return state;
  }
  public void setBomb(boolean b){
    isBomb = b;
  }
  public boolean getBomb(){
    return isBomb;
  }
}
