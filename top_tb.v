
// Percentage Contribution:
// Angel 33%, Wesley 33%, Juan 33%

module top_tb();

reg Clk, Reset;
wire [31:0] writeData; 
wire [31:0] PC;
wire [31:0] displayV0, displayV1;

//top tv(Clk, Reset, writeData, PC);
top tv(Clk, Reset, displayV0, displayV1);

always
begin
    Clk <= 0;
    #200;
    Clk <= 1;
    #200;
end

initial
begin
    Reset <= 1;
    #150;
    Reset <= 0;
    #150;
end

endmodule
