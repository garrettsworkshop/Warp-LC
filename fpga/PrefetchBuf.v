`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:46 10/30/2021 
// Design Name: 
// Module Name:    PrefetchBuf 
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
module PrefetchBuf(
    input [31:0] RDA,
    output [31:0] RDD,
    output Match,
    input CLK,
    input [31:0] WRA,
    input [31:0] WRDin,
    output [31:0] WRDout,
	 input [3:0] WE,
	 input TS);
		
	RAM128X1D Way0[55:0] (
		.DPO(WRDout),
		.SPO(RDD),
		.A(WRA[10:2]),
		.D({A[WRDin[7:0]),
		.DPRA(RDA),
		.WCLK(CLK),
		.WE(WE));
	
endmodule
