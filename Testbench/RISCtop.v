module RISCtop;
reg clk,rst;
parameter W = 32;
wire [W-1:0] Instr;
wire Zero;

wire PCSrc;
wire [1:0] ResultSrc;
wire MemWrite;
wire [2:0] ALUControl;
wire ALUSrc;
wire [1:0] ImmSrc;
wire RegWrite;

RISCControlpath DUT0(
    .Instr(Instr),
    .Zero(Zero),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite)
);

RISCDatapath DUT1(
    .clk(clk),
    .rst(rst),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .Instr(Instr),
    .Zero(Zero)
);

initial begin 
    clk = 1'b1;
    rst = 1'b1;
end

always #5 clk = ~clk; 

initial begin
    $dumpfile("RISCtopfinal.vcd");
    $dumpvars(0,RISCtop);

    #1 rst = 1'b0;
    #1 rst = 1'b1; 
    #1498 $finish;
end

endmodule