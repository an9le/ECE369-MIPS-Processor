module Forward(instructionID, rt_ID, rs_ID, rs_EX, rt_EX, writeRegisterMEM, writeRegisterWB, RegWriteEX, RegWriteMEM, RegWriteWB, MemWriteEX, MemWriteMEM, MemReadEX, MemReadMEM, 
ALUSrc, Forward1, Forward2, Forward3, Forward4);
input [31:0] instructionID;
input [4:0] rt_ID, rs_ID, rs_EX, rt_EX, writeRegisterMEM, writeRegisterWB;
input [1:0] MemWriteEX, MemWriteMEM, MemReadEX, MemReadMEM;
input RegWriteEX, RegWriteMEM, RegWriteWB, ALUSrc;

output reg [1:0] Forward1, Forward2, Forward3, Forward4;

initial begin
    Forward1 <= 0;
    Forward2 <= 0;
    Forward3 <= 0;
    Forward4 <= 0;
end

always@(*) begin

    // Forwarding from Mem to ALU input A
    if ((RegWriteMEM == 1) && (writeRegisterMEM != 0) && (writeRegisterMEM == rs_EX)) begin
        Forward1 <= 2;
    end
    // Forwarding from Wb to ALU input A
    else if ((RegWriteWB == 1) && (writeRegisterWB != 0) && (writeRegisterWB == rs_EX))begin
        Forward1 <= 1;
    end
    else begin
        Forward1 <= 0;
    end

    // Forwarding from Mem to ALU input B
    if ((RegWriteMEM == 1) && (writeRegisterMEM != 0) && (writeRegisterMEM == rt_EX) && (ALUSrc == 0)) begin
        Forward2 <= 2;
    end
    // Forwarding from Wb to ALU input B
    else if ((RegWriteWB == 1) && (writeRegisterWB != 0) && (writeRegisterWB == rt_EX) && (ALUSrc == 0)) begin
        Forward2 <= 1;
    end
    else begin
        Forward2 <= 0; 
    end

    // Forwarding from Wb to Ex WriteData
    if ((MemWriteEX == 1) && (writeRegisterWB != 0) && (writeRegisterWB == rt_EX) && (RegWriteWB)) begin
        Forward3 <= 1;
    end
    else begin
        Forward3 <= 0;
    end
    
    // Forwarding from Wb to Mem WriteData
    if ((MemWriteMEM == 1) && (writeRegisterWB != 0) && (writeRegisterWB == writeRegisterMEM) && (RegWriteWB)) begin
        Forward4 <= 1;
    end
    else begin
        Forward4 <= 0; 
    end  

    end
endmodule