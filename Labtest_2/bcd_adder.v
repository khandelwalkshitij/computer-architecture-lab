// Kshitij Khandelwal
// 2015A3PS0156P
`timescale 10ns/1ps 

module tb_bcd_adder(); 
	reg [7:0] a, b;
	wire cout;
	wire [7:0] s;
	
	bcd_adder uut (cout,s,a,b);
	
	initial
		begin
		a = 8'b00100101; b = 8'b01010010;
		#10 a = 8'b10011001; b = 8'b10001000;
		#10 a = 8'b10010011; b = 8'b00010010;
		end
		
	initial $monitor("t=%3d, a=%8b, b=%8b, cout=%b, s=%8b",$time,a,b,cout,s); 

	initial
		begin
		$dumpfile("bcd_adder.vcd");
		$dumpvars;
		end
endmodule 


module bcd_adder (cout,s,a,b); 
input [7:0] a, b; 
	output [7:0]s ; 
	output cout ; 
	wire [4:0] y1, y2;
	adder_4bit Add1 (y1, a[3:0], b[3:0]);
	adder_4bit Add2 (y2, a[7:4], b[7:4]);
	bcd_adjustment BAD (cout, s, y2, y1);
// structural style from the modules designed below
endmodule 


module adder_4bit(y,p,q);	
	input [3:0]p,q ; 
	output [4:0]y ;
	assign y = (((p+q)>=4'b0001)&(p[3]==0))?({((p+q)<4'b1001)?{1'b0, (p+q)}:{1'b1, ((p + q) + 4'b0110)}}):{1'b1, ((p + q) + 4'b0110)};
//use single assign statement for this addition; 
endmodule 


module bcd_adjustment(cout,y,p,q);
	input [4:0]p,q ; 
	output cout ; 
	output [7:0]y ; 
	assign y = {p[3:0] + {3'b000, q[4]}, q[3:0]};
	assign cout = p[4];
// use data flow modeling 
endmodule 