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


module asteroid_move (
    input clk,halt,reset,asteroid_on,
    input[2:0] new_count, 
    output reg [8:0] xmovaddr,
    output reg [9:0] ymovaddr
    );
    
    //Initialize Internal Regs
    reg [17:0] count1;
    reg [2:0] count2; 
    reg count_val = 0;
    //reg bool;
    
    //Initializing Regs
    initial begin
        count1<=0;
        count2 <= new_count;
        xmovaddr <= 0;
        ymovaddr <= 0;
    end
    
    //Main block
    always@(posedge clk)begin
        //Sets each asteroid to a specific speed. Only runs at the start of the module.
        if (count2 == 0 && new_count == 0 && count_val == 0) begin 
            count2 = 0; 
            count_val = 1;
        end
        if (count2 == 0 && new_count == 1 && count_val == 0) begin 
            count2 = 1; 
            count_val = 1;
        end
        if (count2 == 0 && new_count == 2 && count_val == 0) begin 
            count2 = 2; 
            count_val = 1;
        end
        if (count2 == 0 && new_count == 3 && count_val == 0) begin 
            count2 = 3; 
            count_val = 1;
        end
        if (count2 == 0 && new_count == 4 && count_val == 0) begin 
            count2 = 4; 
            count_val = 1;
        end
        
        //Increments count2 to change speed each time the asteroid returns to the start position.
        if (xmovaddr == 0 && ymovaddr == 0) begin 
        
            count2 = count2 + 1; 
            if (count2 == 6) begin
                count2 = 0;
            end
        
        end
       
        if(reset == 1)begin
            count1 <= 0;
            xmovaddr <= 0;
            ymovaddr <= 0;
        end
        
        //Changes position of the asteroid. Different speeds based on count2 value.
        if(halt == 0)begin
        if(asteroid_on==1)begin
                if (count2 == 0) begin 
                count1 <= count1 + 1; 
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+1;
                    ymovaddr <= ymovaddr+1;
                end 
                end
                if (count2 == 1) begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+0;
                    ymovaddr <= ymovaddr+3;
                end
                end
                if (count2 == 2) begin 
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+1;
                    ymovaddr <= ymovaddr+2;
                end
                
                end
                if (count2 == 3) begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+2;
                    ymovaddr <= ymovaddr+4;
                end
                
                end
                if (count2 == 4) begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+0;
                    ymovaddr <= ymovaddr+2;
                end
                
                end
                if (count2 == 5) begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+1;
                    ymovaddr <= ymovaddr+2;
                end
                
                end 
                end
               else begin
                xmovaddr <= 0;
                ymovaddr <= 0;
    
                    end
                end
            end

endmodule
 
