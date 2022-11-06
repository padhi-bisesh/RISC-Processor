module Data_Memory #(parameter W = 32,
parameter L_DM = 8192) (
    input clk,

    //Addresses
    input [W-1:0] A,

    //Write signals
    input [W-1:0] WD,
    input WE,

    //read port
    output reg [W-1:0] RD

);
reg [W-1:0] Memory [0:L_DM];
wire [W-1:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg20;

assign reg0 = Memory[0];
assign reg1 = Memory[1];
assign reg2 = Memory[2];
assign reg3 = Memory[3];
assign reg4 = Memory[4];
assign reg5 = Memory[5];
assign reg6 = Memory[6];
assign reg7 = Memory[7];
assign reg8 = Memory[8];
assign reg9 = Memory[9];
assign reg20 = Memory[20];



always @(*) begin
    
    RD = Memory[A];
end

always @(posedge clk) begin
    if (WE) begin
        //Memory[1] = 0;
        Memory[A] = WD;
    end
end
endmodule