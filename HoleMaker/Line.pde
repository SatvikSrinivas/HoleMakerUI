
class Line {
  float x1, y1, x2, y2, increment, distance;
  Vector start, direction;

  public void construct(float x1, float y1, float x2, float y2, float increment) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.increment = increment;
    direction = new Vector(x1, y1, x2, y2).unit(); // unit vector specifying the direction of the line
    start = direction.init;
    distance = dist(x1, y1, x2, y2);
  }

  public Line(float x1, float y1, float x2, float y2, float increment) {
    construct(x1, y1, x2, y2, increment);
  }

  public Line(float x1, float y1, float x2, float y2) {
    construct(x1, y1, x2, y2, 0.5); // default constructor assumes increment = 0.5 unless otherwise specified
  }

  public void draw() {
    stroke(white);
    lineSegment(x1, y1, x2, y2);
    for (float l = 0; l <= distance; l += increment)
      start.getDisplacedBy(direction.getToLength(l)).plotPoint(blue, 10);
    showInitialPoint();
  }

  public void addToCanvas() {
    ArrayList<Hole> holesToBeAdded = new ArrayList<>();
    holesToBeAdded.add(initialPoint);
    if (createMode)
      holesToBeAdded.remove(holesToBeAdded.size() - 1);
    Vector v = start;
    Hole h;
    for (float l = increment; l <= distance; l += increment) {
      v = start.getDisplacedBy(direction.getToLength(l));
      h = new Hole(v.x, v.y);
      if (!isValidLocation(h))
        return;
      holesToBeAdded.add(h);
    }
    if (!areValidLocations(holesToBeAdded))
      return;
    // This code is only executed if addToCanvas() is successful and there are no errors
    holes.addAll(holesToBeAdded);
    updateInitialPoint();
  }
}

boolean showLineTool = false;

void handleLineTool() {
  showLineTool = !showLineTool;
  if (showLineTool)
    startLineTool();
  else
    endLineTool();
}

void startLineTool() {
  setTargetColor(alternateTargetColor);
  lineErrorMessage = "";
}

void endLineTool() {
  setTargetColor(originalTargetColor);
  if (!createMode)
    resetInitialPoint();
}

void showLineTool() {
  if (!showLineTool)
    return;
  showLineToolMessage();
  showLine();
}

String lineErrorMessage;

void showLineToolMessage() {
  setTextSize('M');
  String message = "Line Tool In Use";
  if (lineErrorMessage.length() > 0)
    message = lineErrorMessage;
  showMessage(message);
}

void lineToolAddHole(Hole h) {
  if (initialPoint == null)
    setInitialPoint(h);
  else getLine().addToCanvas();
}

void showLine() {
  if (initialPoint == null)
    return;
  getLine().draw();
}

Line getLine() {
  float x = mouseX(), y = mouseY();
  if (snap) {
    if (abs(x - initialPoint.x) < snapThreshold)
      x = initialPoint.x;
    if (abs(y - initialPoint.y) < snapThreshold)
      y = initialPoint.y;
  }
  return new Line(initialPoint.x, initialPoint.y, x, y, SPACING);
}
