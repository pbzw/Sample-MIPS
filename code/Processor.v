// 2016.06.28
// File         : Processor.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  
//

`include "define.v"

module Processor(
input clk,
input rst,
// Instruction Memory
output[`data_lentgh-1:0]inst_address,
input [`data_lentgh-1:0]inst_in,
input InstMem_Ready,
output InstMem_Read,
//Data Memory 
output [3:0]  DataMem_Select,
output [`data_lentgh-1:0] DataMem_Address,
input  [`data_lentgh-1:0] ReadDataMem ,
output [`data_lentgh-1:0] WriteDataMem,
input DataMem_Ready,
output DataMem_access,DataMem_RW

);

/*IF Stage*/

wire [31:0]PC_out,PC_in;
wire [31:0]PC_add_4;
wire IF_Stall;

assign inst_address=PC_out;
assign InstMem_Read=1'b1;


/*ID Stage*/

wire ID_inst_en;
wire [31:0]ID_inst,ID_imm;
wire [31:0]ID_PC_Plus_4,ID_PC_Plus_8;
wire [31:0]ID_PC;
wire [31:0]ID_read_data1,ID_read_data2;
wire [31:0]Branch_Adder_out;
wire [31:0]Jump_Adder_out;
wire [3:0]ID_CmpMod;
wire [4:0]ID_Rs,ID_Rt,ID_Rd;
wire [8:0]ID_ALUop;
wire ID_RegW;
wire ID_ALUSrc;
wire ID_Link;
wire ID_MemR,ID_MdataS;
wire ID_MemW;
wire [1:0]ID_PCsrcSel,ID_SelMOD;
wire ID_Branch;

wire ID_Wants_Rs;
wire ID_Needs_Rs;
wire ID_Wants_Rt;
wire ID_Needs_Rt;
wire ID_EX_Wants_Rs;
wire ID_EX_Needs_Rs;
wire ID_EX_Wants_Rt;
wire ID_EX_Needs_Rt;
wire ID_Stall;

/*EX Stage*/
wire [31:0]EX_imm,EX_read_data1,EX_read_data2,EX_PC_Plus_8;
wire [31:0]Forwarding_Src1,Forwarding_Src2;
wire [31:0]EX_ALU_Result;
wire [31:0]ALUSrcMux_out;
wire [8:0]EX_ALUop;
wire [4:0]EX_Rt,EX_Rs,EX_Rd;
wire [1:0]EX_Forwarding_SR1_Sel,EX_Forwarding_SR2_Sel,EX_SelMOD;
wire EX_RegW;
wire EX_ALUSrc;
wire EX_MemR;
wire EX_MemW;
wire EX_Link,EX_MdataS;
wire EX_Wants_Rs;
wire EX_Needs_Rs;
wire EX_Wants_Rt;
wire EX_Needs_Rt;
wire EX_Stall;
wire EX_inst_en;
/*MEM Stage*/
wire [31:0] MEM_ALU_Result,Data_Unit_out,MEM_Src2;
wire [4:0]MEM_Rs,MEM_Rt,MEM_Rd;
wire [1:0]MEM_SelMOD;
wire MEM_RegW;
wire MEM_MemR;
wire MEM_MemW;
wire MEM_MdataS;

wire MEM_Stall;
wire MEM_inst_en;
/*WB Stage*/
wire [31:0]WB_ALU_Result,WB_MEM_Result;
wire [31:0]MEMtoRegMux_out;
wire [4:0]WB_Rs,WB_Rt,WB_Rd;
wire WB_RegW;
wire WB_MemR;
wire WB_MemW;

wire WB_Stall;
wire WB_inst_en;

