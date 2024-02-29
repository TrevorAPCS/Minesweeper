class Button{
  protected int x, y, sX, sY;
  private double xr, yr, sxr, syr;
  protected double tr;
  protected String bText;
  private boolean scalable;
  public Button(double pX, double pY, double sizeX, double sizeY, double tr, String buttonText, boolean scalable){
    this.scalable = scalable;
    if(scalable){
      xr = pX;
      yr = pY;
      sxr = sizeX;
      syr = sizeY;
    }
    else{
      x = (int)pX;
      y = (int)pY;
      sX = (int)sizeX;
      sY = (int)sizeY;
    }
    bText = buttonText;
    this.tr = tr;
  }
  public void updatePos(){
    x = (int)(xr * width);
    y = (int)(yr * height);
    sX = (int)(sxr * width);
    sY = (int)(syr * height);
  }
  public boolean click(){
    if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
      return true;
    }
    return false;
  }
  public void show(){
    if(scalable)
      updatePos();
    textAlign(CENTER);
    textSize(TEXT_SIZE * (float)tr);
    if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
      fill(75);
    }
    else{
      fill(100);
    }
    rect(x, y, sX, sY);
    fill(0);
    text(bText, x + sX/2, y + sY/(1.5));
  }
  public void display(String str){
    bText = str;
  }
}
