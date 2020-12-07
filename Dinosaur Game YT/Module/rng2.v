
module rng2(
    input clk,reset, button,
    output reg [4:0] random1
    );
    reg [11:0] count1;
    reg [9:0] count2;
    //Set initial values
    initial begin
        random1 <= 5'b1;
         count1<=0;
         count2<=0;
    end
    
    //Main block, generates a pseudo-random output
   
    always@(posedge clk)begin
        if(button)begin //If the jump button is pressed then increment this pseudo-random counter
            
            count1 <= count1+1;
            //counter
            random1[0] <= random1[1]^random1[4];
            random1[1] <= random1[0];
            random1[2] <= random1[1];
            random1[3] <= random1[2];
            random1[4] <= random1[3];
        end
    end
endmodule
