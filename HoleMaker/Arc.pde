
class Arc {

  float centerX, centerY, x1, y1, x2, y2, increment; // NOTE: increment is an angle in radians

  public void construct(float centerX, float centerY, float x1, float y1, float x2, float y2, float increment) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.increment = increment;
  }

  public Arc (float centerX, float centerY, float x1, float y1, float x2, float y2) {
    construct(centerX, centerY, x1, y1, x2, y2, PI/4); // default constructor assumes increment = PI/4 unless otherwise specified
  }

  public Arc (float centerX, float centerY, float x1, float y1, float x2, float y2, float increment) {
    construct(centerX, centerY, x1, y1, x2, y2, increment); // default constructor assumes increment = PI/4 unless otherwise specified
  }

  public float angleBetweenStartAndEnd() {
    Vector v1 = new Vector(centerX, centerY, x1, y1), v2 = new Vector(centerX, centerY, x2, y2);

    float arg = v1.dot(v2)/(v1.magnitude() * v2.magnitude()), theta;
    boolean ans = true; // true -> ans = theta, false -> ans = TAU - theta

    // must squeeze arg into valid domain of acos [-1, 1]
    // arg = -1.0000001 would cause an error of acos(arg) = NaN but acos(-1) = PI
    if (arg <= -1)
      return PI;

    theta = acos(arg);

    if (pointIsAboveLine(mouseX(), mouseY(), centerX, centerY, x1, y1))
      ans = false;

    if (centerX > x1) {
      if (!arcOrientation_isCounterClockwise)
        ans = !ans;
    } else if (arcOrientation_isCounterClockwise)
      ans = !ans;

    if (ans)
      return theta;
    return TAU - theta;
  }

  public void drawPath() {
    Vector radialVector = new Vector (centerX, centerY, x1, y1);
    float angle = 0, miniInc = 0.01, endAngle = angleBetweenStartAndEnd();
    while (angle <= endAngle) {
      radialVector.plotPoint(black, 2.5);
      radialVector.rotate(miniInc, arcOrientation_isCounterClockwise);
      angle += miniInc;
    }
  }

  public void drawPoints(float endAngle, color c, float size) {
    Vector radialVector = new Vector (centerX, centerY, x1, y1);
    float angle = 0;
    while (angle <= endAngle) {
      radialVector.plotPoint(c, size);
      radialVector.rotate(increment, arcOrientation_isCounterClockwise);
      angle += increment;
    }
  }

  public void drawPoints() {
    drawPoints(angleBetweenStartAndEnd(), orange, PLOT_SIZE);
  }

  public void showPotentialPoints() {
    drawPoints(TAU, blue, 10);
  }

  public void draw() {
    drawPath();
    drawPoints();
  }

  public void addToCanvas() {
    ArrayList<Hole> holesToBeAdded = new ArrayList<>();
    holesToBeAdded.add(initialPoint);
    if (createMode)
      holesToBeAdded.remove(holesToBeAdded.size() - 1);
    Vector radialVector = new Vector (centerX, centerY, x1, y1);
    float angle = increment, endAngle = angleBetweenStartAndEnd(), x, y;
    Hole h;
    while (angle < endAngle) {
      radialVector.rotate(increment, arcOrientation_isCounterClockwise);
      x = radialVector.init.x + radialVector.x;
      y = radialVector.init.y + radialVector.y;
      h = new Hole(x, y);
      if (!isValidLocation(h))
        return;
      holesToBeAdded.add(h);
      angle += increment;
    }
    // This code is only executed if addToCanvas() is successful and there are no errors
    if (!areValidLocations(holesToBeAdded))
      return;
    holes.addAll(holesToBeAdded);
    updateInitialPoint();
    arcCenter = null;
  }
}

boolean showArcTool = false;

void handleArcTool() {
  showArcTool = !showArcTool;
  if (showArcTool)
    startArcTool();
  else
    endArcTool();
}

void startArcTool() {
  setTargetColor(alternateTargetColor2);
  arcCenter = null;
}

void endArcTool() {
  setTargetColor(originalTargetColor);
  if (!createMode)
    resetInitialPoint();
}

Vector arcCenter;

void setArcCenter(Hole h) {
  if (snap) {
    if (abs(h.x - initialPoint.x) < snapThreshold)
      h.x = initialPoint.x;
    if (abs(h.y - initialPoint.y) < snapThreshold)
      h.y = initialPoint.y;
  }
  if (createMode) {
    Vector v = new Vector(initialPoint.x, initialPoint.y, h.x, h.y);
    arcCenter = new Vector (v.init.x + v.x, v.init.y + v.y);
  } else
    arcCenter = new Vector(h.x, h.y);
}

void showArcTool() {
  if (!showArcTool)
    return;
  showArcMessage();
  showArc();
}

void showArcMessage() {
  setTextSize('M');
  showMessage("Arc Tool In Use");
}

float arcToolAngleIncrement = PI/4;

void showArc() {
  float dist;
  if (arcCenter == null) {
    if (initialPoint == null)
      return;
    showInitialPoint();
    float x = mouseX(), y = mouseY();
    if (snap) {
      if (abs(x - initialPoint.x) < snapThreshold)
        x = initialPoint.x;
      if (abs(y - initialPoint.y) < snapThreshold)
        y = initialPoint.y;
    }
    stroke(black);
    dist = lineSegment(initialPoint.x, initialPoint.y, x, y);
    noFill();
    stroke(white);
    circle(mouseX, mouseY, getScaled(dist * 2));
    arcToolAngleIncrement = SPACING / lineSegment(x, y, initialPoint.x, initialPoint.y);
    new Arc(mouseX(), mouseY(), initialPoint.x, initialPoint.y, x, y, arcToolAngleIncrement).showPotentialPoints();
  } else {
    arcCenter.plotPoint(blue);
    stroke(black);
    if (createMode)
      arcToolAngleIncrement = SPACING / lineSegment(arcCenter.x, arcCenter.y, initialPoint.x, initialPoint.y);
    float x = mouseX(), y = mouseY();
    if (snap) {
      if (abs(x - arcCenter.x) < snapThreshold)
        x = arcCenter.x;
      if (abs(y - arcCenter.y) < snapThreshold)
        y = arcCenter.y;
    }
    Vector v = new Vector(arcCenter.x, arcCenter.y, x, y).getToLength(dist(arcCenter.x, arcCenter.y, initialPoint.x, initialPoint.y));
    v.draw(white);
    new Arc(arcCenter.x, arcCenter.y, initialPoint.x, initialPoint.y, x, y, arcToolAngleIncrement).draw();
  }
}

void arcToolAddHole(Hole h) {
  if (initialPoint == null)
    setInitialPoint(h);
  else if (arcCenter == null)
    setArcCenter(h);
  else {
    new Arc(arcCenter.x, arcCenter.y, initialPoint.x, initialPoint.y, mouseX(), mouseY(), arcToolAngleIncrement).addToCanvas();
  }
}
