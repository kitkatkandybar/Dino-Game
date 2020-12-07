`timescale 1ns / 1ps

module top(
    input clk,debug,
    input leftbtn, rightbtn, upbtn, downbtn,
    output hsync,vsync,
    output [3:0] red,green,blue
    );
    
    // Divide clock to 25 Mhz
    wire divided_clk;
    clock_divider VGA_CLK(.clk(clk), .divided_clk(divided_clk)); 
    
    //Initializing internal wires
    wire [10:0] scrolladdr;
    wire [9:0] vaddress,haddress;
    wire [9:0] leftaddr;
    wire [9:0] rightaddr;
    wire [9:0] upaddr;
    wire [9:0] downaddr;
    wire [4:0] random1;
    wire [3:0] color;
    wire button;
    wire runner,reset,score;   
    wire [9:0] xmovaddr0;
    wire [9:0] ymovaddr0;
    wire [9:0] xmovaddr1;
    wire [9:0] ymovaddr1;
    wire [9:0] xmovaddr2;
    wire [9:0] ymovaddr2;
    
    //Initializing internal regs for sprites
    reg [22:0] run1 [46:0];
    reg [22:0] run2 [46:0];
    reg [22:0] death [46:0];
    reg [36:0] asteroid [36:0];
    reg [40:0] fire [40:0];
    
    reg [26:0] cactus1 [46:0];
    reg [26:0] cactus2 [46:0];
    reg [12:0] cactus3 [48:0]; 
    reg [26:0] cactus4 [46:0]; 
    reg [26:0] cactus5 [46:0]; 
    reg [26:0] cactus6 [46:0]; 
    reg [12:0] cactus7 [48:0];
    reg [26:0] cactus8 [46:0];
    reg [26:0] cactus9 [46:0];
    reg [26:0] cactus10 [46:0];
    reg [26:0] cactus11 [46:0];
    reg [26:0] cactus12 [46:0];
    reg [26:0] cactus13 [46:0];
    reg [26:0] cactus14 [46:0];
    reg [12:0] cactus15 [48:0];
    reg [12:0] cactus16 [48:0];
    reg [12:0] cactus17 [48:0];
    
    reg [39:0] game_start [22:0]; 
    reg [39:0] game_over [34:0]; 
    reg [1:0] game_state;
    
    reg [2:0] type;
    reg collide;
    
    //Initializing pixel layers data reg
    reg [4:0] layer;
    reg asteroid_layer;

    
    //Assigning outputs
    assign red = color;
    assign green = color;
    assign blue = color;
    assign color = {4{layer[0]|layer[1]|layer[2]|layer[3]|layer[4]|score|asteroid_layer}};    
    assign reset = collide&(leftbtn|rightbtn|upbtn|downbtn);
    assign button=(leftbtn|rightbtn|upbtn|downbtn);
    
    //Initializing sprite memory from files
    initial begin 
    $readmemb("dino.mem", run1);
    $readmemb("dino2work.mem", run2);
    $readmemb("death.mem",death);
    $readmemb("asteroid.mem",asteroid);
    $readmemb("fire.mem",fire);
    
    $readmemb("cactus.mem", cactus1);
    $readmemb("cactus2.mem", cactus2);
    $readmemb("cactus3.mem", cactus3);
    $readmemb("cactus.mem", cactus4); 
    $readmemb("cactus2.mem", cactus5); 
    $readmemb("cactus.mem", cactus6); 
    $readmemb("cactus3.mem", cactus7); 
    $readmemb("cactus2.mem", cactus8);
    $readmemb("cactus2.mem", cactus9);
    $readmemb("cactus2.mem", cactus10);
    $readmemb("cactus.mem", cactus11);
    $readmemb("cactus.mem", cactus12);
    $readmemb("cactus.mem", cactus13);
    $readmemb("cactus.mem", cactus14);
    $readmemb("cactus3.mem", cactus15);
    $readmemb("cactus3.mem", cactus16);
    $readmemb("cactus3.mem", cactus17);
    
    $readmemb("start.mem", game_start); 
    $readmemb("game_over.mem", game_over);
    collide <= 0; 
    end
       
 
    
    //Initializing all submodules
    movement left_inst(
    .clk(divided_clk),
    .button(leftbtn),
    .gs(game_state), 
    .movaddr(leftaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement right_inst(
    .clk(divided_clk),
    .button(rightbtn),
    .gs(game_state), 
    .movaddr(rightaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement up_inst(
    .clk(divided_clk),
    .button(upbtn),
    .gs(game_state), 
    .movaddr(upaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement down_inst(
    .clk(divided_clk),
    .button(downbtn),
    .gs(game_state), 
    .movaddr(downaddr),
    .halt(collide),
    .reset(reset)
    );
    
    dinosprite dinosprite_inst(
    .clk(divided_clk),
    .sprite(runner)
    );
 
    vga vga_inst(
    .clk(divided_clk),
    .vaddress(vaddress),
    .haddress(haddress),
    .hsync(hsync),
    .vsync(vsync)
    );
    
    rng rng_inst(
    .clk(divided_clk),
    .button(button),
    .random1(random1)
    );
    
    score score_inst(
    .clk(clk),
    .halt(collide),
    .reset(reset),
    .gs(game_state), 
    .vaddress(vaddress),
    .haddress(haddress),
    .pixel(score)
    );
  
       
    always@(posedge divided_clk)begin
        type[0] <= random1[2];
        type[1] <= random1[3];
        type[2] <= random1[4];
    end
     
     asteroid_move first(
         .clk(divided_clk),
    .halt(collide),
    .reset(reset),
    .asteroid_on(1),
    .xmovaddr(xmovaddr0),
    .ymovaddr(ymovaddr0)   
    );
    
    asteroid_move second(
    .clk(divided_clk),
    .halt(collide),
    .reset(reset),
    .asteroid_on(1),
    .xmovaddr(xmovaddr1),
    .ymovaddr(ymovaddr1)   
    );
    
    asteroid_move third(
    .clk(divided_clk),
    .halt(collide),
    .reset(reset),
    .asteroid_on(1),
    .xmovaddr(xmovaddr2),
    .ymovaddr(ymovaddr2)   
    );
    
    //Main block
    always@(posedge divided_clk)begin
        if (game_state == 0) begin 
            if (leftbtn == 1 || rightbtn == 1 || upbtn == 1 || downbtn == 1) begin 
                game_state = 1; 
            end 
            layer <= 5'b0; 
            if (vaddress > 210 && vaddress < 233)begin 
                if(haddress > 300 && haddress < 340)begin 
                    layer[3] <= game_start[vaddress - 210][haddress - 300]; 
                end 
        end 
    end 
        if (game_state == 1) begin 
        collide <= (layer[0]&(layer[1]|layer[3]|layer[4]))|(collide&~(leftbtn|rightbtn|upbtn|downbtn));
        
        layer <= 5'b0; //Set all pixel layers to 0
        
        if(vaddress < 480 && haddress < 640)begin //Check if video address is within scan area
            if((haddress+leftaddr-rightaddr) > 200 && (haddress+leftaddr-rightaddr)  < 223 && (vaddress-downaddr+upaddr) > 200 && (vaddress-downaddr+upaddr) < 247)begin //Check x and y position for printing dinosaur sprite
                //Alternate between running types or death character
            
                if(collide)begin 
                    layer[0] <= death[vaddress-downaddr+upaddr - 200][haddress+leftaddr-rightaddr-200];
                    game_state = 2; 
                end
                else begin
                    if(runner)begin
                        layer[0] <= run1[vaddress-downaddr+upaddr - 200][haddress+leftaddr-rightaddr-200];
                        
                    end
                    
                    else begin
                        layer[0] <= run2[vaddress-downaddr+upaddr - 200][haddress+leftaddr-rightaddr-200];
                    end
                end
            end
            
            if (vaddress > 203 && vaddress < 250)begin 
                if(haddress > 80 && haddress < 107)begin
                    layer[1] <= cactus1[vaddress - 203][haddress - 80];
                end
            end
            if (vaddress > 400 && vaddress < 447)begin
                if(haddress > 300 && haddress < 327)begin
                    layer[1] <= cactus2[vaddress - 400][haddress - 327];
                end
            end
            if (vaddress > 120 && vaddress < 169)begin
                if(haddress > 50 && haddress < 63)begin
                    layer[1] <= cactus3[vaddress - 120][haddress - 50];
                end
            end
            if (vaddress > 50 && vaddress < 97)begin
                if(haddress > 550 && haddress < 557)begin
                    layer[1] <= cactus4[vaddress - 50][haddress - 550];
                end
            end
            if (vaddress > 390 && vaddress < 437)begin
                if(haddress > 590 && haddress < 617)begin
                    layer[1] <= cactus5[vaddress - 390][haddress - 590];
                end
            end
            if (vaddress > 410 && vaddress < 457)begin
                if(haddress > 20 && haddress < 47)begin
                    layer[1] <= cactus6[vaddress - 410][haddress - 20];
                end
            end
            if (vaddress > 240 && vaddress < 289)begin
                if(haddress > 350 && haddress < 363)begin
                    layer[1] <= cactus7[vaddress - 240][haddress - 350];
                end
            end 
            
            
            if (vaddress > 350 && vaddress < 397)begin
                if(haddress > 200 && haddress < 227)begin
                    layer[1] <= cactus8[vaddress - 350][haddress - 200];
                end
            end
            if (vaddress > 150 && vaddress < 197)begin
                if(haddress > 200 && haddress < 247)begin
                    layer[1] <= cactus9[vaddress - 20][haddress - 200];
                end
            end
            if (vaddress > 375 && vaddress < 422)begin
                if(haddress > 530 && haddress < 557)begin
                    layer[1] <= cactus10[vaddress - 375][haddress - 530];
                end
            end
            if (vaddress > 370 && vaddress < 417)begin
                if(haddress > 100 && haddress < 127)begin
                    layer[1] <= cactus11[vaddress - 370][haddress - 100];
                end
            end
            if (vaddress > 200 && vaddress < 247)begin
                if(haddress > 600 && haddress < 627)begin
                    layer[1] <= cactus12[vaddress - 200][haddress - 600];
                end
            end
            if (vaddress > 40 && vaddress < 87)begin
                if(haddress > 310 && haddress < 337)begin
                    layer[1] <= cactus13[vaddress - 40][haddress - 310];
                end
            end
            if (vaddress > 180 && vaddress < 227)begin
                if(haddress > 510 && haddress < 527)begin
                    layer[1] <= cactus14[vaddress - 180][haddress - 510];
                end
            end
            if (vaddress > 240 && vaddress < 289)begin
                if(haddress > 450 && haddress < 463)begin
                    layer[1] <= cactus15[vaddress - 240][haddress - 327];
                end
            end 
            
            end
            end 
            
            if (game_state == 2) begin
                if (debug == 1) begin 
                    game_state = 0;
                end 
                    collide <= 0; 
                    layer <= 5'b0; 
                 if (vaddress > 205 && vaddress < 240)begin 
                 if(haddress > 300 && haddress < 340)begin
                        layer[3] <= game_over[vaddress - 205][haddress - 300];
                 end 
                 end 
            end 
//          
// 
        always@(posedge divided_clk)begin
    if(vaddress < 480 && haddress < 640)begin //Check if video address is within scan area
      asteroid_layer<=0;
        //asteroid 1
        if(type[0])begin 
            if((haddress-xmovaddr0) > 100 && (haddress-xmovaddr0)  < 139 && (vaddress-ymovaddr0) > 100 && (vaddress-ymovaddr0) < 138)begin //Check x and y position for printing asteroid sprite                      
                asteroid_layer <= asteroid[vaddress-ymovaddr0 - 100][haddress-xmovaddr0-100];
                    end
                    
                end
          
        
         //asteroid 2
        if(type[1])begin 
            if((haddress-(3*xmovaddr1)) > 200 && (haddress-(3*xmovaddr1))  < 239 && (vaddress-ymovaddr1) > 100 && (vaddress-ymovaddr1) < 138)begin //Check x and y position for printing asteroid sprite                      
                asteroid_layer <= asteroid[vaddress-ymovaddr1 - 100][haddress-(3*xmovaddr1)-200];
                    end
        end 
           
    //asteroid 3
        
        if(type[2])begin 
            if((haddress-xmovaddr2) > 300 && (haddress-xmovaddr2)  < 339 && (vaddress-ymovaddr2) > 100 && (vaddress-ymovaddr2) < 138)begin //Check x and y position for printing asteroid sprite                      
                asteroid_layer <= asteroid[vaddress-ymovaddr2 - 100][haddress-xmovaddr2-300];
                    end
                    
                end
    end
    
    
    end //end of  if(vaddress < 480 && haddress < 640)
         
           end //End of main always block
endmodule
