`timescale 1ns/10ps

module tb_half_adder(); 

reg x,y ; 
wire s,c ; 

half_adder uut (.sum(s),.carry(c),.a(x),.b(y));

initial 
begin 
#00 x=1'b0 ; y=1'b0 ; 
#20 x=1'b0 ; y=1'b1 ; 
#20 x=1'b1 ; y=1'b0 ; 
#20 x=1'b1 ; y=1'b1 ; 
#20 $stop ; 
end

initial $monitor("t=%3d, x=%b,y=%b,carry=%b,sum=%b",$time,x,y,c,s); 

initial
begin
$dumpfile("half_adder.vcd");
$dumpvars;
end
		
endmodule

module half_adder(sum,carry,a,b);

output sum,carry ;
input a,b ;

assign #15 sum 	= a ^ b ; 
assign #10 carry = a & b ;
endmodule