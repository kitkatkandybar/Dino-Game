Project Name: Extinction
Team Name: Flying Spaghetti Monster
Team Number: 20
Team Members: Hannah Gold, Ian McFarlin, Ismaeel Alalawi, Jack Halberian, Kakit Wong
Project Demo Video Link:

Overview of the Project:
Interactive game designed on Vivado using a FPGA, keyboard, and monitor to run. The game consist of a 
Dino that runs around avoiding any objects on the map. The project demonstrates member's understanding 
of several concepts taught within the class such as registers, counters, clocks, finite state machines, 
and etc. The project develops each individual's ability to collabrate and meet criterias that were assigned.

How to run your project:
In order to run the project a Basys3 or a Nexys4 FPGA board is required along with the Vivado software, a 
keyboard, VGA cable, and a monitor. First download the files of the project into Vivado. Open the project. 
Set the top module as top. Run a synthesis. Then run an implementation of the module. Next generate the 
bitstream. After the bitstream is full generated open target. Program device. Then the project will boot on the 
monitor. In order to begin press one of the directional keys on the keyboard. Play the game. After death there will 
be a game over screen. Press any directional keys to play again.

Overview of the code structure:
The code consist of 1 module called extinction that wraps around the top module and the keyboard module. The 
keyboard module consists of the code to have keyboard inputs. The most inportant module within the project is 
the top module. The top module instantiates several other modules such as asteroid move, clock divider, dinosprite, 
movement, score, and vga. All of these other modules consist of its individual code thats called upon the top module. 
The top module also includes a main block after instantiating the other modules.

Link to the Github: https://github.com/kitkatkandybar/Dino-Game 
