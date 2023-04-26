cell[][] grid;
character animal;

ArrayList<Ghost> ghosts;
Key theKey;
Key keyTwo;
Key keyThree;
Key keyFour;

int cols = 11;
int rows = 11;

// keep tracking game state
GameState gameState;

int endX;
int endY;

boolean isPaused = false;
boolean showMenu = false;
int menuRestartButtonX, menuRestartButtonY, menuLevelButtonX, menuLevelButtonY, menuExitButtonX, menuExitButtonY;
int menuButtonWidth, menuButtonHeight;


void setup() {
  playAudio();
  // Swtich game level based on user int level from mainMenu
  int level = getLevel();
  System.out.println("Level: "+level);
  switch (level) {
    case 1:
    {
      rows = 11;
      cols = 11;
      break;
    }
    case 2:
    {
      rows = 21;
      cols = 21;
      break;
    }
    case 3:
    {
      rows = 31;
      cols = 31;
      break;
    }
    default: break;
  }
  
  size(800, 840);
  int rowStart = 1;
  int colStart = 1;
  grid = new cell[cols][rows];
  animal = new character(rowStart, colStart);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      ///intialize cell objects 
      grid[i][j] = new cell(i*(width/cols), 40+j*((height - menuBarHeight)/rows), width/cols, height/rows, i, j);

    }
  }
 
  // Generate maze
  BetaMazeGenerator mazeGenerator = new BetaMazeGenerator(rows, cols);
  mazeGenerator.generateMaze(0, 1);
  mazeGenerator.printMaze();
  String[] mazeText = mazeGenerator.getMaze();

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
        if (mazeText[i].charAt(j) == '#') {
            grid[j][i].setWall();
        }
    }
  }

  // Set the endX and endY
  int end[] = mazeGenerator.getMazeExit();
    endX = end[0];
    endY = end[1];

 // Ghost initialization
 int ghostNumber = 2*level-1;     // Ghosts number based on level diffculty
 ghosts = new ArrayList();
 

  // Ghost assignment
 for (int i = 0; i < ghostNumber; i++) {
   ghosts.add(new Ghost());
 }

 
 gameState = new GameState();
 
 theKey = new Key(0, 1);
 grid[0][1].setKey(theKey);
 keyTwo = new Key();
 grid[keyTwo.colNum][keyTwo.rowNum].setKey(keyTwo);
 keyThree = new Key();
 grid[keyThree.colNum][keyThree.rowNum].setKey(keyThree);
 keyFour = new Key();
 grid[keyFour.colNum][keyFour.rowNum].setKey(keyFour);
}

void draw() {
  if (isPaused) {
    return;
  }
  if(mainOrGame==0){
    fill(255);
    rect(0,0,800,800);
    if(step==0){
      initializeWindow();
    }else if(step==1){
      chooseAnimal();
    }else if(step==2){
     chooseLevel();
    }
    return;
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].isWall()){
        grid[i][j].displayWall();
      }
      else{
        grid[i][j].displayOpen();
      }
    }
  }
  
  animal.displayAnimal();
  
  // Display ghosts
  for (Ghost ghost: ghosts) {
    ghost.displayGhost();
  }
  
  // Ghosts moving speed based on difficulty level
  int ghostSpeed = 30/level;
  if (frameCount % ghostSpeed == 0) {
    for (Ghost ghost : ghosts) {
      ghost.moveGhost();
      if (ghost.isCaught(animal.getRowNum(), animal.getColNum())){
        gameState.setGameLost();
        gameState.displayGameLost();
        noLoop();
      // Display game lose
      }
    }
  }
  theKey.displayKey();
  keyTwo.displayKey();
  keyThree.displayKey();
  keyFour.displayKey();

  drawMenuBar();
  if (showMenu) {
    drawMenuButtons();
  }
}

void keyPressed(){
  animal.moveAnimal();
  for (Ghost ghost : ghosts) {
    if (ghost.isCaught(animal.getRowNum(), animal.getColNum())){
      gameState.setGameLost();
      gameState.displayGameLost();
      noLoop();
      // Display game lose
    }
  }
  if (animal.getRowNum() == endY && animal.getColNum() == endX) {
    gameState.setGameWon();
    gameState.displayGameWon();
    noLoop();
  }
  
}

class character{
  int rowNum;
  int colNum;
  int numberOfKeys;
  
  character(int row, int col){
    rowNum = row;
    colNum = col;
    numberOfKeys = 0;
  }
  
