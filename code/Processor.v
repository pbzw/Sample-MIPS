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
/*IF stage*/

wire [31:0]PC_out,PC_in;
wire [31:0]PC_add_4;

assign inst_address=PC_out;
assign InstMem_Read=1'b1;

Add Add_pc(
.A(PC_out),
.B(32'd4),
.C(PC_add_4)
);

Register #(.WIDTH(32),.reset(32'h0000))PC(
.clk(clk),
.rst(rst),
.en(1'b1),
.data_in(PC_in),
.data_out(PC_out)
);

Mux2 #(.WIDTH(32))PCsrcMux(
.sel(1'b0),
.in0(PC_add_4),
.in1(),
.out(PC_in)
);

endmodule


