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
//    reg [255:0] floor [5:0];
//    reg [26:0] cactus1 [46:0];
//    reg [26:0] cactus2 [46:0];
//    reg [12:0] cactus3 [48:0];
//    reg [2:0] select,type;
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
    
    //Initializing sprite memory from files
    initial begin 
    $readmemb("dino.mem", run1);
    $readmemb("dino2work.mem", run2);
    $readmemb("death.mem",death);
    $readmemb("asteroid.mem",asteroid);
    $readmemb("fire.mem",fire);
//    $readmemb("floor.mem", floor);
//    $readmemb("cactus.mem", cactus1);
//    $readmemb("cactus2.mem", cactus2);
//    $readmemb("cactus3.mem", cactus3);
    collide <= 1;
//    select <= 0;
        type<= 0;
    end
       
 
    
    //Initializing all submodules
    movement left_inst(
    .clk(divided_clk),
    .button(leftbtn),
    .movaddr(leftaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement right_inst(
    .clk(divided_clk),
    .button(rightbtn),
    .movaddr(rightaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement up_inst(
    .clk(divided_clk),
    .button(upbtn),
    .movaddr(upaddr),
    .halt(collide),
    .reset(reset)
    );
    
    movement down_inst(
    .clk(divided_clk),
    .button(downbtn),
    .movaddr(downaddr),
    .halt(collide),
    .reset(reset)
    );
    
    dinosprite dinosprite_inst(
    .clk(divided_clk),
    .sprite(runner)
    );
   // scroll scroll_inst(
    //.clk(divided_clk),
   // .pos(scrolladdr[10:0]),
   // .halt(collide),
    //.reset(reset)
   // );
    vga vga_inst(
    .clk(divided_clk),
    .vaddress(vaddress),
    .haddress(haddress),
    .hsync(hsync),
    .vsync(vsync)
    );
    rng rng_inst(
    .clk(divided_clk),
    .button(reset),
    .random1(random1)
    );
    
    score score_inst(
    .clk(clk),
    .halt(collide),
    .reset(reset),
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
        collide <= (layer[0]&(layer[1]|layer[3]|layer[4]))|(collide&~(leftbtn|rightbtn|upbtn|downbtn)); //TODO:Test outside of always block
        if(debug == 1)begin //Collision debug code TODO:remove in final
            collide <= 0;
        end
        layer <= 5'b0; //Set all pixel layers to 0
        if(vaddress < 480 && haddress < 640)begin //Check if video address is within scan area
            if((haddress+leftaddr-rightaddr) > 200 && (haddress+leftaddr-rightaddr)  < 223 && (vaddress-downaddr+upaddr) > 200 && (vaddress-downaddr+upaddr) < 247)begin //Check x and y position for printing dinosaur sprite
                //Alternate between running types or death character
                if(collide)begin 
                    layer[0] <= death[vaddress-downaddr+upaddr - 200][haddress+leftaddr-rightaddr-200];
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
//            if(vaddress > 244 && vaddress < 251) begin //Check the y address for printing floor/ground
//                layer[2] <= floor[vaddress-245][(haddress)+scrolladdr[7:0]];
//            end
//            if (vaddress > 203 && vaddress < 250)begin
//                if(select[0])begin
//                    if(type[0])begin
//                        if((haddress + scrolladdr[9:0]) > 640 && (haddress + scrolladdr[9:0]) < 667)begin //Cactus test
//                            layer[1] <= cactus1[vaddress-203][haddress-640+scrolladdr[9:0]];
//                        end
//                    end
//                    else begin
//                        if((haddress + scrolladdr[9:0]) > 640 && (haddress + scrolladdr[9:0]) < 667)begin //Cactus test
//                            layer[1] <= cactus2[vaddress-203][haddress-640+scrolladdr[9:0]];
//                        end
//                    end
//                end
//                if(select[1])begin
//                    if(type[1])begin
//                        if((haddress + scrolladdr[9:0]-250) > 640 && (haddress + scrolladdr[9:0]-250) < 667)begin //Cactus test
//                            layer[3] <= cactus2[vaddress-203][haddress-640+scrolladdr[9:0]-250];
//                        end
//                    end
//                end
//                if(select[2])begin
//                    if(type[2])begin
//                        if((haddress + scrolladdr[10:0]-450) > 640 && (haddress + scrolladdr[10:0]-450) < 667)begin //Cactus test
//                            layer[4] <= cactus1[vaddress-203][haddress-640+scrolladdr[10:0]-450];
//                        end
//                    end
//                    else begin
//                        if((haddress + scrolladdr[10:0]-450) > 640 && (haddress + scrolladdr[10:0]-450) < 667)begin //Cactus test
//                            layer[4] <= cactus3[vaddress-203][haddress-640+scrolladdr[10:0]-450];
//                        end
//                    end
//                end
//            end
//            if(scrolladdr[9:0]==0)begin
//                select[0] <= 1;
//            end
//            if(scrolladdr[9:0]==250)begin
//                select[1] <= 1;
//            end
//            if(scrolladdr[9:0]==450)begin
//                select[2] <= 1;
//            end
//            if(scrolladdr[9:0] > 667)begin
//                select[0] <= 0;
//            end
//            if(scrolladdr[9:0] > 917)begin
//                select[1] <= 0;
//            end
//            if(scrolladdr[10:0] > 1117)begin
//                select[2] <= 0;
            end
        //end //End of valid scan area
// 
    if(vaddress < 480 && haddress < 640)begin //Check if video address is within scan area
      
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
            
    
    
    end //end of  if(vaddress < 480 && haddress < 640)
         
           end //End of main always block
 
endmodule
