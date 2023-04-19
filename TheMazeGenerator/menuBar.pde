void drawMenuBar() {
  int menuBarHeight = 40;

  // Draw the menu bar background
  fill(100, 100, 100, 200);
  rect(0, 0, width, menuBarHeight);

  // Add buttons and labels to the menu bar
  fill(255);
  textSize(20);
  text("Pause", 20, 28);
  text("Restart", 100, 28);
  text("Settings", 200, 28);
}
