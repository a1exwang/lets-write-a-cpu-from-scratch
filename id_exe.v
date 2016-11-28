`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:57 11/16/2016 
// Design Name: 
// Module Name:    id_exe 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "defines.v"
module id_exe(
	input iei_clk,
	input iei_rst,
	input iei_en,
	
	input [15:0] iei_instr,
	input [15:0] iei_pc,
	input [7:0] iei_alu_opcode,
	input [15:0] iei_op1,
	input [15:0] iei_op2,
	input [3:0] iei_wreg_addr,
	input [1:0] iei_rwe,
	
	output [15:0] ieo_instr,
	output [15:0] ieo_pc,
	output [7:0] ieo_alu_opcode,
	output [15:0] ieo_op1,
	output [15:0] ieo_op2,
	output [3:0] ieo_wreg_addr,
	output [1:0] ieo_rwe
   );
	
	reg [15:0] instr;
	reg [15:0] pc;
	reg [15:0] op1;
	reg [15:0] op2;
	reg [3:0] wreg_addr;
	reg [1:0] rwe;
	reg [7:0] opcode;
	
	initial begin
		instr = 0;
		pc = 0;
		opcode = 1;
		op1 = 2;
		op2 = 3;
		wreg_addr = `REG_INVALID;
		rwe = 0;
	end

	always @(posedge iei_clk or negedge iei_rst) begin
		if (iei_rst == 0) begin
			instr = 0;
			pc = 0;
			opcode = 0;
			op1 = 0;
			op2 = 0;
			wreg_addr = `REG_INVALID;
			rwe = 0;
		end else begin
			instr = iei_instr;
			pc = iei_pc;
			opcode = iei_alu_opcode;
			op1 = iei_op1;
			op2 = iei_op2;
			wreg_addr = iei_wreg_addr;
			rwe = iei_rwe;
		end
	end
	
	assign ieo_instr = instr;
	assign ieo_pc = pc;
	assign ieo_alu_opcode = opcode;
	assign ieo_op1 = op1;
	assign ieo_op2 = op2;
	assign ieo_wreg_addr = wreg_addr;
	assign ieo_rwe = rwe;

endmodule
