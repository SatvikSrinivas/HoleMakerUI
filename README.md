# HoleMakerUI
HoleMakerUI is a user interface for designing multimode cavities.

Important Things:
- ____settings____.json contains canvas specifcations you can set as specify a design file name
- The 'Designs' folder contains all the designs (that is where HoleMakerUI will look for it)
- If the file exists, HoleMakerUI will read it and you can pick up where you left off. If it doesn't exist, a new file will be created using the canvas specifcations in ____settings____.json
- --> You MUST press 'u' to update your design file, it will not automatically update it for you <--
- The text file outputted by HoleMakerUI can be used as the input to the __makeHoles()__ function in the __MakeHoles.ipynb__ python notebook which will convert the text file into a 3D cavity using PyInventor.

List of Commands
- a = ArcTool
- c = CreateMode
- d = Dimensions (on/off)
- f = FlipOrientation (ArcTool)
- l = LineTool
- r = ResetCanvas
- s = SnapMode
- u = UpdateDesignFile
- x = RemoveTool
- z = Undo
