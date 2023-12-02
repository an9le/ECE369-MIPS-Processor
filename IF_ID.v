module IF_ID(InstructionIN, InstructionOUT, PCResultIN, PCResultOUT, Clk, Stall, FlushIFID);

    input Clk, Stall, FlushIFID;
    input [31:0]InstructionIN, PCResultIN;
    output reg [31:0]InstructionOUT, PCResultOUT;

    always@(posedge Clk) begin
        if (Stall) begin
        end
        else if((FlushIFID == 1)) begin
            InstructionOUT <= 0;
            PCResultOUT <= 0;
        end
        else begin
          InstructionOUT <= InstructionIN;
          PCResultOUT <= PCResultIN;
        end
    end

endmodule