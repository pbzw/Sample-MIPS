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

input [31:0]EX_ALU_Result,
input [4:0]EX_Rs,
input [4:0]EX_Rt,
input [4:0]EX_Rdst,
input EX_RegW,
input EX_MemR,
input EX_MemW,


output reg [31:0]MEM_ALU_Result,
output reg [4:0]MEM_Rs,
output reg [4:0]MEM_Rt,
output reg [4:0]MEM_Rdst,
output reg MEM_RegW,
output reg MEM_MemR,
output reg MEM_MemW

);

always@(posedge clk)begin
	if(rst|flush)begin
		MEM_ALU_Result<=32'd0;
		MEM_Rs        <=5'b0;
		MEM_Rt        <=5'b0;
		MEM_Rdst      <=5'b0;		
		MEM_RegW      <=1'b0;
		MEM_MemR      <=1'b0;
		MEM_MemW      <=1'b0;
		end
	else if(!Stall)begin
		MEM_ALU_Result<=EX_ALU_Result;
		MEM_Rs        <=EX_Rs;
		MEM_Rt        <=EX_Rt;
		MEM_Rdst      <=EX_Rdst;
		MEM_RegW      <=EX_RegW;
		MEM_MemR      <=EX_MemR;
		MEM_MemW      <=EX_MemW;
		end
	end

endmodule