  void displayAnimal(){
    fill(1, 1, 1);
    //this puts the ellipse in the center of its current cell
    int x = colNum*(width/cols)+ (width/cols)/2;
    int y = 40 + rowNum*((height-menuBarHeight)/rows)+(height/rows)/2;
    ellipse(x, y, width/cols*0.618, width/cols*0.618);
  }
  
  void setRowNum(int row){
    rowNum = row;
  }
  
  int getRowNum(){
    return rowNum;
  }
  
  void setColNum(int col){
    colNum = col;
  }
  
  int getColNum(){
    return colNum;
  }
  
  void moveAnimal(){
    
    if ((key == CODED) && (keyCode == UP)){
      //prevent out of bounds movement
      if (rowNum == 0){
        return;
      }
      //check if cell is wall
      if (grid[colNum][rowNum-1].isWall() && numberOfKeys <= 0){
          return;
      }
      //move upwards  
      rowNum = rowNum-1;
    
    } 

    if ((key == CODED) && (keyCode == DOWN)){
      if (rowNum == rows-1){
        return;
      }
      if (grid[colNum][rowNum+1].isWall() && numberOfKeys <= 0){
          return;
        }
      rowNum = rowNum+1;
    } 

    if ((key == CODED) && (keyCode == RIGHT)){
      if (colNum == cols-1){
        return;
      }
      if (grid[colNum+1][rowNum].isWall() && numberOfKeys <= 0){
          return;
        }
      colNum = colNum+1;
    } 
    if ((key == CODED) && (keyCode == LEFT)){
      if (colNum == 0){
        return;
      }
      if (grid[colNum-1][rowNum].isWall() && numberOfKeys <= 0){
          return;
       }
      colNum = colNum-1;
    }
    if (grid[colNum][rowNum].isWall()){
      grid[colNum][rowNum].destroyWall();
      numberOfKeys = numberOfKeys - 1;
    }
    if (grid[colNum][rowNum].hasKey()){
      getKey();
      grid[colNum][rowNum].aKey.getKey();
      theKey.getKey();
      grid[colNum][rowNum].removeKey();
    }
  }
  
  boolean hasKey(){
    if (numberOfKeys > 0) return true;
    else return false;
  }
  
  void getKey(){
    numberOfKeys = numberOfKeys +1;
  }
}

class cell {

  boolean wall = false;
  int x, y;
  int w, h;
  int row, col;
  boolean hasKey = false;
  Key aKey; 
 
  cell (int x, int y, int w, int h, int row, int col) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this. row = row;
    this.col = col;
  } 

  void displayOpen() {
    stroke(0, 0, 0);
    fill(255, 255, 255); 
    rect(x, y, w, h);
  }
  
  void displayWall() {
    stroke(0, 0, 0);
    fill(0, 0, 0); 
    rect(x, y, w, h);
  }
  
  boolean isWall(){
    if (wall == true) return true;
    else return false;
  }
  
  void setWall(){
    wall = true;
  }
  
  void destroyWall(){
    wall = false;
  }
  
  boolean hasKey(){
    if (hasKey == true) return true;
    else return false;
  }
  
  void setKey(Key someKey){
    hasKey = true;
    aKey = someKey;
  }
  
  void removeKey(){
    hasKey = false;
  }
  
}

// Ghost class
class Ghost {
  int rowNum;
  int colNum;
  
  Ghost(){
    do {
      rowNum = int (random(rows));
      colNum = int (random(cols));
    } while (grid[colNum][rowNum].isWall());
  }

  void displayGhost(){
    fill(255, 192, 203);
    //this puts the ellipse in the center of its current cell
    int x = colNum*(width/cols)+ (width/cols)/2;
    int y = 40 + rowNum*((height-menuBarHeight)/rows)+(height/rows)/2;
    ellipse(x, y, width/cols*0.618, width/cols*0.618);
  }
  
  void setRowNum(int row){
    rowNum = row;
  }
  
  int getRowNum(){
    return rowNum;
  }
  
  void setColNum(int col){
    colNum = col;
  }
  
  int getColNum(){
    return colNum;
  }
  
  void moveGhost(){
    if (!isMoved()) return;
    int direction = int (random(2));
    int moveRow = rowNum;
    int moveCol = colNum;
    if (direction == 0) moveRow = int (random(-2, 2)) + rowNum;
    if (direction == 1) moveCol = int (random(-2, 2)) + colNum;
    if (moveRow < 0 || moveRow >= rows || moveCol < 0 || moveCol >= cols) return;
    if (!grid[moveCol][moveRow].isWall()) {
      rowNum = moveRow;
      colNum = moveCol;
    }  
  }
  
