`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/07 10:31:12
// Design Name: 
// Module Name: insreg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InsRegister(
    input [31:0] IAddr,
    input RW,
    output reg [31:0] ins
    );
    reg[7:0] mem[255:0];
    initial begin
        $readmemb("D:/instruction.txt", mem); 
    end
    
    always@(IAddr or RW) begin
        if (RW) ins = {mem[IAddr], mem[IAddr + 1], mem[IAddr + 2], mem[IAddr + 3]};
    end
    
endmodule
