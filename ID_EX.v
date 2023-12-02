`timescale 1ns / 1ps

module ID_EX(instructionIN, instructionOUT, readData1IN, readData1OUT, readData2IN, readData2OUT, signExtendIN, signExtendOUT, writeRegisterIN, writeRegisterOUT, PCResultIN, PCResultOUT, rs_IN, rt_IN,
rs_OUT, rt_OUT, RegWriteIN, ALUSrcIN, ALUOpIN, MemWriteIN, MemReadIN, MemToRegIN, jumpALIN, 
RegWriteOUT, ALUSrcOUT, ALUOpOUT, MemWriteOUT, MemReadOUT, MemToRegOUT, jumpALOUT, Clk, FlushIDEX);

// controller inputs
input RegWriteIN, jumpALIN, ALUSrcIN, MemToRegIN, FlushIDEX;
input [1:0] MemReadIN, MemWriteIN;
input [3:0] ALUOpIN;
input [4:0] writeRegisterIN, rt_IN, rs_IN;

// controller outputs
output reg RegWriteOUT, jumpALOUT, ALUSrcOUT, MemToRegOUT;
output reg[1:0] MemReadOUT, MemWriteOUT;
output reg[3:0] ALUOpOUT;
output reg[4:0] writeRegisterOUT, rt_OUT, rs_OUT;

input [31:0] instructionIN;
input [31:0] readData1IN, readData2IN, PCResultIN, signExtendIN;
input Clk;
output reg[31:0] instructionOUT;
output reg[31:0] readData1OUT, readData2OUT, PCResultOUT, signExtendOUT;

always@(posedge Clk) begin
  if (FlushIDEX == 1) begin
        readData1OUT <= 0;
        readData2OUT <= 0;
        PCResultOUT <= 0;
        signExtendOUT <= 0;
        instructionOUT <= 0;
         writeRegisterOUT <= 0;
        rt_OUT <= 0;
        rs_OUT <= 0;
        
        RegWriteOUT <= 0;
        jumpALOUT <= 0;
        ALUSrcOUT <= 0;
        MemToRegOUT <= 0;
        MemReadOUT <= 0;
        MemWriteOUT <= 0;
        ALUOpOUT <= 0;
    end
    else begin
        readData1OUT <= readData1IN;
        readData2OUT <= readData2IN;
        PCResultOUT <= PCResultIN;
        signExtendOUT <= signExtendIN;
        instructionOUT <= instructionIN;
        writeRegisterOUT <= writeRegisterIN;
        rt_OUT <= rt_IN;
        rs_OUT <= rs_IN;
        
        RegWriteOUT <= RegWriteIN;
        jumpALOUT <= jumpALIN;
        ALUSrcOUT <= ALUSrcIN;
        MemToRegOUT <= MemToRegIN;
        MemReadOUT <= MemReadIN;
        MemWriteOUT <= MemWriteIN;
        ALUOpOUT <= ALUOpIN;
    end

end
endmodule
