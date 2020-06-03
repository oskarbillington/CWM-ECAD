//////////////////////////////////////////////////////////////////////////////////
// Exercise #7
// Student Name: Oskar Billington
// Date: June 3rd 2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory.
//
//  inputs:
//           clk, a[2:0], b[2:0], read
//
//  outputs:
//           result[4:0]
//////////////////////////////////////////////////////////////////////////////////

module timestable (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input read,
	output wire [5:0] result
	);


	// Instantiate block memory
	BLOCKMEM m0 [5:0] (
  		.clka(clk),     	// input wire clka
 		.ena(read),     	// input wire ena
  		.wea(1'b0),		    // input wire [0 : 0] wea
  		.addra({a,b}),  	// input wire [5 : 0] addra
  		.dina(6'b0),  		// input wire [5 : 0] dina
  		.douta(result)   	// output wire [5 : 0] douta
		);


endmodule
