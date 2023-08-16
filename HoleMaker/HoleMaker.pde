
void setup() {
  fullScreen();
  loadSettings();
}

void draw() {
  if (FATAL)
    return;
  setCursor();
  setTarget();
  drawCanvas();
  showMouseCoordinates();
  showDimensions();
  showTools();
  drawTarget();
  showInfo();
}
