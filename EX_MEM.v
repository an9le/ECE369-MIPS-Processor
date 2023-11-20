module EX_MEM(ALUResultIN, ALUResultOUT, readData2IN, readData2OUT, writeRegisterIN, writeRegisterOUT, PCResultIN, PCResultOUT,
RegWriteIN, MemWriteIN, MemReadIN, MemToRegIN, jumpALIN, 
RegWriteOUT, MemWriteOUT, MemReadOUT, MemToRegOUT, jumpALOUT, Clk);  
  
  input [31:0] ALUResultIN, readData2IN, PCResultIN;
  output reg[31:0] ALUResultOUT, readData2OUT, PCResultOUT;
  input [4:0] writeRegisterIN;
  output reg [4:0] writeRegisterOUT;
  input Clk;

// controller inputs
  input RegWriteIN, jumpALIN, MemToRegIN;
  input [1:0] MemReadIN, MemWriteIN;

// controller outputs
  output reg RegWriteOUT, jumpALOUT, MemToRegOUT;
  output reg [1:0] MemReadOUT, MemWriteOUT;

always@(posedge Clk) begin
ALUResultOUT <= ALUResultIN;
readData2OUT <= readData2IN;
writeRegisterOUT <= writeRegisterIN;
PCResultOUT <= PCResultIN;

RegWriteOUT <= RegWriteIN;
jumpALOUT <= jumpALIN;
MemToRegOUT <= MemToRegIN;
MemReadOUT <= MemReadIN;
MemWriteOUT <= MemWriteIN;
end
endmodule