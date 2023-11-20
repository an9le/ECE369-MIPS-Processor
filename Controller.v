`timescale 1ns / 1ps
module Controller(Instruction, RegWrite, ALUSrc, ALUOp, RegDst, MemWrite, MemRead, MemToReg, jumpAL);

input [31:0] Instruction; 

output reg RegWrite, ALUSrc, MemToReg, jumpAL;
output reg [1:0] RegDst;
output reg [1:0] MemRead; // lw, lh, lb
output reg [1:0] MemWrite; //sw, sh, sb
output reg [3:0] ALUOp;

  always@(Instruction) begin
    RegWrite <= 0; 
    RegDst <= 0;
    ALUSrc <= 0; 
    ALUOp <= 0;
    jumpAL <= 0; 
    MemToReg <= 0; 
    MemRead <= 0;
    MemWrite <= 0;

if (Instruction != 0) begin
casex(Instruction[31:26]) 

// R-type -----------------------------------------------------------------------------
6'b000000 : begin  // jr 
  if (Instruction[5:0] == 6'b001000) begin
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 0;
    ALUOp <= 0;
    RegWrite <= 0;
    RegDst <= 3;
end 

else begin 
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 0;
    ALUOp <= 0;
    RegWrite <= 1;
    RegDst <= 1;
end
end

// I-type ------------------------------------------------------------------------------
6'b001000: begin // addi
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 1;
    RegWrite <= 1;
    RegDst <= 0;
end

6'b001010: begin // slti 
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 2;
    RegWrite <= 1;
    RegDst <= 0;
end

6'b001100: begin // andi
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 3;
    RegWrite <= 1;
    RegDst <= 0;
end

6'b001101: begin // ori
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 4;
    RegWrite <= 1;
    RegDst <= 0;
end

6'b001110: begin // xori
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 5;
    RegWrite <= 1;
    RegDst <= 0; 
end

6'b011100: begin // mul
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 0;
    ALUOp <= 15;
    RegWrite <= 1;
    RegDst <= 1;
end

// jumps -------------------------------------
6'b000010: begin // j 
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 0;
    ALUOp <= 6;
    RegWrite <= 0;
    RegDst <= 3;
end

6'b000011: begin // jal
    jumpAL <= 1;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 0;
    ALUSrc <= 0;
    ALUOp <= 0;
    RegWrite <= 1;
    RegDst <= 2;
end

// loads -------------------------------------
6'b100000: begin // lb
    jumpAL <= 0;
    MemRead <= 3;
    MemToReg <= 1;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 1;
    RegDst <= 0;
end

6'b100001: begin // lh
    jumpAL <= 0;
    MemRead <= 2;
    MemToReg <= 1;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 1;
    RegDst <= 0;
end  

6'b100011 : begin // lw 
    jumpAL <= 0;
    MemRead <= 1;
    MemToReg <= 1;
    MemWrite <= 0;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 1;
    RegDst <= 0;
end

// stores -------------------------------------
6'b101000: begin // sb
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 3;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 0;
    RegDst <= 0;
end

6'b101001: begin // sh
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 2;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 0;
    RegDst <= 0;
end  

6'b101011 : begin // sw 
    jumpAL <= 0;
    MemRead <= 0;
    MemToReg <= 0;
    MemWrite <= 1;
    ALUSrc <= 1;
    ALUOp <= 0;
    RegWrite <= 0;
    RegDst <= 0;
end

//branches ----------------------------------------
6'b000001: begin    // bgez
if(Instruction[20:16] == 6'b00001) begin
 RegWrite <= 0;
 RegDst <= 3;
end
else begin          // bltz
 RegWrite <= 0;
 RegDst <= 3;
end
end

6'b000100 : begin // beq 
 RegWrite <= 0;
 RegDst <= 3;
end

6'b000101: begin // bne
 RegWrite <= 0;
 RegDst <= 3;
end

6'b000111: begin // bgtz
 RegWrite <= 0;
 RegDst <= 3;
end

6'b000110: begin // blez
 RegWrite <= 0;
 RegDst <= 3;
end

default: begin
   jumpAL <= 0;
   MemRead <= 0;
   MemToReg <= 0;
   MemWrite <= 0;
   ALUSrc <= 0;
   ALUOp <= 0;
   RegWrite <= 0;
   RegDst <= 0;
end  

endcase
end

end
endmodule

/*

*/