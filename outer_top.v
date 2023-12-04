`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Percentage Contribution:
// Angel 33%, Wesley 33%, Juan 33%
// 
// Create Date: 10/28/2023 02:02:16 PM
// Design Name: 
// Module Name: outer_top
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

module outer_top(Reset, Clk, en_out, out7);

    input Reset, Clk;
    output [6:0] out7; 
    output [7:0] en_out; //out7 goes to the 7 seg display
    wire ClkOut;
    wire [31:0] v0, v1;                     // lab 7
//    wire [31:0] writeData, proCount;        // lab 4, 5, 6
        
// LAB 4, 5, 6
//    top tv(ClkOut, Reset, writeData, proCount);
//    Two4DigitDisplay T4D(Clk, proCount[15:0], writeData[15:0], out7, en_out);
//    ClkDiv cd(Clk, 0, ClkOut);   
 
// LAB 7
    top tv(ClkOut, Reset, v0, v1);
    Two4DigitDisplay T4D(Clk, v1[15:0], v0[15:0], out7, en_out);
    ClkDiv cd(Clk, 0, ClkOut); 
endmodule
