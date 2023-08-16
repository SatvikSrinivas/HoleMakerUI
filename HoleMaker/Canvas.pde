
float CANVAS_WIDTH, CANVAS_HEIGHT;
float xMin, xMax, yMin, yMax;

void canvasSetup(float w, float h, float d, float s) {
  CANVAS_WIDTH = w;
  CANVAS_HEIGHT = h;
  xMin = 0;
  xMax = CANVAS_WIDTH;
  yMin = 0;
  yMax = CANVAS_HEIGHT;
  setPlotDiameter(d);
  setScale();
  showDimensionsSetup();
  setSpacing(s);
}

void setScale() {
  setScale(min((displayWidth / (1.5 * CANVAS_WIDTH)), (displayHeight / (1.5 * CANVAS_HEIGHT))));
}

float scale;

void setScale(float s) {
  scale = s;
  if (!verifyCanvasAspectRatio())
    return;
  setOrigin();
  setPlotSize(getScaled(PLOT_DIAMETER));
  setSnapThrehold(PLOT_DIAMETER);
}

boolean verifyCanvasAspectRatio() {
  if (min(getScaled(CANVAS_WIDTH), getScaled(CANVAS_HEIGHT)) < 5) {
    dispatchFatalError("Invalid Canvas Aspect Ratio (" + CANVAS_WIDTH +" : "+CANVAS_HEIGHT+") please reconfigure \"__settings__.json\"");
    return false;
  }
  return true;
}

int[] origin;

void setOrigin() {
  origin = new int[] {(int) ((displayWidth - getScaled(CANVAS_WIDTH)) / 2.0),
    (int) ((displayHeight + getScaled(CANVAS_HEIGHT)) / 2.0)};
}

void drawCanvas() {
  background(backgroundColor);
  fill(canvasColor);
  noStroke();
  rectangle(xMin, yMax, CANVAS_WIDTH, CANVAS_HEIGHT);
  stroke(0);
  strokeWeight(2);
  noFill();
  rectangle(xMin, yMax, CANVAS_WIDTH, CANVAS_HEIGHT);
  drawHoles();
}

boolean showDimensions = true;

float showDimensionsOffset, showDimensionsX, showDimensionsY; // displayUnits NOT canvasUnits
void showDimensionsSetup() {
  showDimensionsOffset = 0.025 * displayHeight;
  showDimensionsX = getX(xMin) - showDimensionsOffset;
  showDimensionsY = getY(yMin) + showDimensionsOffset;
}

void showDimensions() {
  if (!showDimensions)
    return;
  stroke(black);
  line(showDimensionsX, getY(yMin), showDimensionsX, getY(yMax));
  line(getX(xMin), showDimensionsY, getX(xMax), showDimensionsY);
  String dimX = CANVAS_WIDTH + " in", dimY = CANVAS_HEIGHT + " in";
  fill(0);
  setTextSize('L');
  text(dimX, showDimensionsX + showDimensionsOffset + (getScaled(xMax) - textWidth(dimX))/2.0, showDimensionsY + 2 * showDimensionsOffset);
  drawRotatedText(dimY, showDimensionsX - showDimensionsOffset, getY(yMin)-(getScaled(CANVAS_HEIGHT) - textWidth(dimY))/2.0, -PI/2);
}

void handleDimensions() {
  showDimensions = !showDimensions;
}

void resetCanvas() {
  setupHoles(); // deletes all existing holes --> fresh canvas
}
