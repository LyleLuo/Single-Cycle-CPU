`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/15 19:52:43
// Design Name: 
// Module Name: Hard_CPU
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


module Hard_CPU(
	input[1:0] display_mode,
	input CLK, Reset, Button,
	output[3:0] AN,	//数码管位选择信号
	output[7:0] Out	
);

	wire[31:0] ALU_Out, CurPC, WriteData, Reg1Out, Reg2Out, instcode, newAddress;
	wire myCLK, myReset;
	reg[3:0] store;	//记录当前要显示位的值
	
	CPU cpu(myCLK, myReset, CurPC, newAddress, instcode, Reg1Out, Reg2Out, ALU_Out, WriteData);
	remove_shake remove_shake_clk(CLK, Button, myCLK);
    remove_shake remove_shake_reset(CLK, Reset, myReset);
    clk_slow slowclk(CLK, myReset, AN);
	display show_in_7segment(store, myReset, Out);
	
	always@(myCLK)begin
	   case(AN)
			4'b1110:begin
				case(display_mode)
					2'b00: store <= newAddress[3:0];
					2'b01: store <= Reg1Out[3:0];
					2'b10: store <= Reg2Out[3:0];
					2'b11: store <= WriteData[3:0];
				endcase
			end
			4'b1101:begin
				case(display_mode)
					2'b00: store <= newAddress[7:4];
					2'b01: store <= Reg1Out[7:4];
					2'b10: store <= Reg2Out[7:4];
					2'b11: store <= WriteData[7:4];
				endcase
			end
			4'b1011:begin
				case(display_mode)
					2'b00: store <= CurPC[3:0];
					2'b01: store <= instcode[24:21];
					2'b10: store <= instcode[19:16];
					2'b11: store <= ALU_Out[3:0];
				endcase
			end
			4'b0111:begin
				case(display_mode)
					2'b00: store<= CurPC[7:4];
					2'b01: store <= {3'b000,instcode[25]};
					2'b10: store <= {3'b000,instcode[20]};
					2'b11: store <= ALU_Out[7:4];
				endcase
			end
		endcase
	end
endmodule
