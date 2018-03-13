// Kshitij Khandelwal
//2015A3PS0156P
module tb_seqgen();

	reg reset,clock;
	wire [3:0] out;

	seqgen uut(out,reset,clock);

	always #10 clock = ~clock;
		
	initial
		begin
		clock = 0; reset=0;
		#20 reset = 1;
		#40 reset = 0;
		#100 reset = 1;
		#40 reset = 0;
		#800 
		$stop;
		end
			
	initial
		begin
		$dumpfile("seqgen.vcd");
		$dumpvars;
		end
			
endmodule

module seqgen(out, reset, clk);
	input clk, reset;
	output reg [3:0] out;
	
	always @ (posedge clk)
		begin
				if(reset) out <= 4'b0000;
				else
					case(out)
						4'b0000: out <= 4'b0001;
						4'b0001: out <= 4'b0011;
						4'b0011: out <= 4'b0010;
						4'b0010: out <= 4'b0110;
						4'b0110: out <= 4'b0111;
						4'b0111: out <= 4'b0101;
						4'b0101: out <= 4'b0100;
						4'b0100: out <= 4'b1100;
						4'b1100: out <= 4'b1101;
						4'b1101: out <= 4'b1111;
						4'b1111: out <= 4'b1110;
						4'b1110: out <= 4'b1010;
						4'b1010: out <= 4'b1011;
						4'b1011: out <= 4'b1001;
						4'b1001: out <= 4'b1000;
						4'b1000: out <= 4'b0000;
						default: out <= 4'b0000;
					endcase
		end

endmodule