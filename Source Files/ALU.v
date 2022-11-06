module ALU #(parameter W = 32) (
    input [W-1:0] IN0,IN1,
    input [2:0] ALUControl,
    output reg [W-1:0] out,
    output reg Zero

);
parameter op_ADD = 3'b000;
parameter op_SUB = 3'b001;
parameter op_OR = 3'b010;
parameter op_AND = 3'b011;
parameter op_SLT = 3'b101;
integer sIN0, sIN1;

always @(*) begin
    sIN0 = IN0;
    sIN1 = IN1;
    Zero = 1'b0;
    case(ALUControl)
        op_ADD : out = IN0 + IN1;
        op_SUB :  begin
            out = IN0-IN1;
            Zero = IN0 == IN1;
        end
        op_OR : out = IN0 | IN1 ;
        op_AND : out = IN0 & IN1 ;
        op_SLT : out = sIN0 < sIN1 ;
    endcase
end
endmodule