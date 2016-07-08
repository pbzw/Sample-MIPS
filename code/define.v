// 2016.06.28
// File         : define.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  

`define data_lentgh 32

`define clk_trigger_edge posedge

/* Op Code Categories */
`define Op_Type_R       6'b00_0000  // Standard R-Type instructions
`define Op_Type_R2      6'b01_1100  // Extended R-Like instructions
`define Op_Type_BI	    6'b00_0001  // Branch extended instructions
`define Op_Type_CP0     6'b01_0000  // Coprocessor 0 instructions
`define Op_Type_Regimm  6'b00_0001
// --------------------------------------
`define Op_Add      `Op_Type_R
`define Op_Addi     6'b00_1000
`define Op_Addiu    6'b00_1001
`define Op_Addu     `Op_Type_R
`define Op_And      `Op_Type_R
`define Op_Andi     6'b00_1100
`define Op_Beq      6'b00_0100
`define Op_Bgez     `Op_Type_BI
`define Op_Bgezal   `Op_Type_BI
`define Op_Bgtz     6'b00_0111
`define Op_Blez     6'b00_0110
`define Op_Bltz     `Op_Type_BI
`define Op_Bltzal   `Op_Type_BI
`define Op_Bne      6'b00_0101
`define Op_Break    `Op_Type_R
`define Op_Clo      `Op_Type_R2
`define Op_Clz      `Op_Type_R2
`define Op_Div      `Op_Type_R
`define Op_Divu     `Op_Type_R
`define Op_Eret     `Op_Type_CP0
`define Op_J        6'b00_0010
`define Op_Jal      6'b00_0011
`define Op_Jalr     `Op_Type_R
`define Op_Jr       `Op_Type_R
`define Op_Lb       6'b10_0000
`define Op_Lbu      6'b10_0100
`define Op_Lh       6'b10_0001
`define Op_Lhu      6'b10_0101
`define Op_Ll       6'b11_0000
`define Op_Lui      6'b00_1111
`define Op_Lw       6'b10_0011
`define Op_Lwl      6'b10_0010
`define Op_Lwr      6'b10_0110
`define Op_Madd     `Op_Type_R2
`define Op_Maddu    `Op_Type_R2
`define Op_Mfc0     `Op_Type_CP0
`define Op_Mfhi     `Op_Type_R
`define Op_Mflo     `Op_Type_R
`define Op_Movn     `Op_Type_R
`define Op_Movz     `Op_Type_R
`define Op_Msub     `Op_Type_R2
`define Op_Msubu    `Op_Type_R2
`define Op_Mtc0     `Op_Type_CP0
`define Op_Mthi     `Op_Type_R
`define Op_Mtlo     `Op_Type_R
`define Op_Mul      `Op_Type_R2
`define Op_Mult     `Op_Type_R
`define Op_Multu    `Op_Type_R
`define Op_Nor      `Op_Type_R
`define Op_Or       `Op_Type_R
`define Op_Ori      6'b00_1101
`define Op_Pref     6'b11_0011  
`define Op_Sb       6'b10_1000
`define Op_Sc       6'b11_1000
`define Op_Sh       6'b10_1001
`define Op_Sll      `Op_Type_R
`define Op_Sllv     `Op_Type_R
`define Op_Slt      `Op_Type_R
`define Op_Slti     6'b00_1010
`define Op_Sltiu    6'b00_1011
`define Op_Sltu     `Op_Type_R
`define Op_Sra      `Op_Type_R
`define Op_Srav     `Op_Type_R
`define Op_Srl      `Op_Type_R
`define Op_Srlv     `Op_Type_R
`define Op_Sub      `Op_Type_R
`define Op_Subu     `Op_Type_R
`define Op_Sw       6'b10_1011
`define Op_Swl      6'b10_1010
`define Op_Swr      6'b10_1110
`define Op_Syscall  `Op_Type_R
`define Op_Teq      `Op_Type_R
`define Op_Teqi     `Op_Type_BI
`define Op_Tge      `Op_Type_R
`define Op_Tgei     `Op_Type_BI
`define Op_Tgeiu    `Op_Type_BI
`define Op_Tgeu     `Op_Type_R
`define Op_Tlt      `Op_Type_R
`define Op_Tlti     `Op_Type_BI
`define Op_Tltiu    `Op_Type_BI
`define Op_Tltu     `Op_Type_R
`define Op_Tne      `Op_Type_R
`define Op_Tnei     `Op_Type_BI
`define Op_Xor      `Op_Type_R
`define Op_Xori     6'b00_1110

