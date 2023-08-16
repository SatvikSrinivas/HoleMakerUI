
// This function ensures that the MouseCoordinates, Messages and the Canvas are all formatted correctly
void establishView() {
  float breathingRoom = 0.02 * displayHeight, y = 0.05 * displayHeight;
  mouseCoordinatesY = y;
  setTextSize(mouseCoordinatesTextSize);
  mouseCoordinatesHeight = textHeight("(0.00, 0.00)");
  y += mouseCoordinatesHeight;
  y += breathingRoom;
  messageY = y;
  setTargetColor(originalTargetColor);
}

color black = color(0), white = color(255), red = color(255, 0, 0), orange = color(255, 165, 0), blue = color(0, 0, 255),
  canvasColor = color(210, 180, 140), originalTargetColor = color(255, 0, 255), holeColor = color(134, 119, 95),
  backgroundColor = color(121), alternateTargetColor = color(0, 255, 255),
  alternateTargetColor2 = color(255, 255, 0), alternateTargetColor3 = color(0, 191, 0),
  messageBackground = color (255, 255, 224), lightGreen = color(144, 238, 144);
