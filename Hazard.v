`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 06:55:13 PM
// Design Name: 
// Module Name: Hazard
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

module Hazard(Clk, Stall, StallEX, StallMEM, StallWB, HoldPC, FlushIFID, FlushIDEX, rs_ID, rt_ID, instructionID, writeRegister, writeRegisterEX, writeRegisterMEM, writeRegisterWB, MemRead, MemReadEX, MemReadMEM, RegWrite, RegWriteEX, RegWriteMEM, RegWriteWB, PCSrc, Reset, dataToBeWritten);
    input [31:0] instructionID, dataToBeWritten;
    input [4:0] rs_ID, rt_ID, writeRegister, writeRegisterEX, writeRegisterMEM, writeRegisterWB; 
    input [1:0] MemRead, MemReadEX, MemReadMEM, PCSrc;
    input RegWrite, RegWriteEX, RegWriteMEM, RegWriteWB, Reset, Clk;
    output reg Stall, StallEX, StallMEM, StallWB, HoldPC, FlushIFID, FlushIDEX;

always@(*) begin
  Stall <= 0;
  StallEX <= 0;
  StallMEM <= 0;
  StallWB <= 0;
  HoldPC <= 0;
  FlushIFID <= 0;
  FlushIDEX <= 0;
  
    // Load Word
//    if(((writeRegisterWB == rs_ID) || (writeRegisterWB == rt_ID)) && (MemReadEX) && (writeRegisterWB != 0)) begin
//          Stall <= 1;
//          HoldPC <= 1;
//          FlushIFID <= 0;
//          FlushIDEX <= 1;
//    end
    
    // Regular Stall
    if(((writeRegisterEX == rs_ID) || (writeRegisterEX == rt_ID)) && (RegWriteEX) && (writeRegisterEX != 0)) begin
          StallEX <= 1;
          HoldPC <= 1;
          FlushIFID <= 0;
          FlushIDEX <= 1;
    end
    
    else if(((writeRegisterMEM == rs_ID) || (writeRegisterMEM == rt_ID)) && (RegWriteMEM) && (writeRegisterMEM != 0)) begin
          StallMEM <= 1;
          HoldPC <= 1;
          FlushIFID <= 0;
          FlushIDEX <= 1;
    end
    
    else if(((writeRegisterWB == rs_ID) || (writeRegisterWB == rt_ID)) && (RegWriteWB) && (writeRegisterWB != 0)) begin
          StallWB <= 1;
          HoldPC <= 1;
          FlushIFID <= 0;
          FlushIDEX <= 1;
    end
    
    // Branches and Jumps, if taken
    else if (((PCSrc == 1) || (PCSrc == 2) || (PCSrc == 3))) begin
      Stall <= 0;
      HoldPC <= 0;
      FlushIFID <= 1;
      FlushIDEX <= 0;
    end
    
    else begin
      Stall <= 0;
      StallEX <= 0;
      StallMEM <= 0;
      StallWB <= 0;
      HoldPC <= 0;
      FlushIFID <= 0;
      FlushIDEX <= 0;
    end
             
  end
  
endmodule

//else if(((writeRegisterMEM == rs_ID) || (writeRegisterMEM == rt_ID)) && (RegWriteMEM) && (writeRegisterMEM != 0)) begin
//          Stall <= 1;
//          HoldPC <= 1;
//          FlushIFID <= 0;
//          FlushIDEX <= 1;
//    end
//    else if(((writeRegisterWB == rs_ID) || (writeRegisterWB == rt_ID)) && (RegWriteWB) && (writeRegisterWB != 0)) begin
//          Stall <= 1;
//          HoldPC <= 1;
//          FlushIFID <= 0;
//          FlushIDEX <= 1;
//    end