`timescale 1ns/10ps

module tb_comparator_8bit(); 

	reg [7:0] A,B ;
	reg sign; 
	wire AeqB, AgtB, AltB ; 

	comparator_8bit uut (.AeqB(AeqB),.AgtB(AgtB),.AltB(AltB),.A(A),.B(B),.sign(sign));

	initial 
	begin 
		#00 A = 8'b00000000 ; B = 8'b0000_0000 ; sign = 0;
		#20 A = 8'b00001111 ; B = 8'b0000_1111 ; sign = 0;
		#20 A = 8'b11110000 ; B = 8'b0000_1111 ; sign = 0;
		#20 A = 8'b00111100 ; B = 8'b1110_0000 ; sign = 0;
		#20 A = 8'b11000011 ; B = 8'b1110_0000 ; sign = 1;
		#20 A = 8'b00100000 ; B = 8'b0000_0000 ; sign = 0;
		#20 A = 8'b00100000 ; B = 8'b0000_0000 ; sign = 0;
		#20 A = 8'b11100000 ; B = 8'b0000_0000 ; sign = 1;
		#20 A = 8'b11100111 ; B = 8'b0000_0000 ; sign = 1;
		#20 A = 8'b00000000 ; B = 8'b0000_0000 ; sign = 0;
		#20 A = 8'b00000000 ; B = 8'b0000_0000 ; sign = 1;
		#20 A = 8'b00001111 ; B = 8'b1000_0000 ; sign = 0;
		#20 A = 8'b00001111 ; B = 8'b1000_0000 ; sign = 1;
		#20 $stop ; 
	end

	initial $monitor("t=%3d, A=%b,B=%b,sign=%b,AeqB=%b,AgtB=%b AltB=%b",$time,A,B,sign,AeqB, AgtB, AltB); 

	initial
	begin
		$dumpfile("comparator_8bit.vcd");
		$dumpvars;
	end
		
endmodule

module comparator_8bit(AeqB, AgtB, AltB, A, B, sign);

	output AeqB, AgtB, AltB ;
	input [7:0] A, B ;
	input sign ;

	//Using Dataflow Modelling
	assign AeqB = (A==B)? 1 : 0 ; 
	assign AgtB = sign?(A[7]?(B[7]?(A<B):0):(B[7]?1:(A>B))):(A>B);
	assign AltB = sign?(A[7]?(B[7]?(A>B):1):(B[7]?0:(A<B))):(A<B);
endmodule