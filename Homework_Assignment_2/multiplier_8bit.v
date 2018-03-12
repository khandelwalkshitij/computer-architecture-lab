`timescale 1ns/10ps

module tb_multiplier_8bit();

	reg [7:0] A,B ;
	reg clock, reset;
	wire [15:0] prod;
	wire eop;
	
	multiplier_8bit uut (.prod(prod),.eop(eop),.A(A),.B(B),.clock(clock),.reset(reset));

	always #10 clock = ~clock;

	initial 
	begin
		#00 clock = 1'b0; reset = 1;
		#00 A = 8'b0000_1111 ; B = 8'b0000_1111 ; reset = 0;
		
		#120 $stop ; 
	end

	initial $monitor("t=%3d, A=%b,B=%b,reset=%b,clock=%b,prod=%b eop=%b",$time,A,B,reset,clock, prod, eop); 

	initial
	begin
		$dumpfile("multiplier_8bit.vcd");
		$dumpvars;
	end
endmodule

module multiplier_8bit(prod, eop, A, B, clock, reset);
	//Using the Shift-Add Multiplication Algorithm and Behavioural Modelling
	
	input [7:0] A,B;
	input clock, reset;
	output reg [15:0] prod;
	output reg eop;
	reg [3:0] count;
	reg [7:0] partprod;
	
	//Negative Edge Triggered Clock and Active High Asynchronous Reset
	always @ (negedge clock or posedge reset)
	begin
		if(reset)
		begin
			prod = 16'b0000_0000_0000_0000;
			count = 0;
			eop = 0;
		end
		else
		begin
			if (count < 4)
			begin
				eop = 0;
				begin
					if (B[count] == 1)
						partprod = A;
					else 
						partprod = 8'b00000000;
				end
				prod = {prod[14:0],1'b0};
				prod = prod + partprod;
				count = count+1;
			end
			else
			begin
				eop = 1;
				count = 0;
			end
		end
	end

endmodule