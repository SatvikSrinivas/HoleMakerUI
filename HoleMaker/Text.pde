
float textSize;

void setTextSize(float size) {
  textSize(textSize = Math.max(size, 30)); // TextSize must be >= 30 at all times (lower bound)
  setFont();
}

float textWidth(String text, float size) {
  setTextSize(size);
  return textWidth(text);
}

PFont font;

void setFont() {
  font = createFont("Arial", textSize, true);
  textFont(font);
}

float textHeight(String text) {
  setFont();
  float minY = Float.MAX_VALUE;
  float maxY = Float.NEGATIVE_INFINITY;
  for (Character c : text.toCharArray()) {
    PShape character = font.getShape(c); // create character vector
    for (int i = 0; i < character.getVertexCount(); i++) {
      minY = min(character.getVertex(i).y, minY);
      maxY = max(character.getVertex(i).y, maxY);
    }
  }
  return maxY - minY;
}

float textHeight(String text, float size) {
  setTextSize(size);
  return textHeight(text);
}

// Need to resolve warning message : 'Need to call beginShape() first'
void drawRotatedText(String text, float x, float y, float angle) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  text(text, 0, 0);
  popMatrix();
}

final char SMALL = 'S', MEDIUM = 'M', LARGE = 'L', HEADER = 'H';

float getTextSize(char c) {
  switch(c) {
  case SMALL:
    return 0.025 * Math.min(getScaled(CANVAS_WIDTH), getScaled(CANVAS_HEIGHT));
  case MEDIUM:
    return 0.05 * Math.min(getScaled(CANVAS_WIDTH), getScaled(CANVAS_HEIGHT));
  case LARGE:
    return 0.075 * Math.min(getScaled(CANVAS_WIDTH), getScaled(CANVAS_HEIGHT));
  case HEADER:
    return 0.1 * displayHeight;
  default:
    println("input = "+c+"\ngetTextSize(char c) ERROR: input must be 'S', 'M', 'L' or 'H' -- CASE-SENSITIVE");
    return -1;
  }
}

void setTextSize(char c) {
  setTextSize(getTextSize(c));
}

float messageY;
void showMessage(String message) {
  float messageX = (displayWidth - textWidth(message))/2.0;
  fill(messageBackground);
  noStroke();
  rect(messageX, messageY - textHeight(message), textWidth(message), textHeight(message));
  fill(black);
  text(message, messageX, messageY);
}

final long DISPATCH_DURATION = 1850;
long diaptchStartTime = -1; // diaptchStartTime is set to -1 as a flag to indicate that there is no errorMessage to display
String dispatchMessage;
color dispatchColor;
void dispatchError(String error) {
  dispatchMessage = "ERROR: "+ error;
  dispatchColor = red;
  diaptchStartTime = System.currentTimeMillis();
}
void dispatchOverlapError() {
  dispatchError("Cannot Add Overlapping Points");
}
void dispatchOutOfBoundsError() {
  dispatchError("All Holes Must Be Added Inside The Canvas");
}
boolean FATAL = false;
void dispatchFatalError(String error) {
  FATAL = true;
  dispatchMessage = "FATAL ERROR: "+ error;
  dispatchColor = red;
  diaptchStartTime = System.currentTimeMillis();
  setTextSize(30);
  showErrorMessage();
}
void dispatchConfirmation(String confirmation) {
  dispatchMessage = confirmation;
  dispatchColor = lightGreen;
  diaptchStartTime = System.currentTimeMillis();
}
void showErrorMessage() {
  if (diaptchStartTime == -1)
    return;
  if (!FATAL && System.currentTimeMillis() - diaptchStartTime > DISPATCH_DURATION)
    diaptchStartTime = -1;
  else {
    float tWidth = textWidth(dispatchMessage), tHeight = textHeight(dispatchMessage), w = 1.2 * tWidth, h = 2 * tHeight,
      messageX = (displayWidth-tWidth)/2.0,
      messageY = (displayHeight-tHeight)/2.0;
    fill(dispatchColor);
    noStroke();
    rect(messageX - (w-tWidth)/2.0, messageY - (h+tHeight)/2.0, w, h);
    fill(black);
    text(dispatchMessage, messageX, messageY);
  }
}

void showMode_topLeft(String mode) {
  float offset = 0.025 * displayHeight, x = offset, y = 2 * offset;
  fill(messageBackground);
  noStroke();
  float rectW = 1.2 * textWidth(mode), rectH = 1.25 * textHeight(mode);
  rect(x, y - textHeight(mode), rectW, rectH);
  fill(black);
  text(mode, x + (rectW - textWidth(mode)) / 2.0, y + (rectH - textHeight(mode)) / 2.0);
}

void showMode_topRight(String mode) {
  float rectW = 1.2 * textWidth(mode), rectH = 1.25 * textHeight(mode);
  float offset = 0.025 * displayHeight, x = displayWidth - offset - rectW, y = 2 * offset;
  fill(messageBackground);
  noStroke();
  rect(x, y - textHeight(mode), rectW, rectH);
  fill(black);
  text(mode, x + (rectW - textWidth(mode)) / 2.0, y + (rectH - textHeight(mode)) / 2.0);
}

float centerX(float start, String input, float totalWidth) {
  return getX(start) + (getScaled(totalWidth) - textWidth(input))/2.0;
}

float centerY(float start, String input, float totalWidth) {
  return getY(start) + (getScaled(totalWidth) + textHeight(input))/2.0;
}
