int buttonWidth = 80;
int buttonHeight = 30;
int pauseButtonX = 20;
int pauseButtonY = 5;
int restartButtonX = 120;
int restartButtonY = 5;
int settingsButtonX = 220;
int settingsButtonY = 5;
int powerUpCountX = 320;
int powerUpCountY = 5;

int menuBarHeight = 40;

void drawMenuBar(int keyCount) {
  // Draw the menu bar background
  fill(100, 100, 100, 200);
  rect(0, 0, width, menuBarHeight);

  // Add buttons to the menu bar
  fill(255);
  rect(pauseButtonX, pauseButtonY, buttonWidth, buttonHeight);
  rect(restartButtonX, restartButtonY, buttonWidth, buttonHeight);
  rect(settingsButtonX, settingsButtonY, buttonWidth, buttonHeight);
  rect(powerUpCountX, settingsButtonY, buttonWidth + 20, buttonHeight);

  // Add labels to the buttons
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Pause", pauseButtonX + buttonWidth / 2, pauseButtonY + buttonHeight / 2);
  text("Restart", restartButtonX + buttonWidth / 2, restartButtonY + buttonHeight / 2);
  text("Settings", settingsButtonX + buttonWidth / 2, settingsButtonY + buttonHeight / 2);
  text("Power-Ups: " + keyCount, settingsButtonX + buttonWidth / 2, settingsButtonY + buttonHeight / 2);
}

boolean isButtonClicked(int buttonX, int buttonY, int buttonWidth, int buttonHeight) {
  return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
}
