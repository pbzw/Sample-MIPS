// 2016.06.28
// File         : Register.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//
`include "define.v"

module Register #(parameter WIDTH = 32,reset=16'h3000)(
input clk,
input rst,
input en,
input[WIDTH-1:0] data_in,
output reg[WIDTH-1:0] data_out
);



always@(`clk_trigger_edge clk)
begin
	if(rst)
	data_out<=reset;
	else if(en)
	data_out<=data_in;
end

endmodule