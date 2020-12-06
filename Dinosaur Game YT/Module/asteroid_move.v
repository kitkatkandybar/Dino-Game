`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 05:01:32 PM
// Design Name: 
// Module Name: asteroid_move
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module asteroid_move(
    input clk,halt,reset,asteroid_on,
    output reg [9:0] xmovaddr,
    output reg [9:0] ymovaddr
    );
    
    //Initialize jump y data file
//    reg [6:0] jumping [50:0];
    
    //Initialize internal regs
    reg [17:0] count1;
   
    //reg bool;
    
    //Initializing regs and loading the y data into memory
    initial begin
       count1<=0;
       xmovaddr <= 0;
        ymovaddr <= 0;
        //bool <= 0;
//        $readmemb("jump.mem", jumping);
    end
    
    //Main block
    always@(posedge clk)begin
        if(reset == 1)begin
            count1 <= 0;
            xmovaddr <= 0;
            ymovaddr <= 0;
        end
        if(halt == 0)begin
        if(asteroid_on==1)begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+1;
                    ymovaddr <= ymovaddr+1;
                end
            end
               else begin
                xmovaddr <= 0;
                ymovaddr <= 0;
    
                    end
                end
            end

endmodule
 
