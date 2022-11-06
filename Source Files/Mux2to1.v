module Mux2to1 #(parameter W = 32) (
    input sel,
    input [W-1:0] I0,I1,
    output [W-1:0] out
);

assign out = sel ? I1 : I0;
endmodule