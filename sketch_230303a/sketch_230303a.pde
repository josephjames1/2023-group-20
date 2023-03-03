//0 represents not choose now!
//1 represents tiger!
//2 represents rabbit!
//3 represents rat!
int animal=0;
//0 represents not choose now!
//1 represents easy!
//2 represents medium!
//3 represents hard!
int level=0;
//0 represents initialize window
//1 represents main menu
//2 represents choose animal
//3 represents choose level
int step=0;


void setup(){
  size(400,500);
  background(255);
}


void draw()
{
  fill(255);
  rect(0,0,400,500);
  if(step==0){
    initializeWindow();
  }else if(step==1){
    mainMenu();
  }else if(step==2){
   chooseAnimal();
  }else if(step==3){
    chooseLevel();
  }
}

void initializeWindow()
{
  textSize(100);
  fill(0);
  text("MAZE", 80, 200);
  text("GAME !", 60, 300);
  textSize(20);
  text("Click anywhere to start!", 20, 450);
}

void mainMenu()
{
  textSize(30);
  //choose animal
  if(animal!=0){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,50,200,80);
  fill(0);
  text("Choose animal", 110, 100);
  
  //choose level
  if(level!=0){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,170,200,80);
  fill(0);
  text("Choose level", 120, 220);
  
  //exit
  fill(255);
  rect(50,400,100,50);
  fill(0);
  text("EXIT", 75, 435);
  //begi 
  fill(255);
  rect(250,400,100,50);
  fill(0);
  text("BEGIN ", 260, 435);
}

void chooseAnimal()
{
  textSize(30);
  //TIGER
  if(animal==1){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,50,200,80);
  fill(0);
  text("TIGER", 160, 100);
  
  //RABBIT
  if(animal==2){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,170,200,80);
  fill(0);
  text("RABBIT", 160, 220);
  
  //RAT
  if(animal==3){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,290,200,80);
  fill(0);
  text("RAT", 180, 340);
  
  //exit
  fill(255);
  rect(50,400,100,50);
  fill(0);
  text("BACK", 67, 435);
}


void chooseLevel()
{
  textSize(30);
  //easy
  if(level==1){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,50,200,80);
  fill(0);
  text("EASY", 170, 100);
  
  //medium
  if(level==2){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,170,200,80);
  fill(0);
  text("MEDIUM", 155, 220);
  
  //hard
  if(level==3){
    fill(255,0,0);
  }else{
    fill(255);
  }
  rect(100,290,200,80);
  fill(0);
  text("HARD", 170, 340);
  
  //exit
  fill(255);
  rect(50,400,100,50);
  fill(0);
  text("BACK", 67, 435);
}

void mousePressed() {
  if(step==0){
    step=1;
    return;
  }
  if(step==1){
    if((mouseX>=100 && mouseX<=300)&&(mouseY>=50 && mouseY<=130)){
      step=2;
      return;
    }
    if((mouseX>=100 && mouseX<=300)&&(mouseY>=170 && mouseY<=250)){
      step=3;
      return;
    }
    if((mouseX>=50 && mouseX<=150)&&(mouseY>=400 && mouseY<=450)){
      step=0;
      return;
    }
    if((mouseX>=250 && mouseX<=350)&&(mouseY>=400 && mouseY<=450)){
      step=0;
      return;
    }
  }
  if(step==2){
    if((mouseX>=100 && mouseX<=300)&&(mouseY>=50 && mouseY<=130)){
      animal=1;
    }else if((mouseX>=100 && mouseX<=300)&&(mouseY>=170 && mouseY<=250)){
      animal=2;
    }else if((mouseX>=100 && mouseX<=300)&&(mouseY>=290 && mouseY<=370)){
      animal=3;
    }
    if((mouseX>=50 && mouseX<=150)&&(mouseY>=400 && mouseY<=450)){
      step=1;
      return;
    }
  }
  if(step==3){
    if((mouseX>=100 && mouseX<=300)&&(mouseY>=50 && mouseY<=130)){
      level=1;
    }else if((mouseX>=100 && mouseX<=300)&&(mouseY>=170 && mouseY<=250)){
      level=2;
    }else if((mouseX>=100 && mouseX<=300)&&(mouseY>=290 && mouseY<=370)){
      level=3;
    }
    if((mouseX>=50 && mouseX<=150)&&(mouseY>=400 && mouseY<=450)){
      step=1;
      return;
    }
  }
  loop();
}