/* Function Codes for R-Type Op Codes */
`define Funct_Add     6'b10_0000
`define Funct_Addu    6'b10_0001
`define Funct_And     6'b10_0100
`define Funct_Break   6'b00_1101
`define Funct_Div     6'b01_1010
`define Funct_Divu    6'b01_1011
`define Funct_Jr      6'b00_1000
`define Funct_Jalr    6'b00_1001
`define Funct_Madd    6'b00_0000
`define Funct_Maddu   6'b00_0001
`define Funct_Mfhi    6'b01_0000
`define Funct_Mflo    6'b01_0010
`define Funct_Movn    6'b00_1011
`define Funct_Movz    6'b00_1010
`define Funct_Msub    6'b00_0100    
`define Funct_Msubu   6'b00_0101
`define Funct_Mthi    6'b01_0001
`define Funct_Mtlo    6'b01_0011
`define Funct_Mul     6'b00_0010    
`define Funct_Mult    6'b01_1000
`define Funct_Multu   6'b01_1001
`define Funct_Nor     6'b10_0111
`define Funct_Or      6'b10_0101
`define Funct_Sll     6'b00_0000
`define Funct_Sllv    6'b00_0100
`define Funct_Slt     6'b10_1010
`define Funct_Sltu    6'b10_1011
`define Funct_Sra     6'b00_0011
`define Funct_Srav    6'b00_0111
`define Funct_Srl     6'b00_0010
`define Funct_Srlv    6'b00_0110
`define Funct_Sub     6'b10_0010
`define Funct_Subu    6'b10_0011
`define Funct_Syscall 6'b00_1100
`define Funct_Teq     6'b11_0100
`define Funct_Tge     6'b11_0000
`define Funct_Tgeu    6'b11_0001
`define Funct_Tlt     6'b11_0010
`define Funct_Tltu    6'b11_0011
`define Funct_Tne     6'b11_0110
`define Funct_Xor     6'b10_0110


/* Op Code Rt fields for Branches */
`define OpRt_Bgez   5'b00001
`define OpRt_Bgezal 5'b10001
`define OpRt_Bltz   5'b00000
`define OpRt_Bltzal 5'b10000


/*ALU set*/

`define ALUOp_Add  9'd01
`define ALUOp_Sub  9'd02
`define ALUOp_Nor  9'd03
`define ALUOp_Or   9'd04
`define ALUOp_And  9'd05
`define ALUOp_Xor  9'd06
`define ALUOp_Sll  9'd07
`define ALUOp_Srl  9'd08
`define ALUOp_Lui  9'd09
`define ALUOp_Clo  9'd10
`define ALUOp_Clz  9'd11

`define ALUOp_Lb  `ALUOp_Add
`define ALUOp_Lbu `ALUOp_Add
`define ALUOp_Lh  `ALUOp_Add
`define ALUOp_Lhu `ALUOp_Add 
`define ALUOp_Lw  `ALUOp_Add
`define ALUOp_Sb  `ALUOp_Add
`define ALUOp_Sh  `ALUOp_Add
`define ALUOp_Sw  `ALUOp_Add

`define Beq     4'd1
`define Bgez    4'd2
`define Bgezal  4'd3
`define Bgtz    4'd4
`define Blez    4'd5
`define Bltz    4'd6
`define Bltzal  4'd7
`define Bne     4'd8

/*
 RegW  =DataPath[0];
 RdSrc =DataPath[1];
 ALUSrc=DataPath[2];
 MemR  =DataPath[3];
 MemW  =DataPath[4];
 PCsrc =DataPath[6:5];
 Link  =DataPath[7];
 SelMOD=DataPath[9:8];
 MdataS=DataPath[10];
*/


`define Dp_Itype  11'b00000000111
`define Dp_Rtype  11'b00000000001
`define Dp_MRtype 11'b00000001001
`define Dp_MWtype 11'b00000010000

`define Dp_Btype  11'b00000100000
`define Dp_BLtype 11'b00010100001
`define Dp_Jtype  11'b00001000000
`define Dp_Jlink  11'b00011000001

