`timescale 1ns/10ps

module tb_divider_8bit();

	wire [7:0] quotient, remainder;
	wire eop;
	reg [7:0] divisor, dividend;
	reg clk, rst;

	divider_8bit uut (quotient, remainder, eop, divisor, dividend, clk, rst);

	initial begin
		#0 clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial begin
		$dumpfile("divider_8bit.vcd");
		$dumpvars;
	end

	initial begin 
		#00 clk = 1'b0; rst = 1'b0;
		#05 rst = 1'b1;
		#05 dividend = 8'b0100_1000; divisor = 8'b0000_1011; rst = 1'b0;
		#200 $finish;
	end

endmodule

module divider_8bit (quotient, remainder, eop, divisor, dividend, clk, rst);

	output reg [7:0] quotient, remainder;
	output reg eop;
	input wire [7:0] divisor, dividend;
	input wire clk, rst;
	
	reg [7:0] divd;
	//Negative Edge Triggered Clock and Active High Asynchronous Reset
	//Currently only for unsigned numbers
	always @ (dividend)
		divd = dividend;

	always @ (negedge clk or posedge rst)
	begin
		if(rst)
		begin
			quotient = 8'b0000_0000;
			remainder = 8'b0000_0000;
			eop = 1'b0;
			divd = dividend;
		end
		else if ((dividend[7] == 0) && (divisor[7]==0))
			if (divd >= divisor)
			begin
				eop = 0;
				divd = divd - divisor;
				quotient = quotient + 1;
				remainder = divd;
			end
			else eop = 1;
	end

	always @ (eop or negedge clk)
		if (eop)
			eop = 1'b0;
endmodule