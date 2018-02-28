`timescale 1ns/10ps
//4-bit Ripple carry adder using structural modelling
//Full adder module built using dataflow modelling

module tb_ripple_adder();
	reg [3:0] a,b;
	wire [3:0] d;
	wire cout;
	ripple_adder uut(d,cout,a,b);
	
	initial
	begin
	#00 a=4'd10; b=4'd2;
	#20 a=4'd10; b=4'd10;
	#20 a=4'd3; b=4'd5;
	#20 a=4'd15; b=4'd15;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, a=%4b, b=%4b, d=%4b, cout=%1b",$time,a,b,d,cout);
	end
		
	initial
	begin
	$dumpfile("ripple_adder.vcd");
	$dumpvars;
	end
	
endmodule

module ripple_adder(d,cout,a,b);
	output [3:0] d;
	output cout;
	input [3:0] a,b;
	wire c0,c1,c2;
	full_adder f0(d[0],c0,a[0],b[0],1'b0);
	full_adder f1(d[1],c1,a[1],b[1],c0);
	full_adder f2(d[2],c2,a[2],b[2],c1);
	full_adder f3(d[3],cout,a[3],b[3],c2);
endmodule

module  full_adder(sum,cout,a,b,cin);
	output sum,cout;
	input a,b,cin;
	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
endmodule
