//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 
// Student Name: Oskar Billington
// Date: June 3rd 2020
//
//
//  Description: In this exercise, you need to design a multiplexer between a dice and traffic 
//  lights, where the output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | dice
//   1  | traffic lights
//
//  inputs:
//           rst, clk, button,sel
//
//  outputs:
//           result[2:0]
//
//////////////////////////////////////////////////////////////////////////////////

module dicelightselector (
	input rst,
	input clk,
	input button,
	input sel,
	output wire [2:0] result
	);

	wire [2:0] lights;
	wire [2:0] throw;

	// Instantiate modules
	trafficlight t0 [2:0] (.clk(clk), .red(lights[2]), .amber(lights[1]), .green(lights[0]));
 	dice d0 [2:0] (.clk(clk), .rst(rst), .button(button), .throw(throw));
 	mux m0 (.a(throw), .b(lights), .sel(sel), .out(result));


endmodule





