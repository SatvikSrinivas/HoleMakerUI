
boolean snap = false;
void handleSnapping() {
  snap = !snap;
}

float snapThreshold;
void setSnapThrehold(float s) {
  snapThreshold = s;
}

void showSnap() {
  if (!snap)
    return;
  showSnapModeMessage();
}

void showSnapModeMessage() {
  setTextSize('L');
  String modeName = "Snapping Active";
  showMode_topRight(modeName);
}
