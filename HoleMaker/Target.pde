
color targetColor;

void setTargetColor(color c) {
  targetColor = c;
}

boolean showTarget = true;

void showTarget() {
  showTarget = true;
}

void hideTarget() {
  showTarget = false;
}

float targetX, targetY;
void setTarget() {
  targetX = mouseX();
  targetY = mouseY();
}

void setTargetCoordinates(float x, float y) {
  targetX = x;
  targetY = y;
}

void setTargetX(float x) {
  targetX = x;
}
void setTargetY(float y) {
  targetY = y;
}

boolean targetInsideCanvas() {
  return xMin <= targetX && targetX <= xMax && yMin <= targetY && targetY <= yMax;
}

void drawTarget() {
  float plotRadius = PLOT_SIZE/2;
  noFill();
  stroke(targetColor);
  if (!showTarget || !mouseInsideCanvas())
    return;
  circle(mouseX, mouseY, PLOT_SIZE);
  line(mouseX - plotRadius, mouseY, mouseX + plotRadius, mouseY);
  line(mouseX, mouseY - plotRadius, mouseX, mouseY + plotRadius);
}
