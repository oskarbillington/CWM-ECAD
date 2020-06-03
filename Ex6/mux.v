//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 
// Student Name: Oskar Billington
// Date: June 1st 2020
//
//  Description: In this exercise, you need to design a multiplexer, where the  
//  output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module mux(
    //Todo: define inputs here
	input [2:0] a,
	input [2:0] b,
	input sel,
	output wire [2:0] out
    );
    
	
    //Todo: add user logic
	assign 	  out = (sel == 0) ? a:
	 		(sel == 1) ? b:
			-1; // Outputs -1 := error if sel is not boolean	

      
endmodule
