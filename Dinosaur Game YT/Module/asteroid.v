`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 04:13:44 PM
// Design Name: 
// Module Name: asteroid
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


module asteroid #(
    h_size = 0,
    in_x = 320,
    in_y = 240,
    in_x_direct = 1,
    in_y_direct = 1,
    width = 640,
    height = 480
    )
    (
    input clk,
    input reset,
    input animate,
    output [11:0] x1, x2, y1, y2
    );
    
    reg [11:0]x = in_x;
    reg [11:0]y = in_y;
    reg x_direct = in_x_direct;
    reg y_direct = in_y_direct;
    
    assign x1 = x - h_size;
    assign x2 = x + h_size;
    assign y1 = y - h_size;
    assign y2 = y + h_size;
    
    always @ (posedge clk) begin
        if (reset) begin
            x <= in_x;
            y <= in_y;
            x_direct = in_x_direct;
            y_direct = in_y_direct;
        end
        if (animate) begin
            x <= (x_direct)? x+1 : x-1;
            y <= (y_direct)? y+1 : y-1;
            
        if (x <= h_size + 1)
            x_direct = 1;
            
        if (y <= h_size +1)
            y_direct = 1;
            
        end
    end    
    
endmodule
