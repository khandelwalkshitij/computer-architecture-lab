//Synchronous Binary up-counter using structural modeling Style
//use of Negative Edge Triggered D flip flop with active high asynchronous reset
// Primitive Gates

`timescale 1ns/1ps

module tb_binary_counter();

reg rst,clock;
wire [3:0] out;

binary_counter uut(out,rst,clock);


always #10 clock = ~clock;
	
initial
	begin
	clock = 0; rst=0;
	#20 rst = 1;
	#40 rst = 0;
	#100 rst = 1;
	#40 rst = 0;
	#800 $stop;
	end
		
endmodule


module binary_counter (count, rst, clk);

input clk,rst;
output [3:0] count;

wire [3:0]cnt_b ; // has the negation of the count signals 
wire d2,d3,d4 ; // inputs to fliflops numbered 2,3,4 respectively 
wire w1,w2,w3,w4,w5 ; 

not I1 (cnt_b[0],count[0]);
not I2 (cnt_b[1],count[1]);
not I3 (cnt_b[2],count[2]);
not I4 (cnt_b[3],count[3]);

xor X1 (w5,count[0],count[1]); 
and A6 (d2,w5,cnt_b[3]); 

and A1 (w1,count[0],count[1]);
xor X2 (w2,count[2],w1);
and A2 (d3,cnt_b[3],w2);

and A3 (w3,count[3],cnt_b[2],cnt_b[1],cnt_b[0]);
and A4 (w4,cnt_b[3],count[2],count[1],count[0]);
or O1  (d4,w3,w4); 

dff_neg_async dff1 (count[0], cnt_b[0], clk, rst);
dff_neg_async dff2 (count[1], d2 , clk, rst);
dff_neg_async dff3 (count[2], d3 , clk, rst);
dff_neg_async dff4 (count[3], d4 , clk, rst);

endmodule

module dff_neg_async(q, d, clk, rst);

output reg q;
input d,clk,rst;

always @(negedge clk or posedge rst)
	begin
		if(rst) q <= 1'b0;
		else 	q <= d;
	end
endmodule

	
	