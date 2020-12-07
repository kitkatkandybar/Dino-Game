`timescale 1ns / 1ps

//This script is responsible for generating the height data for the jumping dinosaur

module movement(
    input clk,button,halt,reset,gs,//I CHANGED THIS
    output reg [9:0] movaddr
    );
    
    //Initialize jump y data file
//    reg [6:0] jumping [50:0];
    
    //Initialize internal regs
    reg [17:0] millisecond;
    reg [8:0] second;
    //reg bool;
    
    //Initializing regs and loading the y data into memory
    initial begin
        millisecond <= 0;
        second <= 0;
        //bool <= 0;
//        $readmemb("jump.mem", jumping);
    end
    
    //Main block
    always@(posedge clk)begin
        if (gs == 0) //I CHANGED THIS
            movaddr = 0; //I CHANGED THIS
        if(reset == 1)begin
            millisecond <= 0;
            second <= 0;
            //bool <= 0;
        end
        if(halt == 0)begin
//            if(button == 1 && bool == 0)begin //Check for jump button status
//                bool <= 1;
//            end
            if(button == 1)begin //If the button has been pressed then poll y value from file every 10 milliseconds
                millisecond <= millisecond + 1;
                if(millisecond == 251250)begin
                    millisecond <= 0;
                    second <= second + 1;
                end
                if(second == 1)begin
                    second <= 0;
                    
                    movaddr <= movaddr + 1; 
                end
            end
//            else begin
//                movaddr <= 0;
//            end
            //Assign output to the current line in the y position data file
        end
    end //end of main block
    
 
endmodule