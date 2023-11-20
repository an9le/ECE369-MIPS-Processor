////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALUControl.v
// Description - Arithmetic Logic Unit control.
//
////////////////////////////////////////////////////////////////////////////////

module ALUControl(ALUControl, ALUOp, Func);

  input [3:0] ALUOp;
  input [5:0] Func;

output reg [5:0] ALUControl;

  wire [9:0] ALUInput;  
  assign ALUInput = {ALUOp, Func};

always@(ALUInput) begin
casex(ALUInput)

  10'b0001xxxxxx: 
    ALUControl <= 6'b000000;  // addi

  10'b0000100000: 
    ALUControl <= 6'b000000;  // case 0: add, lw, lh, lb, sw, sh, sb

  10'b0000100010: 
    ALUControl <= 6'b000001;  // case 1: sub

  10'b1111xxxxxx: 
    ALUControl <= 6'b000010;  // case 2: mul

  10'b0000100100: 
    ALUControl <= 6'b000011;  // case 3: AND 

  10'b0011xxxxxx: 
    ALUControl <= 6'b000011;  // case 3: ANDI

  10'b0000100101: 
    ALUControl <= 6'b000100;  // case 4: OR

  10'b0100xxxxxx: 
    ALUControl <= 6'b000100;  // case 4: ORI

  10'b0000100111: 
    ALUControl <= 6'b000101;  // case 5: NOR

  10'b0000100110: 
    ALUControl <= 6'b000110;  // case 6: XOR 

  10'b0101xxxxxx: 
    ALUControl <= 6'b000110;  // case 6: XORI

  10'b0000000000: 
    ALUControl <= 6'b000111;  // case 7: sll

  10'b0000000010: 
    ALUControl <= 6'b001000;  // case 8: srl

  10'b0000101010: 
    ALUControl <= 6'b001001;  // case 9: slt

  10'b0010xxxxxx: 
    ALUControl <= 6'b001001;  // case 9: slti

//  10'b1000xxxxxx: 
//    ALUControl <= 6'b001010;  // case 10: bgez

//  10'b1001xxxxxx: 
//    ALUControl <= 6'b001011;  // case 11: beq

//  10'b1010xxxxxx: 
//    ALUControl <= 6'b001100;  // case 12: bne

//  10'b1011xxxxxx: 
//    ALUControl <= 6'b001101;  // case 13: bgtz

//  10'b1100xxxxxx: 
//    ALUControl <= 6'b001110;  // case 14: blez
    
//  10'b1101xxxxxx: 
//    ALUControl <= 6'b001111;  // case 15: bltz

  default: 
    ALUControl <= 6'b000000;  // R-Format

endcase
end
endmodule