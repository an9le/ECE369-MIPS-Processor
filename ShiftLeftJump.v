`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 11:35:16 PM
// Design Name: 
// Module Name: ShiftLeftJump
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

module ShiftLeftJump(in, out);
input [25:0] in;
output reg [27:0] out;

    always@(in) begin
        out = in << 2;
    end
    
endmodule
