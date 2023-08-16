
float roundToHundredth(float number) {
  float roundedNumber = Math.round(number * 100) / 100.0;
  return roundedNumber;
}

float mouseCoordinatesTextSize = 40, mouseCoordinatesY, mouseCoordinatesHeight;
void showMouseCoordinates() {
  setTextSize(mouseCoordinatesTextSize);
  fill(0);
  noStroke();
  float x = roundToHundredth(mouseX()), y = roundToHundredth(mouseY());
  if (xMin <= x && x <= xMax && yMin <= y && y <= yMax) {
    String message = "("+x+", "+y+")";
    float messageX = (displayWidth - textWidth(message))/2.0, messageY = mouseCoordinatesY;
    fill(white);
    rect(messageX, messageY - textHeight(message), textWidth(message), 1.33 * textHeight(message));
    fill(black);
    text(message, messageX, messageY);
  }
}

float mouseX() {
  return (1.0 * mouseX - origin[0]) / scale;
}

float mouseY() {
  return (1.0 * origin[1] - mouseY) / scale;
}

boolean mouseInsideCanvas() {
  return xMin <= mouseX() && mouseX() <= xMax && yMin <= mouseY() && mouseY() <= yMax;
}

boolean insideCanvas(float x, float y) {
  return xMin <= x && x <= xMax && yMin <= y && y <= yMax;
}

void setCursor() {
  if (mouseInsideCanvas())
    noCursor();
  else
    cursor();
}

void mouseClicked() {
  addHole(new Hole(targetX, targetY));
}
