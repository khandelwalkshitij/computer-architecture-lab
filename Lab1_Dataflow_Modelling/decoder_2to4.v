`timescale 1ns/10ps

module tb_decoder_2to4();
	wire [3:0] d;
	reg a1,a0;
	decoder_2to4 uut(d,a1,a0);

	initial
		begin
		#00 a1=1'b0 ; a0=1'b0 ; 
		#20 a1=1'b0 ; a0=1'b1 ; 
		#20 a1=1'b1 ; a0=1'b0 ; 
		#20 a1=1'b1 ; a0=1'b1 ; 
		#20 $stop ; 
	end
		
	initial
		begin
		$monitor("time=%3d, a1=%b, a0=%b, d=%2b",$time,a1,a0,d);
	end

	initial
		begin
		$dumpfile("decoder_2to4.vcd");
		$dumpvars;
	end

endmodule

module decoder_2to4(y,a1,a0);

	output [3:0] y;
	input a1,a0;

	assign y[0] = (~a0)&(~a1);
	assign y[1] = (a0)&(~a1);
	assign y[2] = (~a0)&(a1);
	assign y[3] = (a0)&(a1);

endmodule

