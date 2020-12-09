`timescale 1ns / 1ps

module clock_divider #(parameter div_value = 1) (
input wire clk, // 100 MHz clock
output reg divided_clk = 0 // 25 MHz clock 
    );
    
// Note that the division value is found as per the equation below
// division_value = 100MHz / (2 * desired_frequency) - 1
// In this case, we have division_value = 100MHz / (2 * 25 Mhz) - 1 = 2 - 1 = 1

integer counter_value = 0; 

always @ (posedge clk) 
begin
    if (counter_value == div_value) 
        counter_value <= 0; 
    else
        counter_value <= counter_value + 1; 
end

// Divide the clock accordingly to 25 MHz
always @ (posedge clk) 
begin 
    if (counter_value == div_value) 
        divided_clk <= ~divided_clk; // flip the signal
end
endmodule