/*Datapath set*/
`define Dp_Ori  `Dp_Itype
`define Dp_Andi `Dp_Itype
`define Dp_Addi `Dp_Itype
`define Dp_Xori `Dp_Itype
`define Dp_Xor  `Dp_Rtype
`define Dp_Add  `Dp_Rtype
`define Dp_Sub  `Dp_Rtype
`define Dp_Nor  `Dp_Rtype
`define Dp_Or   `Dp_Rtype
`define Dp_And  `Dp_Rtype
`define Dp_Xor  `Dp_Rtype
`define Dp_Sll   11'b0000000101
`define Dp_Srl   11'b0000000101

`define Dp_Lui  `Dp_Itype
`define Dp_Lb   `Dp_MRtype+11'b10000000000
`define Dp_Lbu  `Dp_MRtype+11'b00000000000
`define Dp_Lh   `Dp_MRtype+11'b10100000000
`define Dp_Lhu  `Dp_MRtype+11'b00100000000
`define Dp_Lw   `Dp_MRtype+11'b01000000000
`define Dp_Sb   `Dp_MWtype+11'b00000000000
`define Dp_Sh   `Dp_MWtype+11'b00100000000
`define Dp_Sw   `Dp_MWtype+11'b01000000000

`define Dp_Beq   `Dp_Btype
`define Dp_Bgez  `Dp_Btype
`define Dp_Bgezal`Dp_BLtype
`define Dp_Bgtz  `Dp_Btype
`define Dp_Blez  `Dp_Btype
`define Dp_Bltz  `Dp_Btype
`define Dp_Bltzal`Dp_BLtype
`define Dp_Bne   `Dp_Btype

`define Dp_J     `Dp_Jtype
`define Dp_Jal   `Dp_Jlink
`define Dp_Jr    11'b00001100000
`define Dp_Jalr  11'b00011100001
/*
assign ID_Wants_Rs=HazardDataPath[0];
assign ID_Needs_Rs=HazardDataPath[1];
assign ID_Wants_Rt=HazardDataPath[2];
assign ID_Needs_Rt=HazardDataPath[3];
assign EX_Wants_Rs=HazardDataPath[4];
assign EX_Needs_Rs=HazardDataPath[5];
assign EX_Wants_Rt=HazardDataPath[6];
assign EX_Needs_Rt=HazardDataPath[7];*/

/*Hazard Datapath set*/
`define HDP_none   8'b00000000
`define HDP_Itype  8'b00110011
`define HDP_Rtype  8'b11111111
`define HDP_MRtype 8'b11111111
`define HDP_MWtype 8'b11111111
`define HDP_Btype  8'b00000011

/*Datapath set*/
`define HDP_Ori  `HDP_Itype
`define HDP_Andi `HDP_Itype
`define HDP_Addi `HDP_Itype
`define HDP_Xori `HDP_Itype
`define HDP_Xor  `HDP_Rtype
`define HDP_Add  `HDP_Rtype
`define HDP_Sub  `HDP_Rtype
`define HDP_Nor  `HDP_Rtype
`define HDP_Or   `HDP_Rtype
`define HDP_And  `HDP_Rtype
`define HDP_Xor  `HDP_Rtype
`define HDP_Sll  `HDP_Rtype
`define HDP_Srl  `HDP_Rtype

`define HDP_Lui  `HDP_Itype
`define HDP_Lb   `HDP_MRtype
`define HDP_Lbu  `HDP_MRtype
`define HDP_Lh   `HDP_MRtype
`define HDP_Lhu  `HDP_MRtype
`define HDP_Lw   `HDP_MRtype
`define HDP_Sb   `HDP_MWtype
`define HDP_Sh   `HDP_MWtype
`define HDP_Sw   `HDP_MWtype

`define HDP_Beq   `HDP_Btype
`define HDP_Bgez  `HDP_Btype
`define HDP_Bgezal`HDP_Btype
`define HDP_Bgtz  `HDP_Btype
`define HDP_Blez  `HDP_Btype
`define HDP_Bltz  `HDP_Btype
`define HDP_Bltzal`HDP_Btype
`define HDP_Bne   8'b00001111

`define HDP_J     `HDP_none
`define HDP_Jal   `HDP_none
`define HDP_Jr    `HDP_Btype
`define HDP_Jalr  `HDP_Btype