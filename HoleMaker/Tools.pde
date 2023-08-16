
// NOTE: isValidLocation() and areValidLocations() are sub optimal but for relatively small holes.size() it shouldn't affect performance
boolean isInBounds(Hole input) {
  return input.x - PLOT_RADIUS >= 0 && input.x + PLOT_RADIUS <= CANVAS_WIDTH && input.y - PLOT_RADIUS >= 0 && input.y + PLOT_RADIUS <= CANVAS_HEIGHT;
}

boolean isValidLocation(Hole input) {
  // Check For Out Of Bounds
  if (!isInBounds(input)) {
    dispatchOutOfBoundsError();
    return false;
  }
  // Check For Overlap
  for (Hole h : holes)
    if (dist(h.x, h.y, input.x, input.y) < PLOT_DIAMETER) {
      dispatchOverlapError();
      return false;
    }
  return true;
}

boolean areValidLocations(ArrayList<Hole> inputs) {
  for (Hole h : inputs)
    if (!isValidLocation(h))
      return false;
  return true;
}

void addHole(Hole input) { // input is based on target coordinates
  if (createMode && initialPoint == null) {
    for (int i = 0; i < holes.size(); i++)
      if (holes.get(i).mouseInside()) {
        initialPoint = holes.get(i);
        return;
      }
  }
  if (showLineTool)
    lineToolAddHole(input);
  else if (removeHole)
    removeHole();
  else if (showArcTool)
    arcToolAddHole(input);
  else if (isValidLocation(input)) holes.add(input);
}

Hole initialPoint;

void setInitialPoint(Hole h) {
  if (isValidLocation(h))
    initialPoint = h;
}

void updateInitialPoint() {
  if (createMode)
    advanceInitialPoint();
  else
    resetInitialPoint();
}

void advanceInitialPoint() {
  if (holes.size() > 0)
    initialPoint = holes.get(holes.size() - 1);
}

void resetInitialPoint() {
  initialPoint = null;
}

void showInitialPoint() {
  new Vector(initialPoint.x, initialPoint.y).plotPoint(red);
}

void showTools() {
  showArcTool();
  showLineTool();
  showRemoveHoleTool();
  showCreateMode();
  showSnap();
  showErrorMessage();
}

boolean arcOrientation_isCounterClockwise = false;
void flipArcOrientation() {
  arcOrientation_isCounterClockwise = !arcOrientation_isCounterClockwise;
}
