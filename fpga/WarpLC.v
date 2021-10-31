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
	input [1:0] FSB_SIZ,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "8" *)
	(* SLEW = "SLOW" *)
	output [31:0] FSB_D,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLEW = "FAST" *)
	output CPU_nSTERM,
	
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
	ClkGen cg (
		.CLKIN(CLKIN),
		.CLKFB_IN(CLKFB_IN),
		.CLKFB_OUT(CLKFB_OUT),
		.FSBCLK(FSBCLK),
		.CPUCLKr(CPUCLKr),
		.CPUCLK(CPUCLK),
		.FPUCLK(FPUCLK),
		.RAMCLK0(RAMCLK0),
		.RAMCLK1(RAMCLK1));
		
	wire [3:0] FSB_B;
	SizeDecode sd (
		.A(FSB_A[1:0]),
		.SIZ(FSB_SIZ[1:0]),
		.B(FSB_B[3:0]));
	
	wire L2PrefetchMatch;
	L2Prefetch l2pre (
		.CLK(FSBCLK),
		.CPUCLKr(CPUCLKr),

		.RDA(FSB_A[28:2]),
		.RDD(FSB_D[31:0]),
		.Match(L2PrefetchMatch),

		.WRA(27'b0),
		.WRD(32'b0),
		.WR(1'b0),
		.WRM(4'b0),
		.CLR(1'b0));
	
	assign CPU_nSTERM = ~(L2PrefetchMatch);
		
endmodule
