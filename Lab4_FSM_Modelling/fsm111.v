`timescale 1ns/10ps 
module tb_fsm111();

reg in , clk , rst ; 
wire out ; 

fsm111 uut (.z(out) ,.y(in) ,.clk(clk),.rst(rst));

initial 
begin 
$dumpfile("fsm111.vcd"); 
$dumpvars; 
end

initial 
begin 
#00 clk <= 1'b0 ; 
forever #50 clk <= ~ clk ; 
end

initial forever #100 in = $random %2 ; 

initial 
begin 
#0000 rst = 1'b1; #0050 rst = 1'b0; #0050 rst = 1'b1; 
#2000 rst = 1'b0; #0050 rst = 1'b1;
end 
endmodule


module fsm111(z,y,clk,rst);
// MOORE type FSM
output reg z ; 
input y,clk,rst ;

// assign names to the states  
parameter idle =2'b00 , got1 = 2'b01, got11 = 2'b11, got111 = 2'b10 ; 

//declare two state registers
reg [1:0] NextState, CurrentState ; 

// To update the state
always @(posedge clk, negedge rst)
begin 
if(!rst) CurrentState <= idle ; 
else     CurrentState <= NextState ;
end

//To calculate the next state
always @(*)
begin 
case(CurrentState)
2'b00   :begin 
            if(y) NextState <= got1 ; 
            else NextState <= idle ;
         end
2'b01   :begin 
            if(y) NextState <= got11 ; 
            else NextState <= idle ;
         end
2'b11   :begin 
            if(y) NextState <= got111 ; 
            else NextState <= idle ;
         end
2'b10   :begin 
            if(y) NextState <= got1 ; 
            else NextState <= idle ;
         end
default : NextState <= idle ;
endcase  
end

// Output Calculation in MOORE it is only state dependent
always @(*)
begin 
case(CurrentState)
2'b00   : z <= 1'b0 ;
2'b01   : z <= 1'b0 ;
2'b11   : z <= 1'b0 ; 
2'b10   : z <= 1'b1 ; 
default : z <= 1'b0 ;  
endcase
end

endmodule 


