`timescale 1ns / 1ps

module Adder(A, B, Out);
input [31:0]  A, B;
output reg [31:0] Out;

    always@(A, B) begin
        Out <= A + B;
    end

endmodule
