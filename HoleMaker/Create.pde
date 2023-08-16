
boolean createMode = false;

void handleCreateMode() {
  createMode = !createMode;
  initialPoint = null;
  if (createMode)
    enterCreateMode();
  else
    exitCreateMode();
}

void enterCreateMode() {
  if (!showArcTool && !showLineTool)
    handleLineTool(); // starts line tool by default if neither tool is active
}

void exitCreateMode() {
  if (showLineTool)
    handleLineTool();
  if (showArcTool)
    handleArcTool();
}

void showCreateMode() {
  if (!createMode)
    return;
  promptUserForInitialPoint();
  showCreateModeMessage();
}

void promptUserForInitialPoint() {
  if (initialPoint == null) {
    setTextSize('M');
    showMessage("<<< Choose Initial Point >>>");
    highlightPotentialInitialPoint();
  }
}

void highlightPotentialInitialPoint() {
  for (int i = 0; i < holes.size(); i++)
    if (holes.get(i).mouseInside()) {
      holes.get(i).fillColor(orange);
      break;
    }
}

void showCreateModeMessage() {
  setTextSize('L');
  String modeName = "Create Mode";
  showMode_topLeft(modeName);
}
