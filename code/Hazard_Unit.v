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
input EX_MemR,

input [4:0]MEM_Rs,
input [4:0]MEM_Rt,
input [4:0]MEM_Rd,
input MEM_MemR,

input [4:0]WB_Rs,
input [4:0]WB_Rt,
input [4:0]WB_Rd,
input WB_MemR,


/*Fowarding Mux Sel*/

output [1:0]EX_Forwarding_SR1_Sel,
output [1:0]EX_Forwarding_SR2_Sel,

/* Stall */
output IF_Stall,
output ID_Stall,
output EX_Stall,
output MEM_Stall,
output WB_Stall
);



endmodule
