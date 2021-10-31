module L2Prefetch(
   input CLK,
	input CPUCLKr,
	
   input [28:2] RDA,
   output [31:0] RDD,
   output Match,
	
   input [28:2] WRA,
   input [31:0] WRD,
	input WR,
	input [3:0] WRM,
	input CLR);
	
	/* Read Address */
	wire [20:0] RDATag = RDA[28:7];
	wire [4:0] RDAIndex = RDA[6:2];
	
	/* Write Address */
	wire [20:0] WRATag = WRA[28:7];
	wire [4:0] WRAIndex = WRA[6:2];
	
	/* Way 0 Tag & Valid */
	wire [20:0] RDTag;
	wire [20:0] TSTag;
	wire RDValid;
	wire TSValid;
	wire RDMatch = RDValid && RDTag==RDATag;
	wire TSMatch = TSValid && TSTag==RDATag;
	PrefetchTagRAM Way0Tag (
		.clk(CLK),	
		.we(WR && (WRM[3:0]==4'b1111 || TSMatch)),
		.a(WRA[8:2]),
		.d({~CLR, WRATag[20:0]}),
		.spo({TSValid, TSTag[20:0]}),
		.dpra(RDA[8:2]),
		.dpo({RDValid, RDTag[20:0]}));
	
	/* Way 0 Data */
	PrefetchDataRAM Way0Data (
		.clka(CLK),
		.ena(WR && (WRM[3:0]==4'b1111 || TSMatch)),
		.wea(WRM[3:0]),
		.addra(WRAIndex[4:0]),
		.dina(WRD[31:0]),
		.clkb(CLK),
		.enb(~CPUCLKr),
		.addrb({2'b00, RDAIndex[4:0]}),
		.doutb(RDD[31:0]));

	assign Match = RDMatch;

endmodule
