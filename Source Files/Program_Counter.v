module Program_Counter #(parameter W = 32) (
    input clk,rst,
    input [W-1:0] D,
    output reg [W-1:0] Q
);

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        Q <= 0;
    end
    else begin
        Q <= D;
    end
end
endmodule