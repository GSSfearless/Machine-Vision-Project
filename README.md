# Machine-Vision-Project
# Image Processing Application
To operate the Image Processing Application, simply open the ME5405app.mlapp file in MATLAB. Thiswill automatically start the application in a separate window.  Alternatively, the code can be opened inMATLAB App Designer, in which pressing the “Run” button should start the application in a separatewindow.  Then, follow these steps:
1.  Select an image (.txt files only) by pressing the File Browser button, highlighted in orange.
2.  When the image has been selected, the number of columns, number of rows, and the original imageshould appear on screen.  Enter a thresholding level from 0 to 31, a rotation angle, and select therelevant background color.
3.  Select a task to run from the button panel on the left side.
4.  Press the OUTPUT button in the bottom left corner.  An output image should show in the centerof the screen.  If not, an error message will appear in the terminal window at the bottom.
5.  Repeat for any number of tasks, inputs, or image choices.The application can be closed at any time by pressing the X on the top right corner of the applicationwindow.  This will not affect any future application instances.

# Self-Organizing Map 
To  operate  the  self-organizing  map  program,  open  theSOMnet.mfile  within  the  SOM  folder.   Dataused for the context of this report was generated previously and remains within this folder.  Running theprogram can be done as follows:
1.  Run theSOMnet.mfile; the SOM network will train automatically.
2.  To test the result, type “nctool” into the command line, select the training dataset, then select thecharacter to test.
3.  To run the verification on the characters fromcharact1.txt, run theSOMlinkfile, type in “nctool”in the command line, select the training dataset, then select the character to test.
4.  If generation of new data is desired, open and run theload.mfile.
5.  When runningSOMnetand typing in “nctool” in command line, there is one training dataset titled“n”, which contains 75% of the overall provided data.  Six testing datasets, named “n1t”, ”n2t”, ”n3t”,”nat””,  ”nbt”,  and “nct”,  contain in total 25% of the overall data.  Finally,  the six characters fromcharact1.txtfor verification are named ”N1”, “N2”, “N3”, ”NA”, “NB”, and “NC” respectively.
