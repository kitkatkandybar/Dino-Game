`timescale 1ns / 1ps

module score(
    input [9:0] vaddress,haddress,
    input clk,halt,reset,
    input [1:0] gs, 
    output reg pixel
    );
    
    reg [189:0] digits [52:0];
    reg [21:0] counter;
    reg [3:0] score [4:0];
    
    initial begin
        score[0] <= 0;
        score[1] <= 0;
        score[2] <= 0;
        score[3] <= 0;
        counter <= 0;
        $readmemb("score.mem", digits);
    end
    
    // Reduce scoring counter speed
    wire counter_clk; 
    clock_divider COUNTER_CLK(.clk(clk), .divided_clk(counter_clk)); 
    
    always @ (posedge counter_clk) begin
        if(gs == 0) begin 
            counter <= 0; 
            score[0] <= 0; 
            score[1] <= 0; 
            score[2] <= 0; 
            score[3] <= 0;
        end 
        if(gs == 2) begin
            counter <= counter; 
            score[0] <= score[0]; 
            score[1] <= score[1]; 
            score[2] <= score[2]; 
            score[3] <= score[3]; 
        end 
        if (gs == 1) begin
        if (score[0] <= 9 && score[1] <= 9 && score[2] <= 9 && score[3] <= 9) begin
        
        if(halt == 0 && gs != 2)begin
            counter <= counter + 1;
            if(counter == 2517500)begin
                score[0] = score[0] + 1;
                counter <= 0;
                if(score[0] == 10)begin
                    score[0] <= 0;
                    score[1] = score[1] + 1;
                end
                if(score[1] == 10)begin
                    score[1] <= 0;
                    score[2] = score[2] + 1;
                end
                if(score[2] == 10)begin
                    score[2] <= 0;
                    score[3] = score[3] + 1;
                end
            end
        end
        end
        end
    end
    
    always@(posedge clk)begin
        pixel <= 0;
        if(vaddress < 480 && haddress < 640) begin
            if(vaddress > 20 && vaddress < 73)begin
                if(haddress > 460 && haddress < 480)begin
                    pixel <= digits[vaddress-21][(haddress-461)+(19*score[3])];
                end
                if(haddress > 482 && haddress < 502)begin
                    pixel <= digits[vaddress-21][(haddress-483)+(19*score[2])];
                end
                if(haddress > 504 && haddress < 524)begin
                    pixel <= digits[vaddress-21][(haddress-505)+(19*score[1])];
                end
                if(haddress > 526 && haddress < 546)begin
                    pixel <= digits[vaddress-21][(haddress-527)+(19*score[0])];
                end
            end
        end
    end
endmodule

