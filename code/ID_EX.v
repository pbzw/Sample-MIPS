// 2016.06.28
// File         : ID_EX.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//

module ID_EX(
input clk,rst,
input Stall,
input flush,

input ID_inst_en,

input [31:0]ID_imm,ID_PC_Plus_8,
input [31:0]ID_read_data1,
input [31:0]ID_read_data2,
input [8:0]ID_ALUop,
input [4:0]ID_Rs,
input [4:0]ID_Rt,
input [4:0]ID_Rdst,
input [1:0]ID_SelMOD,
input ID_MdataS,
input ID_RegW,
input ID_ALUSrc,
input ID_MemR,
input ID_MemW,
input ID_Link,
input ID_EX_Wants_Rs,
input ID_EX_Needs_Rs,
input ID_EX_Wants_Rt,
input ID_EX_Needs_Rt,

output reg [31:0]EX_imm,EX_PC_Plus_8,
output reg [31:0]EX_read_data1,
output reg [31:0]EX_read_data2,
output reg [8:0]EX_ALUop,
output reg [4:0]EX_Rs,
output reg [4:0]EX_Rt,
output reg [4:0]EX_Rdst,
output reg EX_RegW,
output reg EX_ALUSrc,
output reg EX_MemR,
output reg EX_MemW,
output reg EX_Link,
output reg EX_inst_en,
output reg [1:0]EX_SelMOD,
output reg EX_MdataS,

output reg EX_Wants_Rs,
output reg EX_Needs_Rs,
output reg EX_Wants_Rt,
output reg EX_Needs_Rt

);

always@(posedge clk)begin
	if(rst|flush)begin
		EX_imm       <=32'd0;
		EX_read_data1<=32'd0;
		EX_read_data2<=32'd0;
		EX_ALUop     <= 8'd0;
		EX_Rdst      <= 5'd0;
		EX_Rs        <= 5'd0;
		EX_Rt        <= 5'd0;
		EX_RegW      <= 1'b0;
		EX_ALUSrc    <= 1'b0;
		EX_MemR      <= 1'b0;
		EX_MemW      <= 1'b0;
		EX_Wants_Rs  <= 1'b0;
		EX_Needs_Rs  <= 1'b0;
		EX_Wants_Rt  <= 1'b0;
		EX_Needs_Rt  <= 1'b0;
		EX_inst_en   <= 1'b0;
		EX_Link      <= 1'b0;
		EX_PC_Plus_8 <=32'd0;
		EX_SelMOD    <= 2'b0;
		EX_MdataS    <= 1'b0;
		end
	else if(!Stall)begin
		EX_imm       <=ID_imm;
		EX_read_data1<=ID_read_data1;
		EX_read_data2<=ID_read_data2;
		EX_ALUop     <=ID_ALUop;
		EX_Rdst      <=ID_Rdst;
		EX_Rs        <=ID_Rs;
		EX_Rt        <=ID_Rt;
		EX_RegW      <=ID_RegW;
		EX_ALUSrc    <=ID_ALUSrc;
		EX_MemR      <=ID_MemR;
		EX_MemW      <=ID_MemW;
		EX_Link      <=ID_Link;
		EX_PC_Plus_8 <=ID_PC_Plus_8;
		EX_inst_en   <=ID_inst_en;
		EX_Wants_Rs  <=ID_EX_Wants_Rs;
		EX_Needs_Rs  <=ID_EX_Needs_Rs;
		EX_Wants_Rt  <=ID_EX_Wants_Rt;
		EX_Needs_Rt  <=ID_EX_Needs_Rt;
		EX_SelMOD    <=ID_SelMOD;
		EX_MdataS    <=ID_MdataS;
		end
	end

endmodule