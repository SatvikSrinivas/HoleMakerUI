
boolean removeHole = false;

void handleRemoveHole() {
  removeHole = !removeHole;
}

void showRemoveHoleTool() {
  if (!removeHole)
    return;
  drawRemoveHoleCursor();
  showRemoveHoleMessage();
}

void drawRemoveHoleCursor() {
  if (!mouseInsideCanvas())
    return;
  hideTarget();
  noFill();
  stroke(red);
  float plotRadius = PLOT_SIZE/2;
  line(mouseX - plotRadius, mouseY - plotRadius, mouseX + plotRadius, mouseY + plotRadius);
  line(mouseX - plotRadius, mouseY + plotRadius, mouseX + plotRadius, mouseY - plotRadius);
}

void showRemoveHoleMessage() {
  setTextSize('M');
  showMessage("Remove Hole Tool In Use");
}

void removeHole() {
  for (int i = 0; i < holes.size(); i++)
    if (holes.get(i).mouseInside()) {
      holes.remove(i);
      break;
    }
}
