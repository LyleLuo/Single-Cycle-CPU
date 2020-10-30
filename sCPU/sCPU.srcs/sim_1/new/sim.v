`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/11 22:37:54
// Design Name: 
// Module Name: sim
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


module sim;
    reg CLK;
    reg Reset;
    wire[31:0] CurPC, nextAddr, instcode, Reg1Out, Reg2Out, ALU_Out, WriteData;
    CPU singleCPU(CLK, Reset, CurPC, nextAddr, instcode, Reg1Out, Reg2Out, ALU_Out, WriteData);
    initial begin
        CLK = 1;
        Reset = 0;
        #1;
        Reset = 1;
        forever #50 CLK = !CLK;
    end
endmodule
