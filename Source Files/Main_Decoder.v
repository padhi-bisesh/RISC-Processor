module Main_Decoder #(parameter W = 32) (
    input [6:0] opcode,

    output reg PCUpdate,
    output reg Branch,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg [1:0] ALUOp
);
parameter op_lw = 7'd3;
parameter op_sw = 7'd35;
parameter op_R_type = 7'd51;
parameter op_B_type = 7'd99;
parameter op_jal = 7'd111;
parameter op_addi = 7'd19;

always @(*) begin
    RegWrite = 1'b0;
    ImmSrc = 2'b00;
    ALUSrc = 1'b0;
    MemWrite = 1'b0;
    ResultSrc = 2'b00;
    Branch = 1'b0;
    ALUOp = 2'b00;
    PCUpdate = 1'b0; 
    case(opcode) 
        op_lw : begin 
                    RegWrite = 1'b1;
                    ImmSrc = 2'b00;
                    ALUSrc = 1'b1;
                    MemWrite = 1'b0;
                    ResultSrc = 2'b01;
                    Branch = 1'b0;
                    ALUOp = 2'b00;
                    PCUpdate = 1'b0; 
                end
        op_sw : begin 
                    RegWrite = 1'b0;
                    ImmSrc = 2'b01;
                    ALUSrc = 1'b1;
                    MemWrite = 1'b1;
                    Branch = 1'b0;
                    ALUOp = 2'b00;
                    PCUpdate = 1'b0; 
                end
        op_R_type : begin 
                        RegWrite = 1'b1;
                        ALUSrc = 1'b0;
                        MemWrite = 1'b0;
                        ResultSrc = 2'b00;
                        Branch = 1'b0;
                        ALUOp = 2'b10;
                        PCUpdate = 1'b0; 
                    end
        op_B_type : begin 
                    RegWrite = 1'b0;
                    ImmSrc = 2'b10;
                    ALUSrc = 1'b0;
                    MemWrite = 1'b0;
                    Branch = 1'b1;
                    ALUOp = 2'b01;
                    PCUpdate = 1'b0; 
                end
        op_addi : begin 
                    RegWrite = 1'b1;
                    ImmSrc = 2'b00;
                    ALUSrc = 1'b1;
                    MemWrite = 1'b0;
                    ResultSrc = 2'b00;
                    Branch = 1'b0;
                    ALUOp = 2'b10;
                    PCUpdate = 1'b0; 
                end
        op_jal : begin 
                    RegWrite = 1'b1;
                    ImmSrc = 2'b11;
                    MemWrite = 1'b0;
                    ResultSrc = 2'b10;
                    Branch = 1'b0;
                    PCUpdate = 1'b1; 
                end
    endcase
end
endmodule