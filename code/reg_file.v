// 2016.06.28
// File         : regfile.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//
`include "define.v"

module regfile #(parameter WIDTH = 16,parameter DEPTH = 64)(
input clk,
input we_1,
input [$clog2(DEPTH)-1:0]read_reg1,read_reg2,
input [$clog2(DEPTH)-1:0]write_reg1,
input [WIDTH-1:0]write_reg1_data,

output [WIDTH-1:0] read_out_1,read_out_2
);
integer i;

parameter zero={(WIDTH){1'b0}};

reg [WIDTH-1:0]file[0:DEPTH-1];

assign read_out_1=(read_reg1==5'b0)?zero:file[read_reg1];
assign read_out_2=(read_reg2==5'b0)?zero:file[read_reg2];


initial begin //test use
	for(i=0;i<DEPTH;i=i+1)
		file[i]=32'd0;
	end

always @(posedge clk)
begin
	if(we_1&(write_reg1!=5'd0))
		file[write_reg1]<=write_reg1_data;

end

endmodule