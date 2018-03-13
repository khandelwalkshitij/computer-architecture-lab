`timescale 1ns/10ps

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
	
output reg [3:0] out;
input [3:0] a,b;
input [2:0] op;

parameter sub 	= 3'b000 ;
parameter add 	= 3'b001 ;
parameter exor 	= 3'b010 ;
parameter andab = 3'b011 ;
parameter orab 	= 3'b100 ;
parameter shr 	= 3'b101 ;// shift right a by 1 bit 
parameter shl 	= 3'b110 ;// shift left a by 1 bit 
parameter sar 	= 3'b111 ;// arithmetic shift right a by 1 bit 

always @(*)
begin 
case(op)
sub		: out <= a-b ; 
add 	: out <= a+b ; 
exor	: out <= a^b ; 
andab 	: out <= a&b ;
orab	: out <= a|b ; 
shr		: out <= a >> 1'b1 ;
shl		: out <= a << 1'b1 ; 
sar		: out <= {a[3],a[3:1]} ; 
default: out <= 4'bzzzz ; 
endcase
end

endmodule 

