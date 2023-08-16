
class Vector {
  float x, y;
  Vector init;

  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Vector(Vector init, float x, float y) {
    this.init = init;
    this.x = x;
    this.y = y;
  }

  public Vector(float x1, float y1, float x2, float y2) {
    init = new Vector(x1, y1);
    this.x = x2-x1;
    this.y = y2-y1;
  }

  public float magnitude() {
    return sqrt(x*x+y*y);
  }

  public Vector unit() {
    return new Vector(init, x / magnitude(), y / magnitude());
  }


  // getScaled returns a vector of length l with the same direction as this Vector object
  public Vector getToLength(float l) {
    Vector u = unit();
    return new Vector(init, u.x * l, u.y * l);
  }

  public void add(Vector v) {
    x += v.x;
    y += v.y;
  }

  public Vector getDisplacedBy(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  public Vector getDisplacedBy(float x, float y) {
    return new Vector(this.x + x, this.y + y);
  }

  public float dot(Vector v) {
    return x * v.x + y * v.y;
  }

  // positive indicates counter clockwise rotation
  public void rotate(float theta) {
    float c = cos(theta), s = sin(theta), temp = x;
    x = c * x - s * y;
    y = s * temp + c * y;
  }

  // direction indicates direction of rotation
  public void rotate(float theta, boolean direction) {
    if (!direction)
      theta *= -1;
    float c = cos(theta), s = sin(theta), temp = x;
    x = c * x - s * y;
    y = s * temp + c * y;
  }

  public boolean isInsideCanvas() {
    return insideCanvas(x, y);
  }

  public void draw() {
    draw(white);
  }

  public void draw(color c) {
    stroke(c);
    lineSegment(init.x, init.y, init.x + x, init.y + y);
  }

  public void plotPoint(color c) {
    if (init == null)
      plot(x, y, c);
    else
      plot(init.x + x, init.y + y, c);
  }

  public void plotPoint(color c, float size) {
    if (init == null)
      plot(x, y, c, size);
    else
      plot(init.x + x, init.y + y, c, size);
  }

  public String toString() {
    return "<"+x+", "+y+">";
  }
}

// returns true if (x,y) is on or above the line that goes through (x1, y1) and (x2, y2)
boolean pointIsAboveLine(float x, float y, float x1, float y1, float x2, float y2) {
  float m = (y2 - y1) / (x2 - x1);
  return y >= (m * (x - x1) + y1);
}
