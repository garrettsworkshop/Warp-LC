`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:01 10/30/2021 
// Design Name: 
// Module Name:    sterminator 
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

// SDRAM addressing for RAM
// A[25:13] - Row[12:0]
// A[12:4]  - Column[8:0]
// A[3:2]   - Bank[1:0]
// A[1:0]   - SDRAM word size

module sterminator(
	input CLK,
	input [31:2] A,
	input nWE,
	input SEL,
	input STERMin,
	output nSTERM,
	input RESET,
	input [2:0] CMD);

	reg [3:0] BankActive;
	reg [12:0] Bank0Row;
	reg [12:0] Bank1Row;
	reg [12:0] Bank2Row;
	reg [12:0] Bank3Row;
	reg SpecRDActive;
	reg [30:2] SpecRDAddr;
	
	wire [12:0] A_Row = A[25:13];	
	wire [8:0] A_Column = A[12:4];
	wire [1:0] A_Bank = A[3:2];
	
	wire A_CurBankRow = A_Bank==0 ? Bank0Row :
							  A_Bank==1 ? Bank1Row :
							  A_Bank==2 ? Bank2Row :
							  A_Bank==3 ? Bank3Row : 0;
	
	wire SpecRDSEL = SEL &&  nWE && ~A[31] && A[30:2]==SpecRDAddr[30:2];
	wire FastWRSEL = SEL && ~nWE && ~A[31] && A_CurBankRow==A_Row;
	
	assign nSTERM = ~(STERMin || SpecRDSEL || FastWRSEL);
	
	always @(posedge CLK) begin
		case (CMD)
			3'b000: begin // Reset
				BankActive <= 0;
				SpecRDActive <= 0;
			end 3'b001: begin // Row activate
				BankActive[A_Bank] <= 1;
				case (A_Bank)
					0: Bank0Row <= A_Row;
					1: Bank1Row <= A_Row;
					2: Bank2Row <= A_Row;
					3: Bank3Row <= A_Row;
				endcase
			end 3'b010: begin // Row precharge
				BankActive[A_Bank] <= 0;
			end 3'b011: begin // Precharge all
				BankActive <= 0;
			end 3'b100: begin // NOP
			end 3'b101: begin // Speculative read
				SpecRDAddr <= A[30:2];
				SpecRDActive <= 1;
			end 3'b110: begin // Clear speculation
				SpecRDActive <= 0;
			end 3'b111: begin // Reserved (NOP)
			end
		endcase
	end

endmodule
