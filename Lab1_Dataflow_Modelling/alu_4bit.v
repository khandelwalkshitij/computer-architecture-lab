`timescale 1ns/10ps

`define sub 	= 3'b000
`define add 	= 3'b001 
`define exor 	= 3'b010
`define andab 	= 3'b011
`define orab 	= 3'b100
`define shr 	= 3'b101 // shift right a by 1 bit 
`define shl 	= 3'b110 // shift left a by 1 bit 
`define sar 	= 3'b111 // arithmetic shift right a by 1 bit 

module tb_alu_4bit();

wire [3:0] out;
reg [3:0] a,b;
reg [2:0] op;
alu_4bit uut(out,a,b,op);

initial
begin
#00  op=3'd0; a=4'd7; b=4'd3;
#20  op=3'd1; a=4'd7; b=4'd3;
#20  op=3'd2; a=4'd7; b=4'd3;
#20  op=3'd3; a=4'd7; b=4'd3;
#20  op=3'd4; a=4'd7; b=4'd3;
#20  op=3'd5; a=4'd7; b=4'd3;
#20  op=3'd6; a=4'd7; b=4'd3;
#20  op=3'd7; a=4'd7; b=4'd3;
#20  $stop;
end

initial
begin
$monitor("time=%3d, a=%4d, b=%4d, op=%3d, out=%7d",$time,a,b,op,out);
end
	
initial
begin
$dumpfile("alu_4bit.vcd");
$dumpvars;
end
endmodule
 
module alu_4bit(out,a,b,op);
	
output [3:0] out;
input [3:0] a,b;
input [2:0] op;

wire [3:0] y0,y1,y2,y3,y4,y5,y6,y7; 

assign y0 = a-b ; 
assign y1 = a+b ; 
assign y2 = a^b ; 
assign y3 = a&b ; 
assign y4 = a|b ; 
assign y5 = a >> 1'b1; 
assign y6 = a << 1'b1 ; 
assign y7 = {a[3],a[3:1]} ; 

assign out = op[2]?(op[1]?(op[0]?y7:y6):(op[0]?y5:y4)):(op[1]?(op[0]?y3:y2):(op[0]?y1:y0)); 
//what output is to be printed will be decided on the three bit opcode
endmodule 

