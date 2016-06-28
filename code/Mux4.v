// 2016.06.28
// File         : Mux4.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
module Mux4 #(parameter WIDTH = 32)(
input[1:0]sel,
input[(WIDTH-1):0]in0,in1,in2,in3,
output reg[(WIDTH-1):0] out
);

always@(*)
	begin
		case(sel)
		2'b00:out=in0;
		2'b01:out=in1;
		2'b10:out=in2;
		2'b11:out=in3;
		endcase
	end

endmodule