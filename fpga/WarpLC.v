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
	(* DRIVE = "2" *)
	(* IOBDELAY ="NONE" *)
	inout [2:0] FSB_FC,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	(* IOBDELAY ="NONE" *)
	inout [31:0] FSB_A,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	(* IOBDELAY ="NONE" *)
	inout FSB_RnW,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	(* IOBDELAY ="NONE" *)
	inout FSB_nRMC,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input [1:0] FSB_SIZ,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPU_nCIOUT,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output CPU_nAOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPU_nECS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPU_nAS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPU_nDS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPU_nCBREQ,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CPU_nDSACK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CPU_nDSACKOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CPU_nDOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	output CPU_DDIR,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	(* IOBDELAY ="NONE" *)
	inout [31:0] FSB_D,
	
	(* IOB = "FORCE" *)
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output reg CPUCLK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CPUCLKIN,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CLKIN,
	
	(* IOB = "FORCE" *)
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output reg FPUCLK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output nFPUCS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output reg CPU_nSTERM,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CPU_nCBACK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CPU_nCIIN,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output reg CPU_nHALT,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output reg CPU_nBERR,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_nCS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_nRAS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_nCAS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_nWE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_CKE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output [1:0] RAM_BA,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output [12:0] RAM_A,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output [3:0] RAM_DQM,
	
	(* IOB = "FORCE" *)
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_CLK01,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output RAM_CLK23,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output [3:0] IOB_A,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output [1:0] IOB_SIZ,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_nAOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_ADoutLE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_nAS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_nDS,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input [1:0] IOB_nDSACK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_nDOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output IOB_DDIR,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	(* IOBDELAY ="NONE" *)
	inout [31:0] IOB_D,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "2" *)
	output reg nRESOE,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input nRES,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input IOBCLK,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input IOB_nHALT,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input IOB_nBERR,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* IOBDELAY ="NONE" *)
	input CLKFB_IN,
	
	(* IOSTANDARD = "LVCMOS33" *)
	(* DRIVE = "24" *)
	(* SLOW = "FALSE" *)
	(* FAST = "TRUE" *)
	(* SLEW="FAST" *)
	output CLKFB_OUT);
	
	wire FSBCLK, CPUCLKi;
	CLK instance_name (
		.CLKIN(CLKIN),
		.CLKFB_IN(CLKFB_IN),
		.FSBCLK(FSBCLK),
		.CPUCLK(CPUCLKi),
		.CLKFB_OUT(CLKFB_OUT));
	
	reg CPUCLKr0 = 0;
	reg CPUCLKr1 = 0;
	reg CPUCLKd = 0;
	always @(posedge FSBCLK) begin
		CPUCLKr0 <= ~CPUCLKr0;
	end
	always @(negedge CPUCLKi) begin
		CPUCLKr1 <= CPUCLKr0;
	end
	always @(posedge CPUCLKi) begin
		CPUCLK <= CPUCLKr1;
		FPUCLK <= CPUCLKr1;
	end
	
	wire RAM_CLK01_ODDR;
	assign RAM_CLK01 = RAM_CLK01_ODDR;
	ODDR2 #(
		.DDR_ALIGNMENT("NONE"),	// Sets output alignment to "NONE", "C0" or "C1" 
		.INIT(1'b0),    			// Sets initial state of the Q output to 1'b0 or 1'b1
		.SRTYPE("SYNC")) 			// Specifies "SYNC" or "ASYNC" set/reset
	RAM_CLK01_ODDR_inst (
		.Q(RAM_CLK01_ODDR),   	// 1-bit DDR output data
		.C0(FSBCLK),				// 1-bit clock input
		.C1(~FSBCLK),   			// 1-bit clock input
		.CE(1'b1), 					// 1-bit clock enable input
		.D0(1'b0), 					// 1-bit data input (associated with C0)
		.D1(1'b1), 					// 1-bit data input (associated with C1)
		.R(1'b0),   				// 1-bit reset input
		.S(1'b0));    				// 1-bit set input 
	
	assign CPU_nDSACK = ~((FSB_A[31:2]==LastA[31:2] || FSB_A[31:1]==LastAWR[31:11]) && FSB_RnW);
	
	reg [31:2] LastA;
	reg [31:11] LastAWR;
	always @(posedge FSBCLK) begin
		if (FSB_RnW && ~CPU_nAS) LastA[31:2] <= FSB_A[31:2] + 1;
		if (~FSB_RnW && ~CPU_nAS) LastAWR[31:11] <= FSB_A[31:11];
		CPU_nSTERM <= ~((FSB_A[31:2]==LastA[31:2] || FSB_A[31:1]==LastAWR[31:11]) && FSB_RnW);
		nRESOE <= ~nRESOE;
	end
	
	wire FPUCS = FSB_FC[02:00]==3'h7 && FSB_A[19:16]==4'h2 && FSB_A[15:13]==3'h1;
	assign nFPUCS = ~((FPUCS && ~CPUCLKIN) || (FPUCS && ~CPU_nAS));
	
	(* IOB = "FORCE" *)
	reg LHALT;
	reg LE;
	always @(posedge FSBCLK) begin
		LE <= ~LE;
	end
	always @(LE, IOB_nHALT) begin 
		if (~LE) begin
			LHALT <= IOB_nHALT;
		end
	end
	
	always @(posedge FSBCLK) begin
		CPU_nBERR <= LHALT;
	end

endmodule
