// 2016.06.28
// File         : EX_MEM.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//

module EX_MEM(
input clk,rst,
input Stall,
input flush,
input EX_inst_en,
input [31:0]EX_ALU_Result,EX_Src2,
input [4:0]EX_Rs,
input [4:0]EX_Rt,
input [4:0]EX_Rdst,
input [1:0]EX_SelMOD,
input EX_MdataS,
input EX_RegW,
input EX_MemR,
input EX_MemW,


output reg MEM_inst_en,
output reg [31:0]MEM_ALU_Result,MEM_Src2,
output reg [4:0]MEM_Rs,
output reg [4:0]MEM_Rt,
output reg [4:0]MEM_Rdst,
output reg MEM_RegW,
output reg MEM_MemR,
output reg [1:0]MEM_SelMOD,
output reg MEM_MdataS,
output reg MEM_MemW

);

always@(posedge clk)begin
	if(rst|flush)begin
		MEM_ALU_Result<=32'd0;
		MEM_Src2      <=32'd0;
		MEM_Rs        <=5'b0;
		MEM_Rt        <=5'b0;
		MEM_Rdst      <=5'b0;		
		MEM_RegW      <=1'b0;
		MEM_MemR      <=1'b0;
		MEM_MemW      <=1'b0;
		MEM_inst_en   <=1'b0;
		MEM_SelMOD    <=2'b0;
		MEM_MdataS    <=1'b0;
		end
	else if(!Stall)begin
		MEM_ALU_Result<=EX_ALU_Result;
		MEM_Src2      <=EX_Src2;
		MEM_Rs        <=EX_Rs;
		MEM_Rt        <=EX_Rt;
		MEM_Rdst      <=EX_Rdst;
		MEM_RegW      <=EX_RegW;
		MEM_MemR      <=EX_MemR;
		MEM_MemW      <=EX_MemW;
		MEM_inst_en   <=EX_inst_en;
		MEM_SelMOD    <=EX_SelMOD;
		MEM_MdataS    <=EX_MdataS;
		end
	end

endmodule
