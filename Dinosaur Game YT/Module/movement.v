`timescale 1ns / 1ps

//This script is responsible for generating the movement of the dinosaur.

module movement(
    input clk,button,halt,reset,gs,
    output reg [9:0] movaddr
    );
    
    //Initialize internal regs
    reg [17:0] millisecond; //register for milliseconds
    reg [8:0] second; //register for one second
    
    initial begin
        millisecond <= 0; //initialize both to zero
        second <= 0;
    end
    
    //Main block
    always@(posedge clk)begin
        if (gs == 0) //resets the dino to starting position when game state is zero (game start)
            movaddr <= 0;
        if(reset == 1)begin //if reset is pushed, reset the counters for seconds and milliseconds
            millisecond <= 0;
            second <= 0;
        end
        if(halt == 0)begin //if the dino does not collide
            if(button == 1)begin //if the input button is being pushed, begin the counter
                millisecond <= millisecond + 1;
                if(millisecond == 251250)begin //increments seconds every 251250 milliseconds
                    millisecond <= 0;
                    second <= second + 1;
                end
                if(second == 1)begin //when seconds equals 1, resets seconds and increments the movaddr
                    second <= 0;
                    
                    movaddr <= movaddr + 1; 
                end
            end
        end
    end //end of main block
    
 
endmodule
