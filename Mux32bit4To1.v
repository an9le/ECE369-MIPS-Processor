`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 10:06:21 PM
// Design Name: 
// Module Name: Mux32bit4To1
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


module Mux32Bit4To1(out, inA, inB, inC, inD, sel);
input [31:0] inA, inB, inC, inD;
input [1:0] sel;
output reg [31:0] out;

//initial begin   
// out <= 0;
//end

always@(*) begin
if (sel == 0) begin
out <= inA;
end
else if (sel == 1) begin
out <= inB;
end
else if (sel == 2) begin
out <= inC;
end
else begin
out <= inD;
end
end
endmodule
