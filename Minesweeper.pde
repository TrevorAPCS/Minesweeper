private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private int flags = 30;
private int difficulty = 1;
private Button Bstart;
private Button hard;
private Button medium;
private Button easy;
private Button restart, menu;
public int tSize = 15;
// 0 = menu, 1 = before first click, 2 = play after first click, 3 = gameover, 4 = winning screen
private int gameState = 0;
//GameState gs = GameState.MENU;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup () {
    size(500, 400);
    fill(255, 0, 0);
    rect(0, 0, width, height);
    //windowResizable(true);
    textAlign(CENTER, CENTER);
    //your code to initialize buttons goes here
    Bstart = new Button((double)1/2, (double)1/2, (double)1/3, (double)23/64, 2, "Start", true);
    hard = new Button((double)1/7, (double)1/2, (double)1/3, (double)1/9, 2, "Hard", true);
    medium = new Button((double)1/7, (double)5/8, (double)1/3, (double)1/9, 2, "Medium", true);
    easy = new Button((double)1/7, (double)3/4, (double)1/3, (double)1/9, 2, "Easy", true);
    restart = new Button((double)39/48, (double)3/4, (double)1/6, (double)1/9, 1.5, "Restart", true);
    menu = new Button((double)39/48, (double)7/8, (double)1/6, (double)1/9, 1.5, "Menu", true);
}
public void generateButtons(){
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < buttons.length; r++){
    for(int c = 0; c < buttons[r].length; c++){
      buttons[r][c] = new MSButton(r, c, NUM_ROWS, NUM_COLS, 1, 0.8, 1,"");
    }
  }
}
public void startGame(MSButton b){
  mines = new ArrayList<MSButton>();
  int nb;
  if(difficulty <= 0){
    nb = 20;
  }
  else if(difficulty == 1){
    nb = 30;
  }
  else{
    nb = 40;
  }
  setMines(nb, b);
  flags = nb;
}
public void setMines(int numBombs, Button r)
{
  while(mines.size() < numBombs){
    int rr = (int)(Math.random() * NUM_ROWS);
    int rc = (int)(Math.random() * NUM_COLS);
    MSButton b = buttons[rr][rc];
    if(!mines.contains(b) && b != r){
      mines.add(b);
      b.setBomb(true);
    }
  }
}

public void draw ()
{
  background( 0 );
  updateTextSize();
  switch(gameState) {
    case 0:
      // start menu
      startMenu();
      break;
    case 3:
      // gameover
      showButtons();
      showRestartButtons();
      displayLosingMessage();
      break;
    case 4:
      // winner
      showButtons();
      showRestartButtons();
      displayWinningMessage();
      break; 
    default:
      //playing the game
      showButtons();
      showRestartButtons();
      if(gameState == 2 && isWon()){
        gameState = 4;
      }
      fill(255);
      text("Flags:", width * 9 / 10, height * 1 / 10);
      text(flags, width * 9 / 10, height * 5 / 30);
      break;
  } 
}
public boolean isWon()
{
    for(int i = 0; i < mines.size(); i++){
      if(mines.get(i).getState() != 2){
        return false;
      }
    }
    return true;
}
public void displayLosingMessage()
{
  textSize(tSize * 2);
  fill(255);
  text("You Lose", width*9/10 , height * 1/2);
}
public void displayWinningMessage()
{
  textSize(tSize * 2);
  fill(255);
  text("You Win", width*9/10, height * 1/2);
}
public boolean isValid(int r, int c)
{
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
      return true;
    return false;
}
public void showButtons(){
  for(int r = 0; r < buttons.length; r++){
    for(int c = 0; c < buttons[r].length; c++){
      buttons[r][c].show();
    }
  }
}
public void mousePressed(){
  boolean leftMouse = false;
  switch (gameState){
    case 0:
      // menu
      startButtons();
      break;
    case 3:
      // gameover
      restartButtons();
      break;
    case 4:
      // winner
      restartButtons();
      break;
    default :
      if(mouseButton == LEFT){
        leftMouse = true;
      }
      for(int r = 0; r < buttons.length; r++){
        for(int c = 0; c < buttons[r].length; c++){
          MSButton b = buttons[r][c];
          if(leftMouse){
            if(b.click(true)){
              if(gameState == 1){
                startGame(b);
                gameState = 2;
              }
              manageClick(r, c);
            }
          }
          else{
            int bState = b.flag();
            if(bState == 0){
              flags += 1;
            }
            else if(bState == 2){
              flags -= 1;
            }
            if(flags < 0){
              b.flag();
              flags += 1;
            }
          }
        }
      }
      restartButtons();
      break;
  }
}
public void manageClick(int row, int col){
  MSButton button = buttons[row][col];
  int s = checkSurroundings(row, col);
  if(button.getBomb()){
    for(int i = 0; i < mines.size(); i++){
      mines.get(i).click(false);
    }
    gameState = 3;
  }
  else if(s != 0){
    button.display(s + "");
  }
  else{
    for(int r = row - 1; r < row + 2; r++){
      for(int c = col - 1; c < col + 2; c++){
        if(isValid(r, c)){
          MSButton b = buttons[r][c];
          if(b.click(false)){
            manageClick(r, c);
          }
        }
      }
    }
  }
}
public int checkSurroundings(int row, int col){
  int numBombs = 0;
  for(int r = row - 1; r < row + 2; r++){
    for(int c = col - 1; c < col + 2; c++){
      if(isValid(r, c)){
        if(buttons[r][c].getBomb()){
          numBombs++;
        }
      }
    }
  }
  return numBombs;
}
public void startMenu(){
  String dString;
  if(difficulty <= 0)
    dString = "Easy";
  else if(difficulty == 1)
    dString = "Medium";
  else
    dString = "Hard";
  fill(150);
  rect(width / 8, height / 8, width * 3 / 4, height * 3 / 4);
  fill(0);
  textSize(tSize * 3);
  text("Minesweeper", width/2, height/4);
  textSize(tSize * 2);
  text("Difficulty: " + dString, width / 2, height * 3 / 8);
  Bstart.show();
  hard.show();
  medium.show();
  easy.show();
}
public void startButtons(){
  if(Bstart.click()){
    generateButtons();
    gameState = 1;
  }
  if(hard.click()){
    difficulty = 2;
  }
  if(medium.click()){
    difficulty = 1;
  }
  if(easy.click()){
    difficulty = 0;
  }
}
public void showRestartButtons(){
  restart.show();
  menu.show();
}
public void restartButtons(){
  if(restart.click()){
    generateButtons();
    gameState = 1;
  }
  if(menu.click()){
    gameState = 0;
  }
}
public void updateTextSize(){
  if(width < height){
    tSize = width/33;
  }
  else{
    tSize = height/33;
  }
}
