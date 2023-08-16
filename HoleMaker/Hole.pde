
Hole info = null;
int infoID = -1;
void showInfo() {
  if (info == null)
    return;
  fill(white);
  String num = ""+infoID;
  setTextSize('L');
  text(num, getX(info.x) - 1.25 * textWidth(num), getY(info.y));
  info.showDetails();
  info = null; // reset for next render
}

class Hole {

  float x, y;

  public Hole(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public boolean mouseInside() {
    return getScaled(dist(x, y, mouseX(), mouseY())) < PLOT_SIZE/2.0;
  }

  public boolean showID() {
    if (info != null)
      return false;
    if (mouseInside()) {
      hideTarget();
      info = this;
      return true;
    }
    info = null;
    infoID = -1;
    return false;
  }

  public void showDetails() {
    fill(black);
    setTextSize(0.05 * Math.min(getScaled(CANVAS_WIDTH), getScaled(CANVAS_HEIGHT)));
    text(toString(), getX(x), getY(y));
  }

  public void fillColor(color c) {
    plot(x, y, c);
  }

  public boolean sharesCoordinatesWith(Hole h) {
    return h != null && x == h.x && y == h.y;
  }

  public void draw(int id, color c) {
    fillColor(c);
    if (this.sharesCoordinatesWith(initialPoint))
      showInitialPoint(); // pertains to Line and Circle Tools
    if (showID())
      infoID = id;
  }

  public void draw(int id) {
    draw(id, holeColor);
  }

  public String toString() {
    return "("+roundToHundredth(x)+", "+roundToHundredth(y)+")";
  }

  public String data() {
    return roundToHundredth(x)+", "+roundToHundredth(y);
  }

  public Hole clone() {
    return new Hole(x, y);
  }
}

ArrayList<Hole> holes;

void setupHoles() {
  holes = new ArrayList<Hole>();
}

void drawHoles() {
  showTarget();
  for (int i = 0; i < holes.size(); i++)
    holes.get(i).draw(i + 1);
}

void removeMostRecentlyAddedHole() {
  if (holes.size() > 0)
    holes.remove(holes.size()-1);
}
