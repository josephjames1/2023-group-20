cell[][] grid;
character animal;
int cols = 20;
int rows = 20;

void setup() {
  size(600, 600);
  int rowStart = 0;
  int colStart = 0;
  grid = new cell[cols][rows];
  animal = new character(rowStart, colStart);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      ///intialize cell objects 
      grid[i][j] = new cell(i*(width/cols), j*(height/rows), width/cols, height/rows, i, j);

    }
  }
  //create walls for maze
 grid[0][1].setWall();
 grid[0][2].setWall();
 grid[0][3].setWall();
 grid[1][3].setWall();
 grid[2][3].setWall();
 grid[3][3].setWall();
 grid[4][3].setWall();
 grid[5][3].setWall();
 grid[6][3].setWall();
}

void draw() {
  background(255);
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
}

void keyPressed(){
  animal.moveAnimal();
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
    int x = colNum*(width/cols)+ (width/cols)/2;
    int y = rowNum*(height/rows)+(height/rows)/2;
    ellipse(x, y, 20, 20);
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
