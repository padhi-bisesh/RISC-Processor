module RISCControlpath #(parameter W = 32) (
    input [W-1:0] Instr,
    input Zero,

    output PCSrc,
    output [1:0] ResultSrc,
    output MemWrite,
    output [2:0] ALUControl,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite
);

wire PCUpdate,Branch;
wire [1:0] ALUOp;
wire out_and1,out_and2;


wire [6:0] op;
wire [2:0] funct3;
wire funct7;

assign op = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7 = Instr[30];

Main_Decoder I0 (
.opcode(op),
.PCUpdate(PCUpdate),
.Branch(Branch),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.ALUOp(ALUOp)
);

ALU_Decoder U0 (
.ALUOp(ALUOp),
.op(op[5]),
.funct3(funct3),
.funct7(funct7),
.ALUControl(ALUControl)
);

and (out_and1,Zero,Branch,~funct3[0]);
and (out_and2,~Zero,Branch,funct3[0]);
or (PCSrc,out_and1,out_and2,PCUpdate);
endmodule