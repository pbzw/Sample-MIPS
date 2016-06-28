// 2016.06.28
// File         : Add.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  

module Add(
	input [31:0]A,
	input [31:0]B,
	output [31:0]C
);

assign C = (A + B);

endmodule

