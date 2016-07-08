// 2016.06.28
// File         : MEM_WB.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//

module MEM_WB(
input clk,rst,
input Stall,
input flush,

input MEM_inst_en,
input [31:0]MEM_ALU_Result,MEM_MEM_Result,
input [4:0]MEM_Rs,
input [4:0]MEM_Rt,
input [4:0]MEM_Rdst,
input MEM_RegW,
input MEM_MemR,
input MEM_MemW,

output reg [31:0]WB_ALU_Result,WB_MEM_Result,
output reg [4:0]WB_Rs,
output reg [4:0]WB_Rt,
output reg [4:0]WB_Rdst,
output reg WB_RegW,
output reg WB_MemR,
output reg WB_MemW,
output reg WB_inst_en

);

always@(posedge clk)begin
	if(rst|flush)begin
		WB_ALU_Result<=32'd0;
		WB_MEM_Result<=32'd0;
		WB_Rs        <=5'b0;
		WB_Rt        <=5'b0;
		WB_Rdst      <=5'b0;		
		WB_RegW      <=1'b0;
		WB_MemR      <=1'b0;
		WB_MemW      <=1'b0;
		WB_inst_en   <=1'b0;
		end
	else if(!Stall)begin
		WB_ALU_Result<=MEM_ALU_Result;
		WB_MEM_Result<=MEM_MEM_Result;
		WB_Rs        <=MEM_Rs;
		WB_Rt        <=MEM_Rt;
		WB_Rdst      <=MEM_Rdst;
		WB_RegW      <=MEM_RegW;
		WB_MemR      <=MEM_MemR;
		WB_MemW      <=MEM_MemW;
		WB_inst_en   <=MEM_inst_en;
		end
	end

endmodule
