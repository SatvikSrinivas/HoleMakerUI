
JSONObject settings;

void loadSettings() {
  settings = loadJSONObject("__settings__.json");
  if (setFilename(settings.getString("filename"))) { // file exists
    String[] lines = loadStrings(filename);
    String[] vars = lines[0].split(", ");
    if (vars.length < 4)
      dispatchFatalError("Cannot Find Canvas Specifications in \""+filename+"\"");
    else
      canvasSetup(Float.parseFloat(vars[0]), Float.parseFloat(vars[1]), Float.parseFloat(vars[2]), Float.parseFloat(vars[3]));
  } else { // new file
    canvasSetup(settings.getFloat("canvasWidth"), settings.getFloat("canvasHeight"), settings.getFloat("plotDiameter"), settings.getFloat("spacing"));
    if (!FATAL) {
      prepareFile(); // Creates file since it wasn't found
      design.close();
      dispatchConfirmation("\""+filename + "\" Created Sucessfully");
    }
  }
  establishView();
}

String filename;
boolean setFilename(String f) {
  filename = "Designs/"+f;
  return loadFile();
}

boolean loadFile() {
  setupHoles();
  try {
    String[] lines = loadStrings(filename);
    String[] data;
    // start at i = 1 -- as first line contains canvas specifications
    for (int i = 1; i < lines.length; i++) {
      data = lines[i].split(", ");
      holes.add(new Hole(Float.parseFloat(data[0]), Float.parseFloat(data[1])));
    }
    dispatchConfirmation("\""+filename + "\" Loaded Succesfully");
    return true;  // file exists
  }
  catch (Exception e) {
    return false; // file must be created
  }
}

PrintWriter design;

void updateDesign() {
  prepareFile();
  for (Hole h : holes)
    design.println(h.data());
  design.close();
  dispatchConfirmation("\""+filename + "\" Updated Sucessfully");
}

// This function requires canvas specifications to be set up prior to this call
void prepareFile() {
  design = createWriter(filename);
  design.println(""+CANVAS_WIDTH + ", "+CANVAS_HEIGHT+", "+PLOT_DIAMETER+", "+SPACING);
}
