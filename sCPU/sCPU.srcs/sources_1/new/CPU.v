`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/07 10:27:32
// Design Name: 
// Module Name: CPU
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


module CPU(
    input CLK,
	input Reset,
	output[31:0] CurPC, nextAddr, instcode, Reg1Out, Reg2Out, ALU_Out, WriteData
);
	wire ExtSel, PCWre, InsMemRW, RegDst, RegWre, ALUSrcA, ALUSrcB, RD, WR, DBDataSrc, zero, sign;
	wire[2:0] ALUOp;
	wire[1:0] PCSrc;
    wire[4:0] WriteRegAddr;//可添加至output辅助仿真
	wire[31:0] MemOut, Ext_Imm, PC4, InsSrcImm, InsSrc1, InsSrc2, ALU_Input_A, ALU_Input_B;//ALU两个输入可以添加到本模块输出用以检查仿真
	
	PC pc(CLK, Reset, PCWre, nextAddr, CurPC);
	InsRegister insreg(CurPC, InsMemRW, instcode);
	Adder pc4_adder(CurPC, 32'b00000000000000000000000000000100, PC4);
	Mux_2 reg_w_choose(RegDst, instcode[20:16],instcode[15:11], WriteRegAddr);
	RegisterFile regfile(RegWre, CLK, instcode[25:21], instcode[20:16], WriteRegAddr, WriteData, Reg1Out, Reg2Out);
    Extend extend(ExtSel, instcode[15:0], Ext_Imm);
	Mux_2 alua_choose(ALUSrcA, Reg1Out, {27'b000000000000000000000000000,instcode[10:6]}, ALU_Input_A);
    Mux_2 alub_choose(ALUSrcB, Reg2Out, Ext_Imm, ALU_Input_B);
	ALU alu(ALUOp, ALU_Input_A, ALU_Input_B, ALU_Out, zero, sign);
	DataMem datamem(CLK, RD, WR, ALU_Out, Reg2Out, MemOut);
	Mux_2 db_choose(DBDataSrc, ALU_Out, MemOut, WriteData);
    LeftShift_2 after_imm_extend(Ext_Imm, InsSrcImm);
	LeftShift_2 addr_shift({2'b00, PC4[31:28], instcode[25:0]}, InsSrc2);
	Adder next_pc1(InsSrcImm, PC4, InsSrc1);
	Mux_3 nextpc_choose(PCSrc, PC4, InsSrc1, InsSrc2, nextAddr);
	ControlUnit control_unit(instcode[31:26], zero, sign, ExtSel, PCWre, InsMemRW, RegDst, RegWre, ALUSrcA, ALUSrcB, PCSrc, ALUOp, RD, WR, DBDataSrc);
endmodule
