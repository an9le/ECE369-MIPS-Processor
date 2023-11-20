`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Angel Perez
// 
// Create Date: 10/18/2023 08:41:54 PM
// Design Name: 
// Module Name: Comparator
// Project Name: Competition CPU 
// Target Devices: 
// Tool Versions: 
// Description: Resolve all branches in decode. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Comparator(A, B, out, instruction);
  
input [31:0] instruction;
input signed [31:0] A, B; 
output reg [1:0] out;
reg [1:0] result;

  initial begin   
    out <= 0;
  end
  
  always@(*) begin
  result <= 0;  
    case(instruction[31:26])  
    // branches
      6'b000001: begin   
        if(instruction[20:16] == 5'b00001) begin    // bgez
            result <= (A>=B);
        end
        else begin                                  // bltz
            result <= (A<B);
        end
      end

      6'b000100 : begin                             // beq 
        result <= (A==B);
      end

      6'b000101: begin                              // bne
        result <= (A!=B);
      end

      6'b000111: begin                              // bgtz
        result <= (A>B);
      end

      6'b000110: begin                              // blez
        result <= (A<=B);
      end
      
      // jumps -------------------------------------
      6'b000010: begin // j 
        result <= 2;
      end

      6'b000011: begin // jal
        result <= 2;
      end
      
      6'b000000 : begin  // jr 
        if (instruction[5:0] == 6'b001000) begin
            result <= 3;
        end
        else begin
            result <= 0;
        end
      end

      default: begin
        result <= 0; 
      end   

    endcase
    
    if(result == 1) begin // branches
        out <= 3;
    end
    else if(result == 2) begin // j and jal
        out <= 1;
    end   
    else if(result == 3) begin // jr
        out <= 2;
    end    
    else begin 
        out <= 0;             //else
    end
  
end
endmodule