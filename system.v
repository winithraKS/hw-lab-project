`timescale 1ns / 1ps

module system(
    input wire clk,          // 100MHz on Basys 3
    input wire reset,        // btnC on Basys 3
    input wire [6:0] sw,
    input wire btnU,
    output wire hsync,       // to VGA connector
    output wire vsync,       // to VGA connector
    output wire [11:0] rgb   // to DAC, to VGA connector
    );
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
                       
    reg [6:0] mem;
    reg idx = 1;
    
    // Text Generation Circuit
    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .ascii_char(mem), .rgb(rgb_next));
    
    SinglePulser singlePulser(bU,btnU,clk);
    
    // rgb buffer
    always @(posedge clk) begin
        if(w_p_tick)
            rgb_reg <= rgb_next;
            
        if(bU)
            mem = sw;
    end
            
    // output
    assign rgb = rgb_reg;
      
endmodule