Add Add_pc(
.A(PC_out),
.B(32'd4),
.C(PC_add_4)
);

Add Branch_Adder(
.A(ID_PC_Plus_4),
.B({ID_imm[29:0],2'b00}),
.C(Branch_Adder_out)
);

Register #(.WIDTH(32),.reset(32'h0000))PC(
.clk(clk),
.rst(rst),
.en((!IF_Stall)),
.data_in(PC_in),
.data_out(PC_out)
);
assign Jump_Adder_out={ID_PC_Plus_4[31:28],ID_inst[25:0],2'b00};

Mux4 #(.WIDTH(32))PCsrcMux(
.sel(ID_PCsrcSel),
.in0(PC_add_4),
.in1(Branch_Adder_out),
.in2(Jump_Adder_out),
.in3(ID_read_data1),
.out(PC_in)
);

IF_ID IF_ID(
.clk(clk),
.rst(rst),
.inst_en(InstMem_Ready),
.Stall(ID_Stall),
.flush(1'b0),

.IF_inst_in(inst_in),
.IF_PC_Plus_4(PC_add_4),

.ID_inst_en(ID_inst_en),
.ID_PC_Plus_4(ID_PC_Plus_4),
.ID_inst(ID_inst)
);

Control Control(

.Stall(ID_Stall),
.inst_in(ID_inst),
.inst_en(ID_inst_en),
.Branch(ID_Branch),

.Rdst(ID_Rd),
.Src1(ID_Rs),
.Src2(ID_Rt),

.ALUop(ID_ALUop),
.RegW(ID_RegW),
.ALUSrc(ID_ALUSrc),
.MemR(ID_MemR),
.MemW(ID_MemW),
.PCsrcSel(ID_PCsrcSel),
.Link(ID_Link),
.SelMOD(ID_SelMOD),
.MdataS(ID_MdataS),


.ID_Wants_Rs(ID_Wants_Rs),
.ID_Needs_Rs(ID_Needs_Rs),
.ID_Wants_Rt(ID_Wants_Rt),
.ID_Needs_Rt(ID_Needs_Rt),
.EX_Wants_Rs(ID_EX_Wants_Rs),
.EX_Needs_Rs(ID_EX_Needs_Rs),
.EX_Wants_Rt(ID_EX_Wants_Rt),
.EX_Needs_Rt(ID_EX_Needs_Rt),

.Extend_imm(ID_imm),
.CmpMod(ID_CmpMod)
);

regfile #(.WIDTH(32),.DEPTH(32))regfile(
.clk(clk),
.we_1(WB_RegW),
.read_reg1(ID_Rs),
.read_reg2(ID_Rt),

.write_reg1(WB_Rd),
.write_reg1_data(MEMtoRegMux_out),

.read_out_1(ID_read_data1),
.read_out_2(ID_read_data2)
);

Compare Compare(
.Src1(ID_read_data1),
.Src2(ID_read_data2),
.mod(ID_CmpMod),
.Branch(ID_Branch)
);

Add AddPC_8(
.A(ID_PC_Plus_4),
.B(32'd4),
.C(ID_PC_Plus_8)
);

ID_EX ID_EX(
.clk(clk),
.rst(rst),
.Stall(EX_Stall),
.flush(1'b0),

.ID_PC_Plus_8(ID_PC_Plus_8),
.ID_inst_en(ID_inst_en&(!ID_Stall)),
.ID_imm(ID_imm),
.ID_read_data1(ID_read_data1),
.ID_read_data2(ID_read_data2),
.ID_ALUop(ID_ALUop),
.ID_Rdst(ID_Rd),
.ID_Rs(ID_Rs),
.ID_Rt(ID_Rt),
.ID_RegW(ID_RegW),
.ID_ALUSrc(ID_ALUSrc),
.ID_MemR(ID_MemR),
.ID_MemW(ID_MemW),
.ID_Link(ID_Link),
.ID_EX_Wants_Rs(ID_EX_Wants_Rs),
.ID_EX_Needs_Rs(ID_EX_Needs_Rs),
.ID_EX_Wants_Rt(ID_EX_Wants_Rt),
.ID_EX_Needs_Rt(ID_EX_Needs_Rt),
.ID_SelMOD(ID_SelMOD),
.ID_MdataS(ID_MdataS),

.EX_PC_Plus_8(EX_PC_Plus_8),
.EX_inst_en(EX_inst_en),
.EX_imm(EX_imm),
.EX_read_data1(EX_read_data1),
.EX_read_data2(EX_read_data2),
.EX_ALUop(EX_ALUop),
.EX_Rdst(EX_Rd),
.EX_Rs(EX_Rs),
.EX_Rt(EX_Rt),
.EX_RegW(EX_RegW),
.EX_ALUSrc(EX_ALUSrc),
.EX_MemR(EX_MemR),
.EX_MemW(EX_MemW),
.EX_Link(EX_Link),
.EX_SelMOD(EX_SelMOD),
.EX_MdataS(EX_MdataS),
.EX_Wants_Rs(EX_Wants_Rs),
.EX_Needs_Rs(EX_Needs_Rs),
.EX_Wants_Rt(EX_Wants_Rt),
.EX_Needs_Rt(EX_Needs_Rt)
);



Mux4 #(.WIDTH(32))Forwarding_Src1_Mux(
.sel(EX_Forwarding_SR1_Sel),
.in0(EX_read_data1),
.in1(MEM_ALU_Result),
.in2(MEMtoRegMux_out),
.in3(),
.out(Forwarding_Src1)
);
wire [31:0]LinkMux_out;

Mux2 #(.WIDTH(32))LinkMux(
.sel(EX_Link),
.in0(EX_read_data2),
.in1(EX_PC_Plus_8),
.out(LinkMux_out)
);

Mux4 #(.WIDTH(32))Forwarding_Src2_Mux(
.sel(EX_Forwarding_SR2_Sel),
.in0(LinkMux_out),
.in1(MEM_ALU_Result),
.in2(MEMtoRegMux_out),
.in3(),
.out(Forwarding_Src2)
);


Mux2 #(.WIDTH(32))ALUSrcMux(
.sel(EX_ALUSrc),
.in0(Forwarding_Src2),
.in1(EX_imm),
.out(ALUSrcMux_out)
);


