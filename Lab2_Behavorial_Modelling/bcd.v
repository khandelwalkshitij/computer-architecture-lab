//positive edge triggered BCD counter with active high asynchronous reset

`timescale 1ns/1ps

module bcd_tb();

reg rst,up_down,clock;
wire [3:0] out;

bcd uut(out,rst,up_down,clock);


always #10 clock = ~clock;
	
initial
begin
#00	clock = 1'b0;
#10	rst=1'b1;
#00 up_down=1'b1;
#20 rst = 1'b0;
#400 up_down = 1'b0;
#40 rst= 1'b1;
#60 $stop;
end


initial
begin
$dumpfile("bcd.vcd");
$dumpvars;
end
		
endmodule


module bcd(out, rst, up_down, clock);

output reg [3:0] out;
input rst, up_down,clock;

always @(posedge clock or posedge rst)
begin
	if(rst)
	out <= 4'b0000;
	else if(up_down==1)
			if(out==4'b1001)
				out <= 4'b0000;
			else
				out <= out+4'b0001;
		else
			if(out==4'b0000)
				out <= 4'b1001;
			else
				out <= out-4'b0001;
	end
endmodule

	
	


