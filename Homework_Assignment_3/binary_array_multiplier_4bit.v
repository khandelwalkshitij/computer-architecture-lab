module tb_binary_array_multiplier_4bit();
	
	wire [7:0] out;
	reg [3:0] x, y;

	binary_array_multiplier_4bit uut (out, x, y);

	initial begin
		#00 x = 4'b1011; y = 4'b1110;
		#10 $finish;
	end

	initial begin
		$dumpfile("binary_array_multiplier_4bit.vcd");
		$dumpvars;
	end
endmodule

module binary_array_multiplier_4bit (out, x, y);
	output [7:0] out;
	input wire [3:0] x, y;

	wire [15:1] andout;
	wire [10:0] carry;
	wire [5:0] sum;

	/*
					v--		HA11 <-	FA11 <-	FA01 <-	HA01
			v--	FA22 <-	FA12 <-	FA02 <-	HA02
		FA23 <-	FA13 <-	FA03 <-	HA03
	*/

	and x0y0 (out[0], x[0], y[0]);
	and x1y0 (andout[1], x[1], y[0]);
	and x2y0 (andout[2], x[2], y[0]);
	and x3y0 (andout[3], x[3], y[0]);
	and x0y1 (andout[4], x[0], y[1]);
	and x1y1 (andout[5], x[1], y[1]);
	and x2y1 (andout[6], x[2], y[1]);
	and x3y1 (andout[7], x[3], y[1]);
	and x0y2 (andout[8], x[0], y[2]);
	and x1y2 (andout[9], x[1], y[2]);
	and x2y2 (andout[10], x[2], y[2]);
	and x3y2 (andout[11], x[3], y[2]);
	and x0y3 (andout[12], x[0], y[3]);
	and x1y3 (andout[13], x[1], y[3]);
	and x2y3 (andout[14], x[2], y[3]);
	and x3y3 (andout[15], x[3], y[3]);
	
	half_adder HA01 (out[1],carry[0],andout[1],andout[4]);
	half_adder HA11 (sum[2],carry[3],andout[7],carry[2]);
	half_adder HA02 (out[2],carry[4],sum[0], andout[8]);
	half_adder HA03 (out[3],carry[8],sum[3], andout[12]);

	full_adder FA01 (sum[0], carry[1], andout[2], andout[5], carry[0]);
	full_adder FA11 (sum[1], carry[2], andout[3], andout[6], carry[1]);
	full_adder FA02 (sum[3], carry[5], sum[1], andout[9], carry[4]);
	full_adder FA12 (sum[4], carry[6], sum[2], andout[10], carry[5]);
	full_adder FA22 (sum[5], carry[7], carry[3], andout[11], carry[6]);
	full_adder FA03 (out[4], carry[9], sum[4], andout[13], carry[8]);
	full_adder FA13 (out[5], carry[10], sum[5], andout[14], carry[9]);
	full_adder FA23 (out[6], out[7], carry[7], andout[15], carry[10]);

endmodule

module full_adder (sum, cout, a, b, cin);

	output sum, cout;
	input a,b,cin;

	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
	//assign {cout,sum}=a+b+cin;
	//The above statements de-concatenates the two bit result of the addition and stores the MSB to cout and LSB to sum
endmodule

module half_adder (sum,carry,a,b);

	output sum,carry ;
	input a,b ;

	assign sum 	= a ^ b; 
	assign carry = a & b;
endmodule