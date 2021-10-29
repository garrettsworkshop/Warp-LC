`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:27:24 10/29/2021 
// Design Name: 
// Module Name:    WarpLC 
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
module WarpLC(
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input CPU_nAS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input [31:0] FSB_A,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input INt,
	
	(* IOB = "FALSE" *)
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output reg OUTt,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output CPUCLK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output FPUCLK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output RAMCLK0,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output RAMCLK1,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input CPUCLKi,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input CLKIN,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY = "NONE" *)
	input CLKFB_IN,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output CLKFB_OUT);
	
	wire FSBCLK;
	wire CPUCLKr;
	CLKGEN CLKGEN_inst(
		.CLKIN(CLKIN),
		.CLKFB_IN(CLKFB_IN),
		.CLKFB_OUT(CLKFB_OUT),
		.FSBCLK(FSBCLK),
		.CPUCLKr(CPUCLKr),
		.CPUCLK(CPUCLK),
		.FPUCLK(FPUCLK),
		.RAMCLK0(RAMCLK0),
		.RAMCLK1(RAMCLK1));
	
	reg [31:0] AR;
	always @(posedge FSBCLK) begin
		OUTt <= ~CPU_nAS && INt && CPUCLKi && FSB_A[31:0]==AR[31:0];
		AR[31:0] <= FSB_A[31:0];
	end

endmodule
