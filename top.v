`timescale 1ns / 1ps
//2023-11-30 11:29pm

//module top(Clk, Reset, writeData, PC);        //lab 4, 5, & 6
module top(Clk, Reset, displayV0, displayV1);   //lab 7
input Clk, Reset;
output [31:0] displayV0, displayV1;             //lab 7 
//output [31:0] writeData, PC;                  //lab 4, 5, & 6

// wires in Fetch
(* mark_debug = "true" *)wire [31:0] instruction, address, PCResult, sResult;
(* mark_debug = "true" *)wire HoldPC;


// wires in Decode
(* mark_debug = "true" *)wire [31:0] PCResultID, instructionID, signExtend, shiftLeftSE, addResult, readData1, readData2, nextPC, data, v0, v1;
(* mark_debug = "true" *)wire [27:0] shiftLeftResult;
(* mark_debug = "true" *)wire [4:0] rs_ID, rt_ID, rd_ID, writeRegister;
(* mark_debug = "true" *)wire Stall, FlushIFID, FlushIDEX;
// control signals
(* mark_debug = "true" *)wire ALUSrc, RegWrite, MemToReg, jumpAL;
(* mark_debug = "true" *)wire [3:0] ALUOp;
(* mark_debug = "true" *)wire [1:0] MemRead, MemWrite, RegDst, PCSrc;


// wires in Excute
(* mark_debug = "true" *)wire [31:0] readData1EX, readData2EX, ALUSrcOut, signExtendEX, ALUResult, instructionEX, PCResultEX;
(* mark_debug = "true" *)wire [5:0] ALUControl;
(* mark_debug = "true" *)wire [4:0] rs_EX, rt_EX, writeRegisterEX;
(* mark_debug = "true" *)wire [1:0] Forward1, Forward2, Forward3, Forward4;

// control signals
(* mark_debug = "true" *)wire ALUSrcEX, RegWriteEX, MemToRegEX, jumpALEX;
(* mark_debug = "true" *)wire [3:0] ALUOpEX;
(* mark_debug = "true" *)wire [1:0] MemReadEX, MemWriteEX;


// wires in Memory
(* mark_debug = "true" *)wire [31:0] readData2MEM, ALUResultMEM, dataRead, PCResultMEM, instructionMEM;
(* mark_debug = "true" *)wire [4:0] writeRegisterMEM;
// control signals
(* mark_debug = "true" *)wire RegWriteMEM, MemToRegMEM, jumpALMEM;
(* mark_debug = "true" *)wire [1:0] MemReadMEM, MemWriteMEM;


// wires in WB
(* mark_debug = "true" *)wire [31:0] ALUResultWB, dataReadWB, dataToBeWritten, PCResultWB;
(* mark_debug = "true" *)wire [4:0] writeRegisterWB;
// control signals
(* mark_debug = "true" *)wire RegWriteWB, MemToRegWB, jumpALWB;

// assign writeData = data;        
// assign PC = address;           
assign displayV0 = v0;
assign displayV1 = v1;
assign rs_ID = instructionID[25:21];
assign rt_ID = instructionID[20:16];
assign rd_ID = instructionID[15:11];

// Fetch Stage
Mux32Bit4To1 pcSrc(nextPC, PCResult, {PCResultID[31:28], shiftLeftResult[27:0]}, readData1, addResult, PCSrc);
ProgramCounter pc(nextPC, address, Reset, Clk, HoldPC);
InstructionMemory im(address, instruction, Clk);
Mux32Bit2To1 stallMux(sResult, 4, 0, HoldPC);
Adder pcAdd(address, sResult, PCResult);

// IF/ID
IF_ID ifid(instruction, instructionID, PCResult, PCResultID, Clk, Stall, FlushIFID);

// Decode Stage
Hazard h(Clk, Stall, HoldPC, FlushIFID, FlushIDEX, rs_ID, rt_ID, instructionID, writeRegister, writeRegisterEX, writeRegisterMEM, writeRegisterWB, MemRead, MemReadEX, MemReadMEM, RegWrite, RegWriteEX, RegWriteMEM, RegWriteWB, PCSrc, Reset, dataToBeWritten);
Controller c(instructionID, RegWrite, ALUSrc, ALUOp, RegDst, MemWrite, MemRead, MemToReg, jumpAL);
RegisterFile rf(instructionID[25:21], instructionID[20:16], writeRegisterWB, data, RegWriteWB, Clk, readData1, readData2, v0, v1);
Mux32Bit2To1 jmpAL(data, dataToBeWritten, PCResultWB, jumpALWB);
SignExtension se(instructionID[15:0], signExtend);
ShiftLeftJump sll(instructionID[25:0], shiftLeftResult);
ShiftLeft slse(signExtend, shiftLeftSE);
Adder moreAdd(PCResult, shiftLeftSE, addResult);
Comparator comp(readData1, readData2, PCSrc, instructionID, Clk);
Mux5Bit4To1 rdst(writeRegister, rt_ID, rd_ID, 31, 0, RegDst);

// ID/EX
ID_EX idex(instructionID, instructionEX, readData1, readData1EX, readData2, readData2EX, signExtend, signExtendEX, writeRegister, writeRegisterEX, PCResultID, PCResultEX, rs_ID, rt_ID,
rs_EX, rt_EX, RegWrite, ALUSrc, ALUOp, MemWrite, MemRead, MemToReg, jumpAL,
RegWriteEX, ALUSrcEX, ALUOpEX, MemWriteEX, MemReadEX, MemToRegEX, jumpALEX, Clk, FlushIDEX);

// Execute Stage
Mux32Bit2To1 asrc(ALUSrcOut, readData2EX, signExtendEX, ALUSrcEX);
ALUControl actrl(ALUControl, ALUOpEX, signExtendEX[5:0]);
ALU32Bit alu(ALUControl, readData1EX, ALUSrcOut, signExtendEX, ALUResult);
//Forward for(instructionID, rt_ID, rs_ID, rs_EX, rt_EX, writeRegisterMEM, writeRegisterWB, RegWriteEX, RegWriteMEM, RegWriteWB, MemWriteEX, MemWriteMEM, MemReadEX, MemReadMEM, ALUSrc, Forward1, Forward2, Forward3, Forward4);

// EX/MEM
EX_MEM exmem(ALUResult, ALUResultMEM, readData2EX, readData2MEM, writeRegisterEX, writeRegisterMEM, PCResultEX, PCResultMEM, instructionEX, instructionMEM,
RegWriteEX, MemWriteEX, MemReadEX, MemToRegEX, jumpALEX, 
RegWriteMEM, MemWriteMEM, MemReadMEM, MemToRegMEM, jumpALMEM, Clk);

// Memory Stage
DataMemory dm(ALUResultMEM, readData2MEM, Clk, MemWriteMEM, MemReadMEM, dataRead);
//Mux32BitTo1 f4(Forward4Out, readData2MEM, Forward4);

// MEM/WB
MEM_WB memwb(ALUResultMEM, ALUResultWB, dataRead, dataReadWB, writeRegisterMEM, writeRegisterWB, PCResultMEM, PCResultWB,
RegWriteMEM, MemToRegMEM, jumpALMEM, 
RegWriteWB, MemToRegWB, jumpALWB, Clk);

// Writeback Stage
Mux32Bit2To1 memreg(dataToBeWritten, ALUResultWB, dataReadWB, MemToRegWB);

endmodule