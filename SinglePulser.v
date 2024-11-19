`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:15:04 PM
// Design Name: 
// Module Name: SinglePulser
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


module SinglePulser(
    output reg out,
    input in,
    input clk
    );
    
    reg state;
    initial state = 0;
    always @(posedge clk) 
    begin
        case({in,state})
            2'b00 : 
                begin
                    state = 0;
                    out = 0;
                end
            2'b10 : 
                begin
                    state = 1;
                    out = 1;
                end
            2'b01 : 
                begin
                    state = 0;
                    out = 0;
                end
            2'b11 : 
                begin
                    state = 1;   
                    out = 0;
                end    
            endcase
        end
endmodule
