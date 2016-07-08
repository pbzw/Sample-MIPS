// 2016.06.28
// File         : Hazard_Unit.v
// Project      : Ssmple MIPS 
// Creator(s)   : Yang, Yu-Xiang (M10412034@yuntech.edu.tw)
// 
//
//
//  Description: Ssmple MIPS to compare Out of execution
//  


`include "define.v"

module Hazard_Unit(

input ID_Wants_Rs,
input ID_Needs_Rs,
input ID_Wants_Rt,
input ID_Needs_Rt,
input [4:0]ID_Rs,
input [4:0]ID_Rt,
//input [4:0]ID_Rd, ignored

input EX_Wants_Rs,
input EX_Needs_Rs,
input EX_Wants_Rt,
input EX_Needs_Rt,
input [4:0]EX_Rs,
input [4:0]EX_Rt,
input [4:0]EX_Rd,
input EX_RegW,
input EX_MemR,


input [4:0]MEM_Rd,
input MEM_RegW,
input MEM_MemR,


input [4:0]WB_Rd,
input WB_RegW,
input WB_MemR,


/*Fowarding Mux Sel*/

output reg[1:0]EX_Forwarding_SR1_Sel,
output reg[1:0]EX_Forwarding_SR2_Sel,

/* Stall */
output IF_Stall,
output ID_Stall,
output EX_Stall,
output MEM_Stall,
output WB_Stall
);
wire ID_EX_Rs_Match=(ID_Rs==EX_Rd)&(ID_Rs!=5'd0)&EX_RegW&ID_Needs_Rs;
wire ID_EX_Rt_Match=(ID_Rt==EX_Rd)&(ID_Rt!=5'd0)&EX_RegW&ID_Needs_Rt;

wire ID_MEM_Rs_Match=(ID_Rs==MEM_Rd)&(ID_Rs!=5'd0)&MEM_RegW&ID_Wants_Rs;
wire ID_MEM_Rt_Match=(ID_Rt==MEM_Rd)&(ID_Rt!=5'd0)&MEM_RegW&ID_Wants_Rt;

wire ID_WB_Rs_Match=(ID_Rs==WB_Rd)&(ID_Rs!=5'd0)&WB_RegW&ID_Wants_Rs;
wire ID_WB_Rt_Match=(ID_Rt==WB_Rd)&(ID_Rt!=5'd0)&WB_RegW&ID_Wants_Rt;

wire EX_MEM_Rs_Match=(EX_Rs==MEM_Rd)&(EX_Rs!=5'd0)&MEM_RegW&EX_Wants_Rs;
wire EX_MEM_Rt_Match=(EX_Rt==MEM_Rd)&(EX_Rt!=5'd0)&MEM_RegW&EX_Wants_Rt;

wire EX_WB_Rs_Match=(EX_Rs==WB_Rd)&(EX_Rs!=5'd0)&WB_RegW&EX_Wants_Rs;
wire EX_WB_Rt_Match=(EX_Rt==WB_Rd)&(EX_Rt!=5'd0)&WB_RegW&EX_Wants_Rt;

always@(*) begin
	case({EX_WB_Rs_Match,EX_MEM_Rs_Match})
	2'b00:EX_Forwarding_SR1_Sel<=2'b00;
	2'b01:EX_Forwarding_SR1_Sel<=2'b01;
	2'b10:EX_Forwarding_SR1_Sel<=2'b10;
	2'b11:EX_Forwarding_SR1_Sel<=2'b01;
	endcase
end

always@(*) begin
	case({EX_WB_Rt_Match,EX_MEM_Rt_Match})
	2'b00:EX_Forwarding_SR2_Sel<=2'b00;
	2'b01:EX_Forwarding_SR2_Sel<=2'b01;
	2'b10:EX_Forwarding_SR2_Sel<=2'b10;
	2'b11:EX_Forwarding_SR2_Sel<=2'b01;
	endcase
end


assign IF_Stall =ID_Stall;
assign ID_Stall =ID_WB_Rs_Match|ID_WB_Rt_Match|ID_EX_Rs_Match|ID_EX_Rt_Match|ID_MEM_Rs_Match|ID_MEM_Rt_Match|EX_Stall;
assign EX_Stall =(EX_MEM_Rs_Match|EX_MEM_Rt_Match)&MEM_MemR;
assign MEM_Stall=1'b0;
assign WB_Stall =1'b0;

endmodule
