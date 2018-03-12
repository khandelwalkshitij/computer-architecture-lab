// Your Name Here
// Your ID No. Here 
`timescale 10ns/1ps 

module tb_bcd_adder(); 
// fill this space 
endmodule 

module bcd_adder (cout,s,a,b); 

input [7:0]a,b ; 
output [7:0]s ; 
output cout ; 

// structural style from the modules designed below
endmodule 

module adder_4bit(y,p,q);
input [3:0]p,q ; 
output [4:0]y ; 

//use single assign statement for this addition; 
endmodule 


module bcd_adjustment(cout,y,p,q);
input [4:0]p,q ; 
output cout ; 
output [7:0]y ; 

// use data flow modeling 
endmodule 