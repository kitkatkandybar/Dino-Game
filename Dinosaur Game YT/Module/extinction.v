`timescale 1ns / 1ps
module extinction(
    input clk,debug, ps2_clk, ps2_data,
    output hsync,vsync,
    output [3:0] red,green,blue
    );
    
    wire [3:0] BUTTON;
   
    
    Keyboard GAME_KEYBOARD (
							.CLK(clk),
							.PS2_CLK(ps2_clk), 
							.PS2_DATA(ps2_data),
							.BUTTON(BUTTON)
							);
    
    top GAME (
                .clk(clk) ,.debug(debug),
                .leftbtn(BUTTON[0]), .rightbtn(BUTTON[1]), 
                .upbtn(BUTTON[3]), .downbtn(BUTTON[2]),
                .hsync(hsync),.vsync(vsync),
                .red(red),.green(green),.blue(blue)
              );
    
endmodule
