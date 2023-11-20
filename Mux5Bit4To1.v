`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 04:35:50 PM
// Design Name: 
// Module Name: Mux32Bit3To1
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

module Mux5Bit4To1(out, inA, inB, inC, inD, sel);
input [4:0] inA, inB, inC, inD;
input [1:0] sel;
output reg [4:0] out;

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
