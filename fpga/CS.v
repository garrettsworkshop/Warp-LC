module CS(
	input [31:8] A
	output RAMCS,
	output ROMCS,
	output VRAMCS,
	output CacheCS,
	output LoMemCacheCS,
	output [27:0] CA);

	assign RAMCS = A[31:30]==2'b00;
	assign ROMCS = A[31:28]==4'h4;
	assign VRAMCS = A[31:20]==12'h50F;
	
	assign CacheCS = RAMCS || ROMCS || VRAMCS;

	assign LoMemCacheCS = RAMCS && A[25:12]==0;

	assign CA[27] = A[30];
	assign CA[26] = A[28];
	assign CA[25:0] = A[25:0];

endmodule
