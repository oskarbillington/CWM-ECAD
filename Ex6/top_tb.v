//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - Dice or Traffic Lights?
// Student Name: Oskar Billington
// Date: June 3rd 2020
//
// Description: A testbench module to test Ex6 - Dice or Traffic Lights?
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

	// Parameters
	parameter CLK_PERIOD = 10;

	// Registers and wires
	reg clk, rst, button, sel, err;
	reg [2:0] solution;
	wire [2:0] mux_out;

	// Clock generation
	initial begin clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// Instantiate selector module
	dicelightselector s0 [2:0] (.clk(clk), .rst(rst), .button(button), .sel(sel), .result(mux_out));
 

	// User logic
	initial begin
		button = 0;
		sel = 0;
		err = 0;

		// Test sequence:
		rst = 1; 
		#CLK_PERIOD // Initialise dice = 001, lights = 100
		rst = 0; 
		solution = 3'b001; // dice is selected
		$display("Step1: Output = %b", mux_out);
		if (mux_out !== solution) begin
			err = 1;
			$display("***Error in Step1***");
		end			
		
		button = 1;
		#CLK_PERIOD // dice = 010, lights = 110
		solution = 3'b010; // dice is selected
		$display("Step2: Output = %b", mux_out);
		if (mux_out !== solution) begin
			err = 1;
			$display("***Error in Step2***");
		end		

		sel = 1; 
		#CLK_PERIOD // dice = 011, lights = 001
		solution = 3'b001; // lights is selected
		$display("Step3: Output = %b", mux_out);
		if (mux_out !== solution) begin
			err = 1;
			$display("***Error in Step3***");
		end		

		sel = 0;
		#1 // I want to see both possible mux outputs within the same clock tick
		solution = 3'b011; // dice is selected
		$display("Step4: Output = %b", mux_out);
		if (mux_out !== solution) begin
			err = 1;
			$display("***Error in Step4***");
		end	

		// Finish test, check for success:
		if (err == 0) begin
			$display("***TEST PASSED***");
			$finish;
		end
		else begin
			$display("***TEST FAILED***");
			$finish;
		end

	end



endmodule
