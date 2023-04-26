import ddf.minim.*;
//0 represents not choose now!
//1 represents tiger!
//2 represents rabbit!
//3 represents rat!
static int role=0;
//0 represents not choose now!
//1 represents easy!
//2 represents medium!
//3 represents hard!
static int level=0;
//0 represents initialize window
//1 represents choose animal
//2 represents choose level
int step=0;
//1 represetn mainmenu;
//2 represents game;
int mainOrGame=0;
PImage easy;
PImage medium;
PImage hard;
PImage x;
PImage animalDisplay;
PImage levelDisplay;
PImage tigerWord;
PImage rabbitWord;
PImage ratWord;
PImage continueWord;
PImage returnWord;

void initialBackGround(String URL){
  PImage img=loadImage(URL);
  img.resize(800, 800);
  img.filter(BLUR, 0);
  image(img, 0, 0);

}

void initializeWindow()
{
  initialBackGround("background4.jpeg");
  x=loadImage("x.png");
  x.resize(20, 20);
  image(x, 0, 0);
  
  PImage maze=loadImage("maze.png");
  maze.resize(500, 175);
  image(maze, 150, 200);
  
  PImage game=loadImage("game.png");
  game.resize(400, 150);
  image(game, 200, 400);
  
  PImage anywhere=loadImage("anywhere.png");
  anywhere.resize(400, 50);
  image(anywhere, 50, 650);
}

void chooseAnimal()
{
  initialBackGround("background4.jpeg");
  x=loadImage("x.png");
  x.resize(20, 20);
  image(x, 0, 0);
  
  tigerWord=loadImage("tigerWord.png");
  tigerWord.resize(200, 100);
  image(tigerWord, 300, 250);
  
  rabbitWord=loadImage("rabbitWord.png");
  rabbitWord.resize(200, 100);
  image(rabbitWord, 300, 400);
  
  ratWord=loadImage("ratWord.png");
  ratWord.resize(200, 100);
  image(ratWord, 300, 550);
  
  returnWord=loadImage("return.png");
  returnWord.resize(100, 40);
  image(returnWord, 100, 700);
  
  PImage animal=loadImage("animal.png");
  animal.resize(300, 100);
  image(animal, 250, 100);
}


void chooseLevel()
{
  initialBackGround("background4.jpeg");
  if(role!=0){
    animalDisplay.resize(200, 200);
    image(animalDisplay, 550, 500);
  }
  
  easy=loadImage("easy.png");
  easy.resize(200, 100);
  image(easy, 300, 250);
  
  medium=loadImage("medium.png");
  medium.resize(200, 100);
  image(medium, 300, 400);
  
  hard=loadImage("hard.png");
  hard.resize(200, 100);
  image(hard, 300, 550);
  
  ratWord=loadImage("return.png");
  ratWord.resize(100, 40);
  image(ratWord, 100, 700);
  
  PImage img1=loadImage("level.png");
  img1.resize(300, 100);
  image(img1, 250, 100);
  
  if(level==1){
    levelDisplay.resize(200, 100);
    image(levelDisplay, 300, 250);
  }else if(level==2){
    levelDisplay.resize(200, 100);
    image(levelDisplay, 300, 400);
  }else if(level==3){
    levelDisplay.resize(200, 100);
    image(levelDisplay, 300, 550);
  }
}

void mousePressed() {
  if(mouseX >= 0 && mouseX <= 0+x.width && mouseY >= 0 && mouseY <= 0+x.height){
      exit();
  }
  
  if(step==0){
    step=1;
    return;
  }
  
  if(step==1){
    if (mouseX >= 300 && mouseX <= 300+tigerWord.width && mouseY >= 250 && mouseY <= 250+tigerWord.height) {
      animalDisplay=loadImage("tiger.png");
      role=1;
    }else if (mouseX >= 300 && mouseX <= 300+rabbitWord.width && mouseY >= 400 && mouseY <= 400+rabbitWord.height) {
      animalDisplay=loadImage("rabbit.png");
      role=2;
    }else if (mouseX >= 300 && mouseX <= 300+ratWord.width && mouseY >= 550 && mouseY <= 550+ratWord.height) {
      animalDisplay=loadImage("rat.png");
      role=3;
    }
    
    if(role!=0){
      step=2;
    }
    
    if(mouseX >= 100 && mouseX <= 100+returnWord.width && mouseY >= 700 && mouseY <= 700+returnWord.height){
      role=0;
      step=0;
    }
     
    return;
  }
  
 
  if(step==2){
    if (mouseX >= 300 && mouseX <= 300+easy.width && mouseY >= 250 && mouseY <= 250+easy.height) {
      level=1;
      setup();
    }else if (mouseX >= 300 && mouseX <= 300+easy.width && mouseY >= 400 && mouseY <= 400+easy.height) {
      level=2;
      setup();
    }else if (mouseX >= 300 && mouseX <= 300+easy.width && mouseY >= 550 && mouseY <= 550+easy.height) {
      level=3;
      setup();
    }

    if(level!=0){
       mainOrGame=1;
    }
    
    if(mouseX >= 100 && mouseX <= 100+returnWord.width && mouseY >= 700 && mouseY <= 700+returnWord.height){
      level=0;
      step=1;
    }
    return;
  }
  
  if (mainOrGame == 2) {
    if (isButtonClicked(pauseButtonX, pauseButtonY, buttonWidth, buttonHeight)) {
      println("Pause button clicked");
      isPaused = !isPaused;
    } else if (isButtonClicked(restartButtonX, restartButtonY, buttonWidth, buttonHeight)) {
      // Restart the game
      println("Restart button clicked");
      isPaused = false;
      setup();
    } else if (isButtonClicked(settingsButtonX, settingsButtonY, buttonWidth, buttonHeight)) {
      // Open the settings menu
    }
    return; // Return after checking for the menu bar button clicks
  }
  draw();
  
}

public void playAudio(){
  Minim minim = new Minim(this);
  AudioPlayer player = minim.loadFile("backgroundAudio1.mp3");
  player.loop();
}

public static int getLevel(){
  return level;
}

public static int getRole(){
  return role;
}
