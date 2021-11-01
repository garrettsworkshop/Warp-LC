/* L2 Prefetch Buffer
 * Prefetch tag RAM - 128 x 22s bits
 * 	(1) Valid
 *		(21) Tag - {A[30], A[28], A[25:0]}
 * Prefetch data RAM - 
 */
module L2Prefetch(
   input CLK,
	input CPUCLKr,
	
   input [27:2] RDA,
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
	PrefetchTagRAM Tag (
		.clk(CLK),	
		.we(WR && (WRM[3:0]==4'b1111 || TSMatch)),
		.a(WRAIndex),
		.d({~CLR, WRATag}),
		.spo({TSValid, TSTag}),
		.dpra(RDAIndex),
		.dpo({RDValid, RDTag}));

	assign Match = RDMatch;
	
	/* Data */
	PrefetchDataRAM your_instance_name (
		.clka(CLK),
		.ena(~CPUCLKr),
		.wea(1'b0),
		.addra(addra), // input [8 : 0] addra
		.dina(dina), // input [31 : 0] dina
		.douta(douta), // output [31 : 0] douta
		.clkb(clkb), // input clkb
		.enb(enb), // input enb
		.web(web), // input [0 : 0] web
		.addrb(addrb), // input [8 : 0] addrb
		.dinb(dinb), // input [31 : 0] dinb
		.doutb(doutb)); // output [31 : 0] doutb

endmodule
