`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/07 22:02:44
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
	input[5:0] op,
    input zero,
    input sign,
    output ExtSel,
	output PCWre,
	output InsMemRW,
	output RegDst,
	output RegWre,
    output ALUSrcA,
    output ALUSrcB,
    output[1:0] PCSrc,
	output[2:0] ALUOp,
	output mRD,
	output mWR,
	output DBDataSrc
    );
    //对指令和ALU的操作码定义常量
    parameter INS_ADD = 6'b000000;
    parameter INS_SUB = 6'b000001;
    parameter INS_ADDIU = 6'b000010;
    parameter INS_ANDI = 6'b010000;
    parameter INS_AND = 6'b010001;
    parameter INS_ORI = 6'b010010;
    parameter INS_OR = 6'b010011;
    parameter INS_SLL = 6'b011000;
    parameter INS_SLTI = 6'b011100;
    parameter INS_SW = 6'b100110;
    parameter INS_LW = 6'b100111;
    parameter INS_BEQ = 6'b110000;
    parameter INS_BNE = 6'b110001;
    parameter INS_BLTZ = 6'b110010;
    parameter INS_J = 6'b111000;
    parameter INS_HALT = 6'b111111;
//    parameter ALU_ADD = 3'b000;
//    parameter ALU_SUB = 3'b001;
//    parameter ALU_SLL = 3'b010;
//    parameter ALU_OR = 3'b011;
//    parameter ALU_AND = 3'b100;
//    parameter ALU_SLTU = 3'b101;
//    parameter ALU_SLT = 3'b110;
//    parameter ALU_XOR = 3'b111;
    assign PCWre = op != INS_HALT;
    assign ALUSrcA = op == INS_SLL;
    assign ALUSrcB = op == INS_ADDIU || op == INS_ANDI|| op == INS_ORI || op == INS_SLTI || op == INS_SW || op == INS_LW;
    assign DBDataSrc = op == INS_LW;
    assign RegWre = op != INS_BEQ && op != INS_BNE && op != INS_BLTZ && op != INS_SW && op != INS_HALT;
    assign InsMemRW = 1;
    assign mRD = op == INS_LW;
    assign mWR = op == INS_SW;
    assign RegDst = op != INS_ADDIU && op != INS_ANDI && op != INS_ORI && op != INS_SLTI && op != INS_LW;
    assign ExtSel = op != INS_ANDI && op != INS_ORI;
    assign PCSrc[0] = op == INS_BEQ && zero == 1 || op == INS_BNE && zero == 0 || op == INS_BLTZ && sign == 1;
    assign PCSrc[1] = op == INS_J;
    assign ALUOp[2] = (op == INS_AND || op == INS_SLTI || op == INS_ANDI || op == INS_BEQ || op == INS_BNE) ? 1 : 0;
    assign ALUOp[1] = (op == INS_SLL || op == INS_OR || op == INS_SLTI || op == INS_ORI || op == INS_BEQ || op == INS_BNE) ? 1 : 0;
    assign ALUOp[0] = (op == INS_SUB || op == INS_OR || op == INS_ORI|| op== INS_BEQ || op == INS_BNE) ? 1 : 0;
endmodule

	
