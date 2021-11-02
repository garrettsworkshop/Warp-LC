/* L2 Prefetch Buffer
 * Prefetch tag RAM - 128 x 20 bits
 * 	(1) Valid
 *		(19) Tag - {A[30], A[28], A[25:2]}
 * Prefetch data RAM - 
 */
module L2Prefetch(
   input CLK,
	input CPUCLKr,
	
   input [27:2] RDA,
	input RDFixed7k5SEL,
   output [31:0] RDD,
   output Match,
	
   input [27:2] WRA,
   input [31:0] WRD,
	input WR,
	input [3:0] WRM,
	input CLR);
	
	/* Read Address */
	wire [18:0] RDATag = RDA[27:9];
	wire [6:0] RDAIndex = RDA[8:2];
	
	/* Write Address */
	wire [18:0] WRATag = WRA[27:9];
	wire [6:0] WRAIndex = WRA[8:2];
	
	/* Tag & Valid */
	wire [18:0] RDTag;
	wire [18:0] TSTag;
	wire RDValid;
	wire TSValid;
	wire RDMatch = RDValid && RDTag==RDATag;
	wire TSMatch = TSValid && TSTag==WRATag;
	PrefetchTagRAM tag (
		.clk(CLK),	
		.we(WR && (WRM[3:0]==4'b1111 || TSMatch)),
		.a(WRAIndex),
		.d({~CLR, WRATag}),
		.spo({TSValid, TSTag}),
		.dpra(RDAIndex),
		.dpo({RDValid, RDTag}));

	assign Match = RDMatch || RDFixed7k5SEL;
	
	/* Data */
	PrefetchDataRAM data (
		.clka(CLK),
		.ena(~CPUCLKr),
		.wea(4'b0),
		.addra({RDFixed7k5SEL ? RDA[12:9] : 4'hF , RDAIndex}),
		.dina(32'b0),
		.douta(RDD[31:0]),
		
		.clkb(CLK),
		.enb(1'b0),
		.web(WRM[3:0]),
		.addrb({RDFixed7k5SEL ? WRA[12:9] : 4'hF , WRAIndex}),
		.dinb(WRD[31:0]));

endmodule
