`timescale 1ns/10ps
//Negative edge triggered D flip flop with Active high asynchronous reset

module tb_dff_neg_async();

reg d,clk,rst;
wire q;

dff_neg_async uut(.q(q),.d(d),.clk(clk),.rst(rst));

// a clock with 100ns 50% duty cycle 	
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
#100 rst=1'b0;
end
	
	
initial
begin
#000 d <= 1'b1;
#180 d <= 1'b0;
#100 d <= 1'b1;
#120 d <= 1'b0;
end

initial
begin
$dumpfile("dff_neg_async.vcd");
$dumpvars;
end
		
initial
begin
#1500 $stop;
end
endmodule


module dff_neg_async(q, d, clk, rst);

output reg q;
input d,clk,rst;

always @(negedge clk or posedge rst)
	begin
	if(rst)
	q <= 1'd0;
	else 
	q <= d;
	end
endmodule

