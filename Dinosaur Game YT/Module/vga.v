`timescale 1ns / 1ps

//This script is responsible for generating the vertical and horizontal addresses and timing pulses

module vga(
    input wire clk,
    input wire reset_btn,
    input btn_press,
    output reg [9:0] vaddress,haddress,
    output reg vsync,hsync
    );
    
    wire reset = reset_btn;
    wire animate;
    wire [11:0] aster_x1, aster_x2, aster_y1, aster_y2;
    
    //Initialize values
    initial begin
        vsync <= 1'b1;
        hsync <= 1'b1;
        vaddress <= 9'b0;
        haddress <= 9'b0;
    end
    
    top #(
        .in_x(160), 
        .in_y(300), 
        .hSize(40)
        ) 
        asteroid(
        .clk(clk), 
        //.i_ani_stb(pixel_strobe),
        .reset(reset),
        .animate(animate),
        .button_pressed(btn_press),
        .is_dino(1),
        .x1(aster_x1),
        .x2(aster_x2),
        .y1(aster_y1),
        .y2(aster_y2)
    );
    
    //Main block, generates vertical and horizontal addresses and timing pulses
    always@(posedge clk)begin
        hsync <= 1'b1;
        haddress <= haddress + 1;
        if(haddress >= 656 && haddress < 752)begin //Generate horizontal sync pulse
            hsync <= 1'b0;
        end
        if(haddress == 800)begin //Reset horizontal counter at end of horizontal scan and add to vertical address
            vsync <= 1'b1;
            haddress <= 9'b0;
            vaddress <= vaddress + 1;
            if(vaddress >= 490 && vaddress < 492)begin //Generate vertical sync pulse
                vsync <= 1'b0;
            end
            if(vaddress == 525)begin //Reset vertical counter at end of scan
                vaddress <= 9'b0;
            end
        end
    end //End of main block
endmodule