//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 
// Student Name: Oskar Billington
// Date: June 2nd 2020
//
//  Description: In this exercise, you need to design an electronic dice, following
//  the diagram provided in the exercises documentation. The dice rolls as long as
//  a button is pressed, and stops when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           throw [2:0]
//
//  You need to write the whole file. 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module dice (
	// Declare ports
	input clk,
	input rst,
	input button,
	output [2:0] throw
	);

	// Initialise register
	reg [2:0] throw = 3'b0;

	// User logic
	always @ (posedge clk or posedge rst) begin
		if (rst)
			throw <= 3'b001; // Reset to 1
		else if (button)
			throw <= (throw % 6) + 1;
		else throw <= throw; // (Q1: Is this line necessary/correct/efficient?) If !button, do nothing. This line covers all possibilities.  

		// Q2: the code commented out below resulted in throw = 001 for any combination of inputs. Issue with simultaneous-ness? The above solution doesn't explicitly perform the (000 | 001) ->001 specified in the task.

		/*if (throw == 3'b000 || throw == 3'b111) // Reset always if out of bound
			throw <= 3'b001;
		else throw <= throw;*/
	end




endmodule
