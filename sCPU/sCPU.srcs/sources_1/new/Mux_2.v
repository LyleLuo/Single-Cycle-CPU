`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/07 14:23:33
// Design Name: 
// Module Name: reg_w_choose
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


module Mux_2(
    input Select,
    input[31:0] in1,
    input[31:0] in2,
    output[31:0] out
    );
    assign out = Select ? in2 : in1;
endmodule
