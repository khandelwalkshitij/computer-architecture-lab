module tb_serial_adder();
	
	wire [3:0] out;
	reg [3:0] in1, in2;
	reg clk, rst, load;

	serial_adder uut (out, in1, in2, clk, rst, load);

	initial begin
		#00 clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial begin
		#00 in1 = 4'b0110; in2 = 4'b0111;
		#00 rst = 1'b1; load = 1'b0;
		#5 rst = 1'b0; load = 1'b1;
		#10 rst = 1'b1; load = 1'b0;
		#1000 $finish;
	end

	initial begin
		$dumpfile("serial_adder.vcd");
		$dumpvars;
	end
endmodule

module serial_adder(out, in1, in2, clk, rst, load);

	output [3:0] out;
	input wire [3:0] in1, in2;
	input wire clk, rst, load;

	wire data1, data2;
	wire sum;
	wire cout, cin;
	
	piso p1 (data1, in1, load, clk);
	piso p2 (data2, in2, load, clk);

	full_adder fa (sum, cout, data1, data2, cin);
	dff_neg_async dff (cin, cout, clk, rst);

	sipo s1 (out, sum, clk, rst);
endmodule

module dff_neg_async(q, d, clk, rst);

	output reg q;
	input d,clk,rst;

	always @(posedge clk or negedge rst)
		// Positive Edge Triggered Clock and Active Low Asynchronous reset.
		begin
			if(!rst) q <= 1'b0;
			else 	q <= d;
		end
endmodule

module full_adder(sum, cout, a, b, cin);

	output sum,cout;
	input a,b,cin;

	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
	//assign {cout,sum}=a+b+cin;
	//The above statements de-concatenates the two bit result of the addition and stores the MSB to cout and LSB to sum
endmodule

module piso (dataout, datain, load, clk);
	
	output reg dataout;
	input wire clk, load;
	input wire [3:0] datain;

	reg [3:0] hold;
	
	always @ (load)
				hold = datain;
	always @ (posedge clk)
	begin
		dataout <= hold[0];
		hold <= {1'b0, hold[3:1]};
	end
endmodule

module sipo (dataout, datain, clk, rst);
	
	output reg [3:0] dataout;
	input wire clk, rst;
	input wire datain;

	reg [3:0] hold;

	always @ (posedge clk or negedge rst)
	begin
		if (!rst)
			hold <= 4'b0000;
		else begin
			hold[0] <= datain;
			hold[1] <= hold[0];
			hold[2] <= hold[1];
			hold[3] <= hold[2];
		end
	end

	always @ (*)
		dataout = hold;
endmodule