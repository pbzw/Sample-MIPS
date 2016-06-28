// 2016.06.28
// File         : Control.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  


`include "define.v"

module Control(
input Stall,
input [`data_lentgh-1:0]inst_in,
input inst_en,

output reg[8:0] ALUop,
output RegW,
output ALUSrc,
output MemR,
output MemW,

output [4:0]Src1,Src2,Rdst,
output [31:0]Extend_imm
);


wire [5:0] OpCode = inst_in[31:26];
wire [5:0] Funct  = inst_in[5:0];
wire [15:0]Imme   = inst_in[15:0];
wire [4:0] Rs     = inst_in[25:21];
wire [4:0] Rt     = inst_in[20:16];
wire [4:0] Rd     = inst_in[15:11];

wire SignExtend = (OpCode[5:2] != 4'b0011);

wire [31:0]Sign_imm;

wire RdSrc;

reg [5:0]DataPath;

assign Src1 = Rs;
assign Src2 = Rt;
assign Rdst = RdSrc ? Rt:Rd;
assign Extend_imm=SignExtend?{{16{Imme[15]}},Imme}:{16'd0,Imme};


assign RegW  =DataPath[0]&inst_en;
assign RdSrc =DataPath[1];
assign ALUSrc=DataPath[2];
assign MemR  =DataPath[3];
assign MemW  =DataPath[4];

always@(*)begin
	case(OpCode)
		`Op_Ori :ALUop<=`ALUOp_Or  ;
		`Op_Andi:ALUop<=`ALUOp_And ;
		`Op_Addi:ALUop<=`ALUOp_Add ;
		`Op_Xori:ALUop<=`ALUOp_Xor ;
		`Op_Lui :ALUop<=`ALUOp_Lui ;
		`Op_Lb  :ALUop<=`ALUOp_Lb  ;
		`Op_Lbu :ALUop<=`ALUOp_Lbu ;
		`Op_Lh  :ALUop<=`ALUOp_Lh  ;
		`Op_Lhu :ALUop<=`ALUOp_Lhu ;
		`Op_Lw  :ALUop<=`ALUOp_Lw  ;
		`Op_Sb  :ALUop<=`ALUOp_Sb  ;
		`Op_Sh  :ALUop<=`ALUOp_Sh  ;
		`Op_Sw  :ALUop<=`ALUOp_Sw  ;
		`Op_Type_R:begin
			case (Funct)
				`Funct_Add     : ALUop<=`ALUOp_Add;
				`Funct_Sub     : ALUop<=`ALUOp_Sub;
				`Funct_Nor     : ALUop<=`ALUOp_Nor;
				`Funct_Or      : ALUop<=`ALUOp_Or ;
				`Funct_And     : ALUop<=`ALUOp_And;
				`Funct_Xor     : ALUop<=`ALUOp_Xor;
				`Funct_Sll     : ALUop<=`ALUOp_Sll;
				`Funct_Srl     : ALUop<=`ALUOp_Srl;
				default        : ALUop<=9'd0;
			endcase
			end
		default:ALUop=9'd0;
	endcase
end



always@(*)begin
	case(OpCode)
		`Op_Ori :DataPath<=`Dp_Ori;
		`Op_Andi:DataPath<=`Dp_Andi;
		`Op_Addi:DataPath<=`Dp_Addi;
		`Op_Xori:DataPath<=`Dp_Xori;
		`Op_Lui :DataPath<=`Dp_Lui;
		`Op_Lb  :DataPath<=`Dp_Lb ;
		`Op_Lbu :DataPath<=`Dp_Lbu;
		`Op_Lh  :DataPath<=`Dp_Lh ;
		`Op_Lhu :DataPath<=`Dp_Lhu ;
		`Op_Lw  :DataPath<=`Dp_Lw ;
		`Op_Sb  :DataPath<=`Dp_Sb ;
		`Op_Sh  :DataPath<=`Dp_Sh ;
		`Op_Sw  :DataPath<=`Dp_Sw ;
		`Op_Type_R  :begin
			case (Funct)
				`Funct_Add     : DataPath<=`Dp_Add;
				`Funct_Sub     : DataPath<=`Dp_Sub;
				`Funct_Nor     : DataPath<=`Dp_Nor;
				`Funct_Or      : DataPath<=`Dp_Or;
				`Funct_And     : DataPath<=`Dp_And;
				`Funct_Xor     : DataPath<=`Dp_Xor;
				`Funct_Sll     : DataPath<=`Dp_Sll ;
				`Funct_Srl     : DataPath<=`Dp_Srl;
				default : DataPath<=6'd0;
			endcase
			end
		default:DataPath=6'b000000;
	endcase
end

endmodule
