module RISCDatapath #(parameter W = 32) (
    input clk,rst,
    input PCSrc,
    input [1:0] ResultSrc,
    input MemWrite,
    input [2:0] ALUControl,
    input ALUSrc,
    input [1:0] ImmSrc,
    input RegWrite,

    output [W-1:0] Instr,
    output Zero
);
wire [W-1:0] PCNext;
wire [W-1:0] PCPlus4, PCTarget;
wire [W-1:0] PC;
wire [W-1:0] curr_Instr;
wire [W-1:0] Data1,Data2;
wire [W-1:0] ImmExt;
wire [W-1:0] SrcA,SrcB;
wire [W-1:0] ALUResult;
wire [W-1:0] WriteData;
wire [W-1:0] ReadData;
wire [W-1:0] Result;

assign Instr = curr_Instr;
assign SrcA = Data1;
assign WriteData = Data2;


Mux2to1 M0 (
.sel(PCSrc),
.I0(PCPlus4),
.I1(PCTarget),
.out(PCNext)
);

Program_Counter P0 (
.clk(clk), .rst(rst),
.D(PCNext),
.Q(PC)
);

Instruction_Memory IM0 (
.A(PC),
.RD(curr_Instr)
);

Adder A0 (
.I0(PC),
.I1(1),
.out(PCPlus4)
);

Register_File RF0 (
.clk(clk),
.rst(rst),
.A1(curr_Instr[19:15]),
.A2(curr_Instr[24:20]),
.A3(curr_Instr[11:7]),
.WE3(RegWrite),
.WD3(Result),
.RD1(Data1),
.RD2(Data2)
);

Extend E0 (
.Instr(curr_Instr[31:7]),
.ImmSrc(ImmSrc),
.out(ImmExt)
);

Mux2to1 M1 (
.sel(ALUSrc),
.I0(Data2),
.I1(ImmExt),
.out(SrcB)
);

ALU AL0 (
.IN0(SrcA),
.IN1(SrcB),
.ALUControl(ALUControl),
.Zero(Zero),
.out(ALUResult)
);

Adder A1 (
.I0(PC),
.I1(ImmExt),
.out(PCTarget)
);

Data_Memory DM0 (
.clk(clk),
.A(ALUResult),
.WD(WriteData),
.WE(MemWrite),
.RD(ReadData)
);

Mux3to1 M2 (
.sel(ResultSrc),
.I0(ALUResult),
.I1(ReadData),
.I2(PCPlus4),
.out(Result) 
);
endmodule