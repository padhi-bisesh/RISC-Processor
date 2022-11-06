module Extend #(parameter W = 32,
parameter W_imm = 12) (
    input [1:0] ImmSrc,
    input [31:7] Instr,
    output reg [W-1:0] out 
);
parameter I_type = 2'b00;
parameter S_type = 2'b01;
parameter B_type = 2'b10;
parameter J_type = 2'b11;
always @(*) begin
    out = 0;
    case (ImmSrc)
        I_type : out = { {20{Instr[31]}} , Instr[31:20] };
        S_type : out = { {20{Instr[31]}} , Instr[11:7] , Instr[31:25] };
        B_type : out = { {19{Instr[31]}} , Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
        J_type : out = { {12{Instr[31]}} , Instr[19:12] , Instr[20] , Instr[30:21] , 1'b0};
    endcase
end
endmodule