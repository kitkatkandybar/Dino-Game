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
    input[2:0] new_count, //I CHANGED THIS
    output reg [8:0] xmovaddr,
    output reg [9:0] ymovaddr
    );
    
    //Initialize jump y data file
//    reg [6:0] jumping [50:0];
    
    //Initialize internal regs
    reg [17:0] count1;
    reg [2:0] count2; //I CHANGED THIS
    reg count_val = 0;
    //reg bool;
    
    //Initializing regs and loading the y data into memory
    initial begin
       count1<=0;
       count2 <= new_count; //I CHANGED THIS, BUT THIS DOESN'T DO WHAT I HOPED
       xmovaddr <= 0;
        ymovaddr <= 0;
        //bool <= 0;
//        $readmemb("jump.mem", jumping);
    end
    
    //Main block
    always@(posedge clk)begin
        
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
        
        if (xmovaddr == 0 && ymovaddr == 0) begin //I CHANGED THIS
        
            count2 = count2 + 1; //I CHANGED THIS
            if (count2 == 6) begin //I CHANGED THIS
                count2 = 0; //I CHANGED THIS
            end //I CHANGED THIS
            
        
        end
       
        if(reset == 1)begin
            count1 <= 0;
            xmovaddr <= 0;
            ymovaddr <= 0;
        end
        if(halt == 0)begin
        if(asteroid_on==1)begin
                if (count2 == 0) begin //I CHANGED THIS
                count1 <= count1 + 1; //I CHANGED THIS
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+1;
                    ymovaddr <= ymovaddr+1;
                end //I CHANGED THIS
                end
                if (count2 == 1) begin
                count1 <= count1 + 1;
                if(count1 == 251250)begin
                    count1 <= 0;
                    xmovaddr <= xmovaddr+0;
                    ymovaddr <= ymovaddr+3;
                end
                end
                if (count2 == 2) begin //I CHANGED THIS FROM HERE
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
                
                end //TO HERE
            end
               else begin
                xmovaddr <= 0;
                ymovaddr <= 0;
    
                    end
                end
            end

endmodule
 
