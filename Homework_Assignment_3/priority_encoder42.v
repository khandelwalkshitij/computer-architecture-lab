module tb_priority_encoder42();
	
	wire [1:0] Y;
	wire V;
	reg I0, I1, I2, I3;

	priority_encoder42 uut (Y, V, I0, I1, I2, I3);

	initial begin
		#0 I0 = 1'b1; I1 = 1'b0; I2 = 1'b0; I3 = 1'b0;  
		#10 I1 = 1'b1;
		#20 I3 = 1'b1;
		#20 I3 = 1'b0; I2 = 1'b1;
		#100 $finish;
	end

	initial begin
		$dumpfile("priority_encoder42.vcd");
		$dumpvars;
	end
endmodule

module priority_encoder42 (Y, V, I0, I1, I2, I3);

	output [1:0] Y;
	output V;
	input wire I0, I1, I2, I3;

	wire w1, w2;

	not N1(w1, I2);
	and A1(w2, w1, I1);
	or VALID(V, I0, I1, I2, I3);
	or YMSB(Y[1], I2, I3);
	or YLSB(Y[0], I3, w2);

endmodule