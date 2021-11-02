module L2Cache(
   input CLK,
	input CPUCLKr,
	
   input [27:2] RDA,
   output [31:0] RDD,
   output Match,
	
   input [27:2] WRA,
   input [31:0] WRD,
	input [3:0] WRM,
	input TS,
	input WR,
	input CLR,
	input ALL);
	
	/* Cache ways */
	wire [255:0] WayRDD;
	wire [7:0] WayRDMatch;
	L2CacheWay Way[7:0] (
		.CLK(CLK), 
		.CPUCLKr(CPUCLKr), 
		.RDA(RDA), 
		.RDD(WayRDD), 
		.RDMatch(WayRDMatch),
		.WRA(WRA), 
		.WRD(WRD), 
		.WRM(WRM), 
		.TS(TS), 
		.WR(WR), 
		.CLR(CLR),
		.ALL(ALL));

	assign Match =	WayRDMatch[0] || WayRDMatch[1] || 
						WayRDMatch[2] || WayRDMatch[3] || 
						WayRDMatch[4] || WayRDMatch[5] || 
						WayRDMatch[6] || WayRDMatch[7];
						 
	assign RDD[31:0] = WayRDMatch[0] ? WayRDD[31:00] : 
							 WayRDMatch[1] ? WayRDD[63:32] : 
							 WayRDMatch[2] ? WayRDD[95:64] : 
							 WayRDMatch[3] ? WayRDD[127:96] : 
							 WayRDMatch[4] ? WayRDD[159:128] : 
							 WayRDMatch[5] ? WayRDD[191:160] : 
							 WayRDMatch[6] ? WayRDD[223:192] : 
							 WayRDMatch[7] ? WayRDD[255:224] : 0;

endmodule
