`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:55 11/02/2021 
// Design Name: 
// Module Name:    SDRAM 
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
module SDRAM(
    input [25:2] A,
    input [3:0] B,
    input WR,
    input SEL,
    input CLK,
    input [31:0] WRD,
    input RDD,
    output nCS,
    output nRAS,
    output nCAS,
    output nWE,
    output [3:0] DQM,
    output [1:0] BA,
    output [12:0] RA,
    output STERM,
    output RAMEN,
    output CA,
    input CTS,
    input CWR,
    input CPUCLKr,
    input BURST
    );


endmodule
