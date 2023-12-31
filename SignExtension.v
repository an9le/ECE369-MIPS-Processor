`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

input[15:0] in;
output[31:0] out;

  assign out = {{16{in[15]}}, in}; // 32 - bits

endmodule
