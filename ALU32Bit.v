`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, C, ALUResult);

  input [5:0] ALUControl; // control bits for ALU operation
  input /*signed*/ [31:0] A, B, C;	    // inputs

  output reg[31:0] ALUResult;

  always@(ALUControl, A, B, C) begin
  ALUResult <= 0;
    case(ALUControl)
    0: begin //add & addi & lw & sw & j & jr & jal
    ALUResult <= A+B; 
    end
    1: begin //sub
    ALUResult <= A-B; 
    end
    2: begin //mul
    ALUResult <= A*B; 
    end
    3: begin //and & andi
    ALUResult <= (A&B);
    end
    4: begin //or & ori
    ALUResult <= (A|B);
    end
    5: begin //nor
    ALUResult <= ~(A|B);
    end
    6: begin //xor & xori
    ALUResult <= (A^B); 
    end
    7: begin //sll
    if (C > 63) begin // if statement to account for hard coded values, which would fail otherwise and break the jump
    ALUResult <= B<<C[10:6];
    end
    else begin
    ALUResult <= B<<C;
    end
    end
    8: begin //srl
    ALUResult <= B>>C[10:6];
    end
    9: begin //slt & slti
    ALUResult <= (A<B);    
    end

    default: begin
    ALUResult <= A+B;
    end

endcase
end

endmodule

