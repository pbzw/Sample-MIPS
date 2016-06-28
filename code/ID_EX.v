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

input [31:0]ID_imm,
input [31:0]ID_read_data1,
input [31:0]ID_read_data2,
input [8:0]ID_ALUop,
input [4:0]ID_Rs,
input [4:0]ID_Rt,
input [4:0]ID_Rdst,
input ID_RegW,
input ID_ALUSrc,
input ID_MemR,
input ID_MemW,

output reg [31:0]EX_imm,
output reg [31:0]EX_read_data1,
output reg [31:0]EX_read_data2,
output reg [8:0]EX_ALUop,
output reg [4:0]EX_Rs,
output reg [4:0]EX_Rt,
output reg [4:0]EX_Rdst,
output reg EX_RegW,
output reg EX_ALUSrc,
output reg EX_MemR,
output reg EX_MemW

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
		end
	end

endmodule