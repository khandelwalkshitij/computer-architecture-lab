`timescale 1ns/10ps

module tb_ram_64B();

reg clk,rwb;
reg [5:0]adrb;
wire [7:0]dout;
wire [7:0]din;
reg [7:0] memory[0:63];

ram_64B uut (dout,din,clk,rwb,adrb);
two_comp utt (din,dout);

initial
begin
#00 clk <= 1'b0;
forever #50 clk <= ~ clk ;
end

initial
begin
#00 rwb <= 1'b1;
forever #100 rwb <= ~ rwb ;
end

initial
begin 
  adrb = 0;
  repeat( 64 ) 
  begin 
     #200 adrb = adrb + 8'd1;
     #200 adrb = adrb + 8'd1;
     #200 adrb = adrb + 8'd1;
     #200 adrb = adrb + 8'd1;
     #200 adrb = adrb + 8'd1;
     #200 adrb = adrb + 8'd1;
  end 
end 

initial
begin
$dumpfile("ram_64B.vcd");
$dumpvars;
end

initial #12800 $finish;

endmodule



module ram_64B(dout,din,clk,rwb,adrb);

input clk,rwb;
input [5:0]adrb;
output reg [7:0]dout;
input [7:0]din;
reg [7:0] memory[0:63];

initial $readmemh("data_64.txt",memory);
initial $writememh("data_64_op.txt",memory);

always@(posedge clk)
	begin
		if(rwb) dout <= memory[adrb];
		else memory[adrb] <= din;
	end
endmodule


module two_comp(comp, in);
output [7:0]comp;
input [7:0]in;
assign comp = ~in + 8'd1;
endmodule