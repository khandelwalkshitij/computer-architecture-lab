`timescale 1ns/10ps 
module tb_palindrome();

	wire out; 
	reg in , clk , rst; 

	palindrome uut (out, in, clk, rst);

	initial 
	begin 
	$dumpfile("palindrome.vcd"); 
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
	#2000 rst = 1'b0; #050 rst = 1'b1; #1050 rst = 1'b0;
	$finish;
	end 
endmodule

module palindrome (out, in, clk, rst);
	
	output reg out;
	input wire in, clk, rst;

	parameter idle = 3'b000;
	parameter det0 = 3'b001;
	parameter det1 = 3'b010;
	parameter det00 = 3'b011;
	parameter det01 = 3'b100;
	parameter det10 = 3'b101;
	parameter det11 = 3'b110;
	parameter pal = 3'b111;

	reg [2:0] NextState, CurrentState ; 

	// To update the state
	always @(posedge clk, negedge rst)
	begin 
		if(!rst) CurrentState <= idle ; 
		else     CurrentState <= NextState ;
	end

	// To calculate the next state
	always @ (*)
	begin
		case(CurrentState)
		idle	:	begin
						if(in) NextState <= det1;
						else NextState <= det0;
					end
		det0  	:	begin
						if(in) NextState <= det01;
						else NextState <= det00;
					end
		det1  	:	begin
						if(in) NextState <= det11;
						else NextState <= det10;
					end
		det00  	:	begin
						if(in) NextState <= det01;
						else NextState <= pal;
					end
		det01  	:	begin
						if(in) NextState <= det11;
						else NextState <= pal;
					end
		det10  	:	begin
						if(in) NextState <= pal;
						else NextState <= det00;
					end
		det11  	:	begin
						if(in) NextState <= pal;
						else NextState <= det10;
					end
		pal  	:	begin
						if(in) NextState <= det1;
						else NextState <= det0;
					end
		default :	NextState <= idle ;
		endcase
	end

	// Output Calculation
   always @(*)
   begin 
	   case(CurrentState)
	   idle		: out <= 1'b0 ;
	   det0 	: out <= 1'b0 ;
	   det1 	: out <= 1'b0 ;
	   det00 	: out <= 1'b0 ;
	   det10 	: out <= 1'b0 ;
	   det01 	: out <= 1'b0 ;
	   det11	: out <= 1'b0 ;
	   pal 		: out <= 1'b1 ; 
	   default 	: out <= 1'b0 ;  
	   endcase
   end
endmodule