`timescale 1ns/10ps

module tb_bcd_updown();
	
	wire [7:0] count;
	reg clock, reset, control;

	bcd_updown uut (count, clock, reset, control);

	initial begin
		#00 clock = 1'b0;
		forever #10 clock = ~clock;
	end

	initial begin
		#00 reset = 1'b1; control = 1'b0;
		#10 reset = 1'b0;
		#10 reset = 1'b1;
		#1000 control = 1'b1;
		#1000 reset = 1'b0;
		#10 reset = 1'b1; 
		#1000 $finish;
	end

	initial begin
		$dumpfile("bcd_updown.vcd");
		$dumpvars;
	end

endmodule

module bcd_updown(count, clock, reset, control);

	output reg [7:0] count;
	input wire clock, reset, control;

	//Negative Edge Triggered Clock and Active Low Asynchronous Reset

	always @ (negedge clock or negedge reset)
	if (reset == 0)
			count <= 8'b0000_0000;
	else
		if (control == 1) //UP CONDITION	
			if (count == 8'b0101_1001)
				count <= 8'b0000_0000;
			else
				if (count[3:0] < 4'b1001)
					count <= count + 1;
				else begin
					count[7:4] <= count[7:4] + 1;
					count[3:0] <= 4'b0000;
				end
		else if (control == 0) //DOWN CONDITION
			if (count == 8'b0000_0000)
				count <= 8'b0101_1001; 
			else	
				if (count[3:0] > 4'b0000)
					count <= count - 1;
				else begin
					count[7:4] <= count[7:4] - 1;
					count[3:0] <= 4'b1001;
				end 
				
endmodule