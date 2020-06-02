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
	input a,
	input b,
	input sel,
	output out
    );
    
    //Todo: define registers and wires here
	//reg out;
	wire out;	

    //Todo: define your logic here                
	
	/*			// Not sure what's the error here. Trying assign instead.
	always @ (*) begin
		<= #5;
		if (sel == 0)
			out = a;
		else if (sel == 1)
			out = b;
		else 
			out = -1; // Outputs -1 := error if sel is not boolean
	end	
 	*/

	assign #5 out = (sel == 0) ? a:
	 		(sel == 1) ? b:
			-1; // Outputs -1 := error if sel is not boolean	

      
endmodule
