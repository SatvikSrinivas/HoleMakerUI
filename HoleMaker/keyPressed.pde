
void keyPressed() {
  handleTools();
  overrideProcessingExit();
}

void overrideProcessingExit() {
  if (key == ESC)
    key = 0;  // @Override Exit()
}

void handleTools() {
  Hole temp = null;
  switch (key) {
  case 'a':
    if (showLineTool || removeHole) {
      if (initialPoint != null)
        temp = initialPoint.clone(); // save initial point
      if (showLineTool)
        handleLineTool();
      if (removeHole)
        handleRemoveHole();
    }
    handleArcTool();
    if (temp != null)
      initialPoint = temp; // reassign initial point
    break;
  case 'c':
    if (removeHole)
      handleRemoveHole();
    handleCreateMode();
    break;
  case 'd':
    handleDimensions();
    break;
  case 'f':
    if (showArcTool)
      flipArcOrientation();
    break;
  case 'l':
    if (showArcTool || removeHole) {
      if (initialPoint != null)
        temp = initialPoint.clone(); // save initial point
      if (showArcTool)
        handleArcTool();
      if (removeHole)
        handleRemoveHole();
    }
    handleLineTool();
    if (temp != null)
      initialPoint = temp; // reassign initial point
    break;
  case 'q':
    exit();
    break;
  case 'r':
    resetCanvas();
    break;
  case 's':
    handleSnapping();
    break;
  case 'u':
    updateDesign();
    break;
  case 'x':
    if (showArcTool || showLineTool || createMode)
      dispatchError("Remove Hole Tool Cannot Be Used While in Create Mode and/or Using Line/Arc Tool");
    else
      handleRemoveHole();
    break;
  case 'z':
    removeMostRecentlyAddedHole();
    break;
  }
}
