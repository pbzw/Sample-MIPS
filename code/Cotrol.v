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
input Branch,

output reg[8:0] ALUop,
output reg RegW,
output ALUSrc,
output MemR,
output MemW,
output Link,
output reg [1:0]PCsrcSel,
output [1:0]SelMOD,
output MdataS,

output ID_Wants_Rs,
output ID_Needs_Rs,
output ID_Wants_Rt,
output ID_Needs_Rt,
output EX_Wants_Rs,
output EX_Needs_Rs,
output EX_Wants_Rt,
output EX_Needs_Rt,

output [4:0]Src1,Src2,Rdst,
output [31:0]Extend_imm,
output reg[3:0]CmpMod
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


reg [10:0]DataPath;
reg [7:0]HazardDataPath;

assign Src1 = Rs;
assign Src2 = Rt;
assign Rdst = Link&(!(&{DataPath[6:5],DataPath[0]}))?5'd31:RdSrc ? Rt:Rd;
assign Extend_imm=SignExtend?{{16{Imme[15]}},Imme}:{16'd0,Imme};

assign RdSrc   =DataPath[1];
assign ALUSrc  =DataPath[2];
assign MemR    =DataPath[3]&(!Stall);
assign MemW    =DataPath[4]&(!Stall);
assign Link    =DataPath[7];
assign SelMOD  =DataPath[9:8];
assign MdataS  =DataPath[10];
always@(*)begin
	case(DataPath[6:5])
	2'b00:PCsrcSel<=2'b00;
	2'b01:PCsrcSel<=Branch?2'b01:2'b00;
	2'b10:PCsrcSel<=2'b10;
	2'b11:PCsrcSel<=2'b11;
	endcase
end

always@(*)begin
	case(DataPath[6:5])
	2'b00:RegW<=DataPath[0]&inst_en&(!Stall);
	2'b01:RegW<=(Branch?DataPath[0]:0)&inst_en&(!Stall);
	2'b10:RegW<=DataPath[0]&inst_en&(!Stall);
	2'b11:RegW<=DataPath[0]&inst_en&(!Stall);
	endcase
end

always@(*)begin
	case(OpCode)
		`Op_Ori :ALUop<=`ALUOp_Or  ;
		`Op_Andi:ALUop<=`ALUOp_And ;
		`Op_Addi:ALUop<=`ALUOp_Add ;
		`Op_Xori:ALUop<=`ALUOp_Xor ;
		`Op_J   :ALUop<=9'd0;
		`Op_Jal :ALUop<=9'd0;
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
		`Op_J   :DataPath<=`Dp_J;
		`Op_Jal :DataPath<=`Dp_Jal;
		`Op_Beq :DataPath<=`Dp_Beq;
		`Op_Bgtz:DataPath<=`Dp_Bgtz;
		`Op_Blez:DataPath<=`Dp_Blez;
		`Op_Bne :DataPath<=`Dp_Bne;
		`Op_Lui :DataPath<=`Dp_Lui;
		`Op_Lb  :DataPath<=`Dp_Lb ;
		`Op_Lbu :DataPath<=`Dp_Lbu;
		`Op_Lh  :DataPath<=`Dp_Lh ;
		`Op_Lhu :DataPath<=`Dp_Lhu ;
		`Op_Lw  :DataPath<=`Dp_Lw ;
		`Op_Sb  :DataPath<=`Dp_Sb ;
		`Op_Sh  :DataPath<=`Dp_Sh ;
		`Op_Sw  :DataPath<=`Dp_Sw ;
		`Op_Type_BI:begin
			case(Rt)
				`OpRt_Bgez  :DataPath<=`Dp_Bgez  ;
				`OpRt_Bgezal:DataPath<=`Dp_Bgezal;
				`OpRt_Bltz  :DataPath<=`Dp_Bltz  ;
				`OpRt_Bltzal:DataPath<=`Dp_Bltzal;
				default     :DataPath<=8'd0;
			endcase
			end
		`Op_Type_R  :begin
			case (Funct)
				`Funct_Add     : DataPath<=`Dp_Add;
				`Funct_Sub     : DataPath<=`Dp_Sub;
				`Funct_Nor     : DataPath<=`Dp_Nor;
				`Funct_Or      : DataPath<=`Dp_Or;
				`Funct_And     : DataPath<=`Dp_And;
				`Funct_Xor     : DataPath<=`Dp_Xor;
				`Funct_Sll     : DataPath<=`Dp_Sll;
				`Funct_Srl     : DataPath<=`Dp_Srl;
				`Funct_Jr      : DataPath<=`Dp_Jr;
				`Funct_Jalr    : DataPath<=`Dp_Jalr;
				default : DataPath<=8'd0;
			endcase
			end
		default:DataPath=8'b000000;
	endcase
end

assign ID_Wants_Rs=HazardDataPath[0];
assign ID_Needs_Rs=HazardDataPath[1];
assign ID_Wants_Rt=HazardDataPath[2];
assign ID_Needs_Rt=HazardDataPath[3];
assign EX_Wants_Rs=HazardDataPath[4];
assign EX_Needs_Rs=HazardDataPath[5];
assign EX_Wants_Rt=HazardDataPath[6];
assign EX_Needs_Rt=HazardDataPath[7];

always@(*)begin
	case(OpCode)
		`Op_Beq   :CmpMod=`Beq   ;
		`Op_Bgtz  :CmpMod=`Bgtz  ;
		`Op_Blez  :CmpMod=`Blez  ;
		`Op_Bne   :CmpMod=`Bne   ;
		`Op_Type_BI:begin
			case(Rt)
				`OpRt_Bgez  :CmpMod=`Bgez  ;
				`OpRt_Bgezal:CmpMod=`Bgezal;
				`OpRt_Bltz  :CmpMod=`Bltz  ;
				`OpRt_Bltzal:CmpMod=`Bltzal;
				default   :CmpMod=4'd0   ;
			endcase
			end
		default   :CmpMod=4'd0   ;
	endcase
end

always@(*)begin
	case(OpCode)
		`Op_Ori   :HazardDataPath<=`HDP_Ori;
		`Op_Andi  :HazardDataPath<=`HDP_Andi;
		`Op_Addi  :HazardDataPath<=`HDP_Addi;
		`Op_Xori  :HazardDataPath<=`HDP_Xori;
		`Op_J     :HazardDataPath<=`HDP_J;
		`Op_Jal   :HazardDataPath<=`HDP_Jal;
		`Op_Lui   :HazardDataPath<=`HDP_Lui;
		`Op_Lb    :HazardDataPath<=`HDP_Lb ;
		`Op_Lbu   :HazardDataPath<=`HDP_Lbu;
		`Op_Lh    :HazardDataPath<=`HDP_Lh ;
		`Op_Lhu   :HazardDataPath<=`HDP_Lhu ;
		`Op_Lw    :HazardDataPath<=`HDP_Lw ;
		`Op_Sb    :HazardDataPath<=`HDP_Sb ;
		`Op_Sh    :HazardDataPath<=`HDP_Sh ;
		`Op_Sw    :HazardDataPath<=`HDP_Sw ;
		`Op_Beq   :HazardDataPath<=`HDP_Beq ;
		`Op_Bgtz  :HazardDataPath<=`HDP_Bgtz ;
		`Op_Blez  :HazardDataPath<=`HDP_Blez ;
		`Op_Bne   :HazardDataPath<=`HDP_Bne ;
		`Op_Type_BI:begin
			case(Rt)
				`OpRt_Bgez  :HazardDataPath=`HDP_Bgez  ;
				`OpRt_Bgezal:HazardDataPath=`HDP_Bgezal;
				`OpRt_Bltz  :HazardDataPath=`HDP_Bltz  ;
				`OpRt_Bltzal:HazardDataPath=`HDP_Bltzal;
				default : HazardDataPath<=8'd0;
			endcase
			end
		`Op_Type_R  :begin
			case (Funct)
				`Funct_Add     : HazardDataPath<=`HDP_Add;
				`Funct_Sub     : HazardDataPath<=`HDP_Sub;
				`Funct_Nor     : HazardDataPath<=`HDP_Nor;
				`Funct_Or      : HazardDataPath<=`HDP_Or;
				`Funct_And     : HazardDataPath<=`HDP_And;
				`Funct_Xor     : HazardDataPath<=`HDP_Xor;
				`Funct_Sll     : HazardDataPath<=`HDP_Sll ;
				`Funct_Srl     : HazardDataPath<=`HDP_Srl;
				`Funct_Jr      : HazardDataPath<=`HDP_Jr ;
				`Funct_Jalr    : HazardDataPath<=`HDP_Jalr;
				default : HazardDataPath<=8'd0;
			endcase
			end
		default:HazardDataPath=8'b00000000;
	endcase
end

endmodule
