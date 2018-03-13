//4:1 Multiplexer

`timescale 1ns/10ps

module tb_mux(); 

reg [1:0] s;
reg [3:0] i;
wire o;

mux uut (o,i,s);

initial 
begin 
#0 i=4'b0101 ;
#20 s=2'b00 ; 
#20 s=2'b01 ;
#20 s=2'b10 ;
#20 s=2'b11 ;
#20 i=4'b1001 ; s=2'b00 ; 
#20 s=2'b01 ;
#20 s=2'b10 ;
#20 s=2'b11 ;
#20 $stop ; 
end

initial $monitor("t=%3d, input=%4b, select=%2b, out=%b",$time,i,s,o); 

initial
begin
$dumpfile("mux.vcd");
$dumpvars;
end

endmodule

module mux(out,in,select);

output out;
input [3:0] in;
input [1:0] select;

reg out;
always @( select or in )
begin
	case(select)
		2'b00: out<=in[0];
		2'b01: out<=in[1];
		2'b10: out<=in[2];
		2'b11: out<=in[3];
		default: out<=4'bzzzz;
	endcase
end
endmodule



