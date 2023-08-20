# HoleMakerUI
HoleMakerUI is a user interface for designing multimode cavities

Important Things:
- __\__settings__\__.json contains canvas specifcations
- Set __filename__ to the name of the design you want to work on
- The 'Designs' folder contains all the designs (that is where HoleMakerUI will look for it)
- If the file exists, HoleMakerUI will read it and you can pick up where you left off
- If it doesn't exist, a new file will be created using the canvas specifcations in __\__settings__\__.json
- --> You MUST press 'u' to update your design file, it will not automatically update it for you <--
- The text file outputted by HoleMakerUI can be used as the input to the __makeHoles()__ function in the __MakeHoles.ipynb__ python notebook which will convert the text file into a 3D cavity using PyInventor

List of Commands
- a = ArcTool
- c = CreateMode
- d = Dimensions (on/off)
- f = FlipOrientation (flips arc orientation while using ArcTool)
- l = LineTool
- q = Quit (does not update design, see 'u')
- r = ResetCanvas
- s = SnapMode
- u = UpdateDesignFile
- x = RemoveTool
- z = Undo (removes the most recently added hole)
