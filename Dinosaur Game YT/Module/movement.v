`timescale 1ns / 1ps

//This script is responsible for generating the movement of the dinosaur.

module movement(
    input clk,button,halt,reset,gs,
    output reg [9:0] movaddr
    );
    
    //Initialize internal regs
    reg [17:0] millisecond;
    reg [8:0] second;
    
    initial begin
        millisecond <= 0;
        second <= 0;
    end
    
    //Main block
    always@(posedge clk)begin
        if (gs == 0)
            movaddr = 0;
        if(reset == 1)begin
            millisecond <= 0;
            second <= 0;
            //bool <= 0;
        end
        if(halt == 0)begin
            if(button == 1)begin
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
        end
    end //end of main block
    
 
endmodule