  boolean isMoved(){
    int number = int (random(2));
    boolean res = number == 1 ? true : false;
    return true;
 }
 
 boolean isCaught(int row, int col) {
   if (rowNum == row && colNum == col) {
     return true;
   }
   return false;
 }
}

class Key{
  int rowNum;
  int colNum;
  boolean obtained;
  
  Key(int col, int row){
    rowNum = row;
    colNum = col;
    obtained = false;
  }
  
  Key(){
    do {
      rowNum = int (random(rows));
      colNum = int (random(cols));
    } while (grid[colNum][rowNum].isWall() || grid[colNum][rowNum].hasKey());
  }
  
  void displayKey(){
    if (isObtained()) return;
    fill(1, 1, 1);
    //this puts the ellipse in the center of its current cell
    int x = colNum*(width/cols)+ (width/cols)/2;
    int y = 40 + rowNum*((height-menuBarHeight)/rows)+(height/rows)/2;
    ellipse(x, y, 5, 5);
    // Testing: print the End Cell
    int realEndX = endX*(width/cols)+ (width/cols)/2;
    int realEndY = 40 + endY*((height-menuBarHeight)/rows)+(height/rows)/2;
    //draw an '->' at the end cell
    fill(200, 0, 0);
    textSize(8);
    text("EXIT", realEndX, realEndY);
    println("End Cell: " + endX + ", " + endY);
  }
  
  void getKey(){
    obtained = true;
  }
  
  boolean isObtained(){
    if (obtained == true) return true;
    else return false;
  }
}


class GameState {
  boolean isGameLost;
  boolean isGameWon;
  
  GameState(){
    isGameLost = false;
    isGameWon = false;
  }
  
  boolean getGameWon() {
    return isGameWon;
  }
  
  void setGameWon() {
    isGameWon = true;
  }
  
  boolean getGameLost() {
    return isGameLost;
  }
  
  void setGameLost() {
    isGameLost = true;
  }
  
  void displayGameWon() {
    background(51);
    textSize(50);
    text("You won!", 300, 400);
  }
  
  void displayGameLost() {
    background(51);
    textSize(50);
    text("You lost!", 300, 400);
  }
  
}

void drawMenuButtons() {
  menuButtonWidth = 200;
  menuButtonHeight = 50;
  menuRestartButtonX = (width - menuButtonWidth) / 2;
  menuRestartButtonY = (height - menuButtonHeight * 3) / 2;
  menuLevelButtonX = (width - menuButtonWidth) / 2;
  menuLevelButtonY = menuRestartButtonY + menuButtonHeight + 10;
  menuExitButtonX = (width - menuButtonWidth) / 2;
  menuExitButtonY = menuLevelButtonY + menuButtonHeight + 10;

  fill(255);
  rect(menuRestartButtonX, menuRestartButtonY, menuButtonWidth, menuButtonHeight);
  rect(menuLevelButtonX, menuLevelButtonY, menuButtonWidth, menuButtonHeight);
  rect(menuExitButtonX, menuExitButtonY, menuButtonWidth, menuButtonHeight);

  textSize(24);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Restart", menuRestartButtonX + menuButtonWidth / 2, menuRestartButtonY + menuButtonHeight / 2);
  text("Change Level", menuLevelButtonX + menuButtonWidth / 2, menuLevelButtonY + menuButtonHeight / 2);
  text("Exit", menuExitButtonX + menuButtonWidth / 2, menuExitButtonY + menuButtonHeight / 2);
}

void mouseClicked() {
  if (showMenu) {
    if (mouseX >= menuRestartButtonX && mouseX <= menuRestartButtonX + menuButtonWidth &&
        mouseY >= menuRestartButtonY && mouseY <= menuRestartButtonY + menuButtonHeight) {
      // Restart the game
      setup();
      loop();
    } else if (mouseX >= menuLevelButtonX && mouseX <= menuLevelButtonX + menuButtonWidth &&
               mouseY >= menuLevelButtonY && mouseY <= menuLevelButtonY + menuButtonHeight) {
      // Change the level
      level += 1;
      if (level > 3) {
        level = 1;
      }
      setup();
      loop();
    } else if (mouseX >= menuExitButtonX && mouseX <= menuExitButtonX + menuButtonWidth &&
               mouseY >= menuExitButtonY && mouseY <= menuExitButtonY + menuButtonHeight) {
      // Exit the game
      exit();
    }
  }
}
