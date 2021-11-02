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
	
	wire FSB_SEL_RAM, FSB_SEL_ROM, FSB_VRAM, FSB_SEL_Cache;
	wire [27:0] FSB_CA;
	CS cs(
		.A(FSB_A),
		.RAMCS(FSB_SEL_RAM),
		.ROMCS(FSB_SEL_ROM),
		.VRAMCS(FSB_VRAM),
		.CacheCS(FSB_SEL_Cache),
		.CA(FSB_CA));
		
	wire [3:0] FSB_B;
	SizeDecode sd (
		.A(FSB_A[1:0]),
		.SIZ(FSB_SIZ[1:0]),
		.B(FSB_B[3:0]));
	
	wire L2PrefetchMatch;
	wire [31:0] L2PrefetchRDD;
	L2Prefetch prefetch (
		.CLK(FSBCLK),
		.CPUCLKr(CPUCLKr),

		.RDA({FSB_A[30], FSB_A[28], FSB_A[25:2]}),
		.RDD(L2PrefetchRDD),
		.Match(L2PrefetchMatch),

		.WRA(28'b0),
		.WRD(32'b0),
		.WR(1'b0),
		.WRM(4'b0),
		.CLR(1'b0));
	
	wire L2CacheMatch;
	wire [31:0] L2CacheRDD;
	L2Cache cache (
		.CLK(CLK), 
		.CPUCLKr(CPUCLKr), 
		
		.RDA({FSB_A[30], FSB_A[28], FSB_A[25:2]}), 
		.RDD(L2CacheRDD), 
		.Match(L2CacheMatch), 
		
		.WRA(28'b0), 
		.WRD(32'b0), 
		.WRM(4'b0), 
		.TS(1'b0), 
		.WR(1'b0), 
		.CLR(1'b0), 
		.ALL(1'b0));

	assign FSB_D[31:0] = L2PrefetchMatch ? L2PrefetchRDD[31:0] :
								L2CacheMatch ? L2CacheRDD[31:0] : 0;
	
	reg STERMEN = 0;
	reg STERM = 0;
	assign CPU_nSTERM = ~((L2PrefetchMatch && STERMEN) || STERM);
		
endmodule



/* Cacheable areas of RAM
 * ...
 * 0x50FFFFFF VRAM alias		0101 0000 1111 11XX XXXX XXXX XXXX XXXX
 * 0x50FC0000
 * 0x50FBFFFF VRAM				0101 0000 1111 10XX XXXX XXXX XXXX XXXX
 * 0x50F80000
 * 0x50F7FFFF VRAM				0101 0000 1111 01XX XXXX XXXX XXXX XXXX
 * 0x50F40000
 * 0x50F3FFFF VRAM alias		0101 0000 1111 00XX XXXX XXXX XXXX XXXX
 * 0x50F00000
 * ...
 * 0x40FFFFFF ROM alias?		0100 0000 111X XXXX XXXX XXXX XXXX XXXX
 * 0x40E00000
 * 0x40DFFFFF ROM					0100 0000 110X XXXX XXXX XXXX XXXX XXXX
 * 0x40C00000
 * 0x40BFFFFF ROM					0100 0000 101X XXXX XXXX XXXX XXXX XXXX
 * 0x40A00000
 * 0x409FFFFF ROM alias?		0100 0000 100X XXXX XXXX XXXX XXXX XXXX
 * 0x40800000
 * 0x407FFFFF ROM alias?		0100 0000 011X XXXX XXXX XXXX XXXX XXXX
 * 0x40600000
 * 0x405FFFFF ROM alias?		0100 0000 010X XXXX XXXX XXXX XXXX XXXX
 * 0x40400000
 * 0x403FFFFF ROM alias?		0100 0000 001X XXXX XXXX XXXX XXXX XXXX
 * 0x40200000
 * 0x401FFFFF ROM alias?		0100 0000 000X XXXX XXXX XXXX XXXX XXXX
 * 0x40000000
 * 0x3FFFFFFF RAM alias?		0011 11XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x3C000000
 * 0x3BFFFFFF RAM alias?		0011 10XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x38000000
 * 0x37FFFFFF RAM alias?		0011 01XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x34000000
 * 0x33FFFFFF RAM alias?		0011 00XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x30000000
 * 0x2FFFFFFF RAM alias?		0010 11XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x2C000000
 * 0x2BFFFFFF RAM alias?		0010 10XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x28000000
 * 0x27FFFFFF RAM alias?		0010 01XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x24000000
 * 0x23FFFFFF RAM alias?		0010 00XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x20000000
 * 0x1FFFFFFF RAM alias?		0001 11XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x1C000000
 * 0x1BFFFFFF RAM alias?		0001 10XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x18000000
 * 0x17FFFFFF RAM alias?		0001 01XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x14000000
 * 0x13FFFFFF RAM alias?		0001 00XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x10000000
 * 0x0FFFFFFF RAM alias?		0000 11XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x0C000000
 * 0x0BFFFFFF RAM alias?		0000 10XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x08000000
 * 0x07FFFFFF RAM alias?		0000 01XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x04000000
 * 0x03FFFFFF RAM (26 bits)	0000 00XX XXXX XXXX XXXX XXXX XXXX XXXX
 * 0x00000000
 */
 