`timescale 1ns/10ps

module tb_full_adder();

	reg a,b,cin;
	wire sum,cout;

	full_adder uut(sum,cout,a,b,cin);

	initial
	begin
	#00 a=1'b0 ; b=1'b0 ; cin=1'b0 ;
	#20 a=1'b0 ; b=1'b1 ; cin=1'b0 ;
	#20 a=1'b1 ; b=1'b0 ; cin=1'b0 ;
	#20 a=1'b1 ; b=1'b1 ; cin=1'b0 ;
	#20 a=1'b0 ; b=1'b0 ; cin=1'b1 ;
	#20 a=1'b0 ; b=1'b1 ; cin=1'b1 ;
	#20 a=1'b1 ; b=1'b0 ; cin=1'b1 ;
	#20 a=1'b1 ; b=1'b1 ; cin=1'b1 ;
	#20	$stop;
	end

	//for display
	initial
	begin
	$monitor("time=%3d, a=%b, b=%b, cin=%b, cout=%b, sum=%b ",$time,a,b,cin,cout,sum);
	end

	//for gtkwave
	initial
	begin
	$dumpfile("full_adder.vcd");
	$dumpvars;
	end
endmodule

module  full_adder(sum,cout,a,b,cin);

	output sum,cout;
	input a,b,cin;

	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
	//assign {cout,sum}=a+b+cin;
	//The above statements de-concatenates the two bit result of the addition and stores the MSB to cout and LSB to sum

endmodule

