# Dino-Game

### Team 20 (EC311 Logic Design - Fall 2020)
- Ismaeel Alalawi
- Hannah Gold
- Jack Halberian
- Ian McFarlin
- Kakit Wong

## Demo Video
Link:

## Project Overview
### Goals for the Project
The game we created was inspired by the dino game on Google Chrome when the internet goes out. The game utilizes the fundamental concepts taught in the class, and is put into application. The goal of the project is to create an interactive game designed through Vivado which will be pushed onto a FPGA. The project allows indviduals to demonstrate their understanding of key components shown in the labs such as a keyboard input and a VGA display. Members of the project will also show a strong understand of several other topics such as clocks, registers, counters, and etc. Throughout the project members are taught how to collabrate as a team to fulfill the objects that were assigned. 

### Objective of the Game
The objective of the game is to survive as long as possible avoiding any obsticales and objects that comes in the way of the dino. The dino will move in 1 direction until a new arrow key is pressed. The dino will continue moving until the game is lost. 

## Game Usage and Installation
### Required Material
- FPGA
- VGA Cable
- Monitor
- Keyboard
- Vivado 2020.2

### Download Dino Game
Go to the GitHub repository for Dino Game. Click on the green "Code" button towards the right side of the screen. Press "Download Zip" under the green button. Go to where the file is stored and extract the zip file. 

### Running the Game
1. Open Vivado 2020.2
2. Create a new project
3. Select FPGA board
4. Go to Files
5. Add Sources
6. Select Add or Create Design Source
7. Press next and select Add files
8. Import the module files and memory files downloaded from the GitHub and press finish
9. Repeat steps 4 and 5
10. Select Add or Create Constraints
11. Import constraint files downloaded from Github and press finish
12. Run synthesis process
13. Run implementation process
14. Generate the bitstream
15. Select Program Device
16. Connect the keyboard and monitor to the FPGA
17. Press the arrow keys to begin
18. ENJOY THE GAME!

## Overview of Code Structure
### Extinction Module

### Top Module

### Keyboard Module

### Asteroid Move Module

### Clock Divider Module

### VGA Module

### Dinosprite Module

### Movement Module

### Score Module

## Future Goals and Improvements
### Improvements
- Add border to the screen
- Adjust display so dino doesn't disappear after 250 score
- Adjust asteroid and cactus collision to display fire sprite
- Adjust asteroid animation
- Adjust randomization of asteroid generation
- Adjust score overflow

### Additions
- Randomize cactus generation per round
- Increase difficulty as game continues 
- Add boss battles
- Add power ups 
- Add background music when playing
- Add pause screen
- Add multiplayer mode


