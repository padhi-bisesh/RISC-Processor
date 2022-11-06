module Mux3to1 #(parameter W = 32) (
    input [1:0] sel,
    input [W-1:0] I0,I1,I2,
    output reg [W-1:0] out
);

always @(*) begin
    out = I0;
    case(sel)
        2'b00 : out = I0;
        2'b01 : out = I1;
        2'b10 : out = I2;
    endcase
end
endmodule