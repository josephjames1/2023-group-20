int buttonWidth = 80;
int buttonHeight = 30;
int pauseButtonX = 20;
int pauseButtonY = 5;
int restartButtonX = 120;
int restartButtonY = 5;
int settingsButtonX = 220;
int settingsButtonY = 5;

void drawMenuBar() {
  int menuBarHeight = 40;

  // Draw the menu bar background
  fill(100, 100, 100, 200);
  rect(0, 0, width, menuBarHeight);

  // Add buttons to the menu bar
  fill(255);
  rect(pauseButtonX, pauseButtonY, buttonWidth, buttonHeight);
  rect(restartButtonX, restartButtonY, buttonWidth, buttonHeight);
  rect(settingsButtonX, settingsButtonY, buttonWidth, buttonHeight);

  // Add labels to the buttons
  textSize(20);
  fill(0);
  text("Pause", pauseButtonX + 20, pauseButtonY + 23);
  text("Restart", restartButtonX + 10, restartButtonY + 23);
  text("Settings", settingsButtonX + 5, settingsButtonY + 23);
}

boolean isButtonClicked(int buttonX, int buttonY, int buttonWidth, int buttonHeight) {
  return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
}
