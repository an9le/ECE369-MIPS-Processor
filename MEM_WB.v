module MEM_WB(ALUResultIN, ALUResultOUT, dataReadIN, dataReadOUT, writeRegisterIN, writeRegisterOUT, PCResultIN, PCResultOUT,
RegWriteIN, MemToRegIN, jumpALIN, 
RegWriteOUT, MemToRegOUT, jumpALOUT, Clk);

input Clk;
input [31:0] ALUResultIN, dataReadIN, PCResultIN;
input [4:0] writeRegisterIN;
output reg [4:0] writeRegisterOUT;
output reg [31:0] ALUResultOUT, dataReadOUT, PCResultOUT;

  // controller inputs
  input RegWriteIN, jumpALIN, MemToRegIN;

  // controller outputs
  output reg RegWriteOUT, jumpALOUT, MemToRegOUT;

always@(posedge Clk) begin
ALUResultOUT <= ALUResultIN;
dataReadOUT <= dataReadIN;
writeRegisterOUT <= writeRegisterIN;
PCResultOUT <= PCResultIN;

RegWriteOUT <= RegWriteIN;
jumpALOUT <= jumpALIN;
MemToRegOUT <= MemToRegIN;
end
endmodule