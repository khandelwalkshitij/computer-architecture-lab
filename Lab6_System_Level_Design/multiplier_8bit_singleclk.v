module tb_multiplier_8bit_singleclk();
	reg [7:0] A,B ;
	wire [15:0] prod;
	
	multiplier_8bit_singleclk uut (prod, A, B);

	initial 
	begin
		#00 A = 8'b0000_1111 ; B = 8'b0110_1111;
		#20 A = 8'b1111_1111 ; B = 8'b1001_0110;
		#20 A = 8'b0001_1000 ; B = 8'b1010_1011;
		#20 A = 8'b1000_1101 ; B = 8'b1100_1110;
		#20 A = 8'b0001_0001 ; B = 8'b0000_0000;	
		#20 A = 8'b0100_1100 ; B = 8'b0011_1111;
		#120 $stop ; 
	end

	initial $monitor("t=%3d, A=%b,B=%b,prod=%b",$time,A,B,prod); 

	initial
	begin
		$dumpfile("multiplier_8bit_singleclk.vcd");
		$dumpvars;
	end
endmodule

module multiplier_8bit_singleclk(prod, a, b);
	output [15:0] prod;
	input [7:0] a, b;
	wire [7:0] partprod1, partprod2, partprod3, partprod4;
	four_bit_multiplier mult1 (partprod1, a[3:0], b[3:0]);
	four_bit_multiplier mult2 (partprod2, a[7:4], b[3:0]);
	four_bit_multiplier mult3 (partprod3, a[3:0], b[7:4]);
	four_bit_multiplier mult4 (partprod4, a[7:4], b[7:4]);
	paralleladder para (prod, partprod1, partprod2, partprod3, partprod4);

endmodule

module four_bit_multiplier(prod, aa, bb);
	output [7:0] prod;
	input [3:0] aa, bb;
	wire [3:0] partprod;
	wire [7:0] w1, w2, w3, w4;

	assign partprod = bb[0]?aa:4'b0000;
	assign w1 = {4'b0000, partprod};
	assign partprod = bb[1]?aa:4'b0000;
	assign w2 = w1 + {3'b000, partprod, 1'b0};
	assign partprod = bb[2]?aa:4'b0000;
	assign w3 = w2 + {2'b00, partprod, 2'b00};
	assign partprod = bb[3]?aa:4'b0000;
	assign w4 = w3 + {1'b0, partprod, 3'b000};
	assign prod = w4;
endmodule

module paralleladder(prod, partprod1, partprod2, partprod3, partprod4);
	output [15:0] prod;
	input [7:0] partprod1, partprod2, partprod3, partprod4;

	assign prod = {8'b0000_0000, partprod1} + {8'b0000_0000, partprod2} + {partprod3, 8'b0000_0000} + {partprod4, 8'b0000_0000};
endmodule
