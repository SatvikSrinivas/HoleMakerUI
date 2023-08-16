
// PLOT_SIZE is in pixels, PLOT_DIAMETER, PLOT_RADIUS, SPACING are in inches (canvas units)
float PLOT_SIZE, PLOT_DIAMETER, PLOT_RADIUS, SPACING;

void setPlotSize(float size) {
  PLOT_SIZE = size;
}

void setPlotDiameter(float plotDia) {
  PLOT_DIAMETER = plotDia;
  if (!verifyPlotDiameter())
    return;
  PLOT_RADIUS = PLOT_DIAMETER/2.0;
  setOrigin();
}

boolean verifyPlotDiameter() {
  if (PLOT_DIAMETER > CANVAS_WIDTH) {
    dispatchFatalError("Invalid Canvas Specifications: {canvasWidth: " + CANVAS_WIDTH +" < plotDiameter: "+PLOT_DIAMETER+"} please reconfigure \"__settings__.json\"");
    return false;
  }
  if (PLOT_DIAMETER > CANVAS_HEIGHT) {
    dispatchFatalError("Invalid Canvas Specifications: {canvasHeight: " + CANVAS_HEIGHT +" < plotDiameter: "+PLOT_DIAMETER+"} please reconfigure \"__settings__.json\"");
    return false;
  }
  return true;
}

void setSpacing(float s) {
  SPACING = s;
  if (!verifySpacing())
    return;
}

boolean verifySpacing() {
  if (SPACING < PLOT_DIAMETER) {
    dispatchFatalError("Invalid Canvas Specifications: {spacing: " + SPACING +" < plotDiameter: "+PLOT_DIAMETER+"} please reconfigure \"__settings__.json\"");
    return false;
  }
  if (SPACING > CANVAS_WIDTH) {
    dispatchFatalError("Invalid Canvas Specifications: {spacing: " + SPACING +" > canvasWidth: "+CANVAS_WIDTH+"} please reconfigure \"__settings__.json\"");
    return false;
  }
  if (SPACING > CANVAS_HEIGHT) {
    dispatchFatalError("Invalid Canvas Specifications: {spacing: " + SPACING +" > canvasHeight: "+CANVAS_HEIGHT+"} please reconfigure \"__settings__.json\"");
    return false;
  }
  return true;
}

void plot(float x, float y, color c, float size) {
  noStroke();
  fill(c);
  circle(getX(x), getY(y), size);
}

void plot(float x, float y, color c) {
  plot(x, y, c, PLOT_SIZE);
}

float getScaled(float f) {
  return f * scale;
}

float getDescaled(float f) {
  return f / scale;
}

float getX (float x) {
  return origin[0] + x * scale;
}

float getY (float y) {
  return origin[1] - y * scale;
}

float lineSegment (float x1, float y1, float x2, float y2) {
  line(getX(x1), getY(y1), getX(x2), getY(y2));
  return dist(x1, y1, x2, y2);
}

void rectangle(float x, float y, float w, float h) {
  rect(getX(x), getY(y), getScaled(w), getScaled(h));
}