ALU ALU(
.Src1(Forwarding_Src1),
.Src2(ALUSrcMux_out),
.Operation(EX_ALUop),
.Result(EX_ALU_Result)
);

EX_MEM EX_MEM(
.clk(clk),
.rst(rst),
.Stall(MEM_Stall),
.flush(1'b0),

.EX_Src2(Forwarding_Src2),
.EX_SelMOD(EX_SelMOD),
.EX_MdataS(EX_MdataS),
.EX_inst_en(EX_inst_en),
.EX_ALU_Result(EX_ALU_Result),
.EX_Rs(EX_Rs),
.EX_Rt(EX_Rt),
.EX_Rdst(EX_Rd),
.EX_RegW(EX_RegW),
.EX_MemR(EX_MemR),
.EX_MemW(EX_MemW),

.MEM_SelMOD(MEM_SelMOD),
.MEM_Src2(MEM_Src2),
.MEM_MdataS(MEM_MdataS),
.MEM_inst_en(MEM_inst_en),
.MEM_ALU_Result(MEM_ALU_Result),
.MEM_Rs(MEM_Rs),
.MEM_Rt(MEM_Rt),
.MEM_Rdst(MEM_Rd),
.MEM_RegW(MEM_RegW),
.MEM_MemR(MEM_MemR),
.MEM_MemW(MEM_MemW)
);

Data_Unit Data_Unit(
.SelMOD(MEM_SelMOD),
.Se(MEM_MdataS),
.in(ReadDataMem),
.out(Data_Unit_out),
.Sel(DataMem_Select)
);


assign DataMem_Address = MEM_ALU_Result;
assign DataMem_access  = MEM_MemW|MEM_MemR;
assign WriteDataMem    = MEM_Src2;
assign DataMem_RW      = MEM_MemW;

MEM_WB MEM_WB(
.clk(clk),
.rst(rst),
.Stall(WB_Stall),
.flush(1'b0),

.MEM_inst_en(MEM_inst_en),
.MEM_ALU_Result(MEM_ALU_Result),
.MEM_MEM_Result(Data_Unit_out),
.MEM_Rs(MEM_Rs),
.MEM_Rt(MEM_Rt),
.MEM_Rdst(MEM_Rd),
.MEM_RegW(MEM_RegW),
.MEM_MemR(MEM_MemR),
.MEM_MemW(MEM_MemW),


.WB_inst_en(),
.WB_ALU_Result(WB_ALU_Result),
.WB_MEM_Result(WB_MEM_Result),
.WB_Rs(WB_Rs),
.WB_Rt(WB_Rt),
.WB_Rdst(WB_Rd),
.WB_RegW(WB_RegW),
.WB_MemR(WB_MemR),
.WB_MemW(WB_MemW)
);


Mux2 #(.WIDTH(32))MEMtoRegMux(
.sel(WB_MemR),
.in0(WB_ALU_Result),
.in1(WB_MEM_Result),
.out(MEMtoRegMux_out)
);

Hazard_Unit Hazard_Unit(

.ID_Wants_Rs(ID_Wants_Rs),
.ID_Needs_Rs(ID_Needs_Rs),
.ID_Wants_Rt(ID_Wants_Rt),
.ID_Needs_Rt(ID_Needs_Rt),
.ID_Rs(ID_Rs),
.ID_Rt(ID_Rt),

.EX_Wants_Rs(EX_Wants_Rs),
.EX_Needs_Rs(EX_Needs_Rs),
.EX_Wants_Rt(EX_Wants_Rt),
.EX_Needs_Rt(EX_Needs_Rt),
.EX_Rs(EX_Rs),
.EX_Rt(EX_Rt),
.EX_Rd(EX_Rd),
.EX_RegW(EX_RegW),
.EX_MemR(EX_MemR),


.MEM_Rd(MEM_Rd),
.MEM_RegW(MEM_RegW),
.MEM_MemR(MEM_MemR),


.WB_Rd(WB_Rd),
.WB_RegW(WB_RegW),
.WB_MemR(WB_MemR),


/*Fowarding Mux Sel*/

.EX_Forwarding_SR1_Sel(EX_Forwarding_SR1_Sel),
.EX_Forwarding_SR2_Sel(EX_Forwarding_SR2_Sel),

/* Stall */
.IF_Stall(IF_Stall),
.ID_Stall(ID_Stall),
.EX_Stall(EX_Stall),
.MEM_Stall(MEM_Stall),
.WB_Stall(WB_Stall)
);


endmodule


