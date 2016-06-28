// 2016.06.28
// File         : ALU.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  


`include "define.v"

module ALU(
input[31:0] Src1,Src2,
input[8:0]  Operation,
output reg signed [31:0] Result
);


always@(*)begin
	case (Operation)
		`ALUOp_Or   : Result <= Src1|Src2;
		`ALUOp_Nor  : Result <= ~(Src1|Src2);
		`ALUOp_And  : Result <= Src1&Src2;
		`ALUOp_Xor  : Result <= Src1^Src2;
		`ALUOp_Add  : Result <= Src1+Src2;
		`ALUOp_Sub  : Result <= Src1-Src2;
		`ALUOp_Lui  : Result <= {Src2[15:0],16'b0};
		`ALUOp_Sll  : Result <= Src1<<Src2[10:6];
		`ALUOp_Srl  : Result <= Src1>>Src2[10:6];
		default     : Result <= 32'd0;
	endcase
	
	end


endmodule

