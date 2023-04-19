cell[][] grid;
character animal;
ArrayList<Ghost> ghosts;
int cols = 11;
int rows = 11;
boolean isGameLost = false;
boolean isGameWon = false;

void setup() {
  // Swtich game level based on user int level from mainMenu
  int level = mainMenu.getLevel();
  System.out.println(level);
  switch (level) {
    case 1:
    {
      break;
    }
    case 2:
    {
      rows += 10;
      cols += 10;
      
      break;
    }
    case 3:
    {
      rows += 20;
      cols += 20;
      break;
    }
    default: break;
  }
  size(800, 800);
  int rowStart = 1;
  int colStart = 1;
  grid = new cell[cols][rows];
  animal = new character(rowStart, colStart);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      ///intialize cell objects 
      grid[i][j] = new cell(i*(width/cols), j*(height/rows), width/cols, height/rows, i, j);

    }
  }
 
 //String[] mazeText = {
 //           " ###################",
 //           "            #      #",
 //           "###### ###### #### #",
 //           "## ### ###### #    #",
 //           "## #   #   ## # # ##",
 //           "## # ### # ## # #  #",
 //           "## #     #    # ####",
 //           "## ###### # ### ## #",
 //           "#        ## ### ## #",
 //           "###### ###### # # ##",
 //           "#      #      # #  #",
 //           "# ##### ####### # ##",
 //           "# ###    #      #  #",
 //           "# # ###### ###### ##",
 //           "# #  ##  #         #",
 //           "# ## ## ###### #####",
 //           "# #  # ##          #",
 //           "# # ## ## ###### ###",
 //           "#     ###          #",
 //           "##################  "
 //       };
 //  for (int i = 0; i < rows; i++) {
 //           for (int j = 0; j < cols; j++) {
 //               if (mazeText[i].charAt(j) == '#')
 //               {
 //                 grid[j][i].setWall();
 //               }
 //           }
 //       }
 // String[] mazeText = MazeGenerator.generateMaze(rows, cols);
  //BetaMazeGenerator mazeGenerator = new BetaMazeGenerator(rows, cols);
  // Generate a maze based on the int level from mainMenu
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
 // Ghost initialization
 int ghostNumber = 2*level-1;     // Ghosts number based on level diffculty
 ghosts = new ArrayList();
 
  // Ghost assignment
 for (int i = 0; i < ghostNumber; i++) {
   ghosts.add(new Ghost());
 }
}

void draw() {
  if(mainOrGame==0){
    fill(255);
    rect(0,0,400,500);
    if(step==0){
      initializeWindow();
    }else if(step==1){
      mainGameMenu();
    }else if(step==2){
     chooseAnimal();
    }else if(step==3){
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
        isGameLost = true;
      // Display game lose
      }
    }
  }
}

void keyPressed(){
  animal.moveAnimal();
  for (Ghost ghost : ghosts) {
    if (ghost.isCaught(animal.getRowNum(), animal.getColNum())){
      isGameLost = true;
      // Display game lose
    }
  }
}

class character{
  int rowNum;
  int colNum;
  
  character(int row, int col){
    rowNum = row;
    colNum = col;
  }
  
  void displayAnimal(){
    fill(1, 1, 1);
    //this puts the ellipse in the center of its current cell
    int x = colNum*(width/cols)+ (width/cols)/2;
    int y = rowNum*(height/rows)+(height/rows)/2;
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
      if (grid[colNum][rowNum-1].isWall()){
          return;
      }
      //move upwards  
      rowNum = rowNum-1;
    
    } 

    if ((key == CODED) && (keyCode == DOWN)){
      if (rowNum == rows-1){
        return;
      }
      if (grid[colNum][rowNum+1].isWall()){
          return;
        }
      rowNum = rowNum+1;
    } 

    if ((key == CODED) && (keyCode == RIGHT)){
      if (colNum == cols-1){
        return;
      }
      if (grid[colNum+1][rowNum].isWall()){
          return;
        }
      colNum = colNum+1;
    } 
    if ((key == CODED) && (keyCode == LEFT)){
      if (colNum == 0){
        return;
      }
      if (grid[colNum-1][rowNum].isWall()){
          return;
        }
      colNum = colNum-1;
    }
  }
}

class cell {

  boolean wall = false;
  int x, y;
  int w, h;
  int row, col;
 
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
    int y = rowNum*(height/rows)+(height/rows)/2;
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
