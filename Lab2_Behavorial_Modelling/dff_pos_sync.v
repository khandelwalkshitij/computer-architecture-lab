//Positive edge triggered D flip flop with Active high synchronous reset
`timescale 1ns/10ps

module tb_dff_pos_sync();

reg d,clk,rst;
wire q;

dff_pos_sync uut(.q(q),.d(d),.clk(clk),.rst(rst));
	
initial
begin
#00 clk = 1'b0;
forever #50 clk = ~clk;
end
	
initial
begin
#00 rst=1'b0;
#70 rst=1'b1;
#100 rst=1'b0;
#500 rst=1'b1;
#300 rst=1'b0;
end
	
initial
begin
#000 d <= 1'b1;
#180 d <= 1'b0;
#100 d <= 1'b1;
#180 d <= 1'b0;
#100 d <= 1'b1;
end
		
initial
begin
$dumpfile("dff_pos_sync.vcd");
$dumpvars;
end
		
initial #1500 $stop;
		
endmodule


module dff_pos_sync(q, d, clk, rst);

output reg q;
input d,clk,rst;
	
always @(posedge clk)
begin
if(rst)
q <= 1'b0;
else 
q <= d;
end

endmodule

			