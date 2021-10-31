module SizeDecode(
    input [1:0] A,
    input [1:0] SIZ,
    output [3:0] B);
	 
	 assign B[3] = (A[1:0]==2'b00);
	 assign B[2] = (A[1:0]==2'b01) ||
						(A[1:0]==2'b00 && SIZ[1:0]!=2'b01); // Not 8-bit
	 assign B[1] = (A[1:0]==2'b10) ||
						(A[1:0]==2'b01 && SIZ[1:0]!=2'b01) || // Not 8-bit
						(A[1:0]==2'b00 && SIZ[1:0]!=2'b01 && SIZ[1:0]!=2'b10); // Not 8-bit or 16-bit
	 assign B[0] = (A[1:0]==2'b11) ||
						(A[1:0]==2'b01 && SIZ[1:0]!=2'b01) || // Not 8-bit
						(A[1:0]==2'b00 && SIZ[1:0]!=2'b01 && SIZ[1:0]!=2'b10) ||
						(A[1:0]==2'b00 && SIZ[1:0]==2'b00); // 32-bit
endmodule
