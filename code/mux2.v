// 2016.06.28
// File         : Mux2.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
module Mux2 #(parameter WIDTH = 32)(
input sel,
input[(WIDTH-1):0]in0,in1,
output[(WIDTH-1):0]out
);

assign out = (sel) ? in1 : in0;

endmodule

