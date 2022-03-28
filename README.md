# CIU-7-ColorTrackerSound
The seventh of a series of projects for the subject **Creando Interfaces de Usuario** using Processing 3. This one is an ampliation of the last project [ColorTracker](https://github.com/CarlosBritoPerez/CIU-6-ColorTracker).

*Author - Carlos Brito Pérez*

## INDEX
- Introduction
- Implementation
  - States
  - Controls 
- Notes
- References

## Introduction
A simple implementation of a color base tracker with the addition of a music mixer.
## IMPLEMENTATION
### States
- **Intro.** The base state of the program, controls are explained there.
- **Tracker.** The camera will move around the screen depending on where the tacked color is, speed varies based in the distance of the dot from the center of the camera.
- **Stabilizer.** In this case the program will try to keep the tracked color in the middle of the screen by moving the camera around.
- **Mixer.** In this case the program will let you change the volume of the music.
### Controls
- PRESS ENTER to turn START/STOP.
- PRESS TAB to swap between tracker and stabilizer.
- LEFT-CLICK to choose the color to track.

## Notes
I strongly recommed trying this program whitn a solid color background and a good contrast between the colors.
The camera may fail, I don't know the reason, processing seems to not be able to recognize it from time to time.

## REFERENCES
https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P7/README.md
