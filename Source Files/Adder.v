module Adder #(parameter W = 32) (
    input [W-1:0] I0,I1,
    output [W-1:0] out
);

assign out = I0 + I1;
endmodule