// 2016.06.28
// File         : IF_ID.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//

module IF_ID(
input clk,rst,
input inst_en,
input Stall,
input flush,
input [31:0]IF_inst_in,
input [31:0]IF_PC_in,
output reg ID_inst_en,
output reg[31:0]ID_PC,
output reg[31:0]ID_inst
);

always@(posedge clk)begin
	if(rst|flush)begin
		ID_PC     <=32'd0;
		ID_inst   <=32'd0;
		ID_inst_en<=1'b0;
		end
	else if(!Stall)begin
		ID_PC  <=IF_PC_in;
		ID_inst<=IF_inst_in;
		ID_inst_en<=inst_en;
		end
	end

endmodule
