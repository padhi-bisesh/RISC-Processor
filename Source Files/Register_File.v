module Register_File #(parameter W = 32,
parameter W_reg_address = 5) (
    input clk,rst,

    //Addresses
    input [W_reg_address-1:0] A1,A2,A3,

    //Write Enable and data port
    input WE3,
    input [W-1:0] WD3,

    //Read Ports
    output reg [W-1:0] RD1,RD2

);
parameter Total_Register = 2**W_reg_address;
reg [W-1:0] Register_Internal [0:Total_Register];
wire [W-1:0] x0,x1,x2,x3,x4,x5;
assign x0 = Register_Internal[0];
assign x1 = Register_Internal[1];
assign x2 = Register_Internal[2];
assign x3 = Register_Internal[3];
assign x4 = Register_Internal[4];
assign x5 = Register_Internal[5];


//read operation
always @(*) begin
    RD1 = Register_Internal[A1];
    RD2 = Register_Internal[A2];
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
            Register_Internal[0] <= 32'b0;
    end
    else if (WE3) begin
        Register_Internal[A3] <= WD3;
    end
end
endmodule