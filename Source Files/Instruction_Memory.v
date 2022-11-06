module Instruction_Memory #(parameter W = 32,
parameter L_IM = 1024) (
    input [W-1:0] A,
    output reg [W-1:0] RD
);
reg [W-1:0] Memory [0:L_IM-1];
initial begin
    $readmemb("fib_loop_final.txt",Memory);
end
always @(*) begin
    RD = Memory[A];
end
endmodule