`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:14 10/29/2021 
// Design Name: 
// Module Name:    CLKGEN 
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
module CLKGEN(
	input CLKIN,
	input CLKFB_IN,
	output CLKFB_OUT,
	output FSBCLK,
	output reg CPUCLKr,
	output CPUCLK,
	output FPUCLK,
	output RAMCLK0,
	output RAMCLK1);
	
	CLK instance_name (
		.CLKIN(CLKIN),
		.CLKFB_IN(CLKFB_IN),
		.CLKFB_OUT(CLKFB_OUT),
		.FSBCLK(FSBCLK));
	
	always @(posedge FSBCLK) CPUCLKr <= ~CPUCLKr;
	
	ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(1'b0), .SRTYPE("ASYNC"))
		CPUCLK_inst  (.Q(CPUCLK),		.CE(1'b1),
						  .C0(FSBCLK),		.C1(~FSBCLK),
						  .D0(~CPUCLKr),	.D1(~CPUCLKr),
						  .R(1'b0),			.S(1'b0));
	
	ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(1'b0), .SRTYPE("ASYNC"))
		FPUCLK_inst  (.Q(FPUCLK),		.CE(1'b1),
						  .C0(FSBCLK),		.C1(~FSBCLK),
						  .D0(CPUCLKr),	.D1(CPUCLKr),
						  .R(1'b0),			.S(1'b0));
	
	ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(1'b0), .SRTYPE("ASYNC"))
		RAMCLK0_inst (.Q(RAMCLK0),		.CE(1'b1),
						  .C0(FSBCLK),		.C1(~FSBCLK),
						  .D0(1'b0),		.D1(1'b1),
						  .R(1'b0),			.S(1'b0));
	
	ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(1'b0), .SRTYPE("ASYNC"))
		RAMCLK1_inst (.Q(RAMCLK1),		.CE(1'b1),
						  .C0(FSBCLK),		.C1(~FSBCLK),
						  .D0(1'b0),		.D1(1'b1),
						  .R(1'b0),			.S(1'b0));

endmodule
