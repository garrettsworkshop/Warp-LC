/* L2 Cache Way
 * 1024 x 49 bits
 *		(1) Valid
 * 	(16) Tag - {A[30], A[28], A[25:0]}
 * 	(32) Data
 */
module L2CacheWay(
   input CLK,
	input CPUCLKr,
	
   input [27:2] RDA,
   output [31:0] RDD,
	output RDMatch,
	
   input [27:2] WRA,
   input [31:0] WRD,
	input [3:0] WRM,
	input TS,
	input WR,
	input CLR,
	input ALL);

	/* Read address */
	wire [15:0] RDATag = RDA[27:12];
	wire [11:0] RDAIndex = RDA[11:2];

	/* Write address */
	wire [15:0] WRATag = WRA[27:12];
	wire [11:0] WRAIndex = WRA[11:2];
	
	/* Cache way RAM */
	wire [31:0] RDD;
	wire [31:0] TSD;
	wire [15:0] RDTag;
	wire [15:0] TSTag;
	wire RDValid;
	wire TSValid;
	assign RDMatch = RDValid && RDTag==RDATag;
	wire TSMatch = TSValid && TSTag==WRATag;
	L2WayRAM way (
		.clka(CLK),
		.ena(~CPUCLKr),
		.wea(1'b0),
		.addra(RDAIndex),
		.dina(50'b0),
		.douta({RDValid, RDTag, RDD}),
		.clkb(CLK),
		.enb(1'b0),
		.web(1'b0),
		.addrb(WRAIndex),
		.dinb({~CLR, WRATag, WRD}),
		.doutb({TSValid, TSTag, TSD}));

endmodule
