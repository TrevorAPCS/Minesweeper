class Button{
  protected int x, y, sX, sY;
  private double xr, yr, sxr, syr;
  protected double tr;
  protected String bText;
  private boolean scalable;
  public Button(double pX, double pY, double sizeX, double sizeY, double trp, String buttonText, boolean scalablep){
    scalable = scalablep;
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
    tr = trp;
  }
  public void updatePos(){
    x = (int)(xr * width);
    y = (int)(yr * height);
    sX = (int)(sxr * width);
    sY = (int)(syr * height);
  }
  public boolean click(){
    if(mousePos()){
      return true;
    }
    return false;
  }
  public void show(){
    if(scalable)
      updatePos();
    textAlign(CENTER);
    textSize(tSize * (float)tr);
    if(mousePos()){
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
  public boolean mousePos(){
    return mouseX > x && mouseX < x + sX && mouseY > y && mouseY < y + sY;
  }
}
