`timescale 1ns / 1ps

module top_tb(
    );
    reg clk, button, debug;
    wire [3:0] red, green, blue; 
    
    top dino_game(.clk(clk), .button(button), .debug(debug), .red(red), .green(green), .blue(blue));
    
    initial begin 
    clk = 1;
    button = 0; 
    debug = 0;
    end
    
    // 100 Mhz clk
    always #5 clk = ~clk; 
    
    // Change button state every second
    always #1000_000_000 button = ~button; 
    
    
endmodule
