//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Electronic Dice
// Student Name: Oskar Billington	
// Date: June 2nd 2020
//
// Description: A testbench module to test Ex4 - Electronic Dice
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	// Parameters
	parameter CLK_PERIOD = 10;	

	// Registers and wires
	reg clk, rst, button, err;
	reg [2:0] solution;
	wire [2:0] out;

	// Clock generation
	initial begin clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// Instantiate dice module
	dice d0 [2:0] (.clk(clk), .rst(rst), .button(button), .throw(out));
 

	// User logic
	initial begin
		err = 0;

		// Test sequence:	
		rst = 1; #1 // Reset to initialise, shouldn't have to be in sync with clk
		rst = 0; #1
		solution = 3'b001;
		$display("Step1: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step1***");
		end

		button = 1; 
		#(4*CLK_PERIOD) // Roll dice
		button = 0;
		solution = 3'b101;
		$display("Step2: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step2***");
		end

		button = 1; 
		#(13*CLK_PERIOD) // Roll dice
		button = 0;
		solution = 3'b110;
		$display("Step3: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step3***");
		end
	
		rst = 1; #1 // Reset
		solution = 3'b001;
		$display("Step4: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step4***");
		end

		button = 1; // Roll while reset is on
		#(3*CLK_PERIOD) 
		solution = 3'b001;
		$display("Step5: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step5***");
		end
		rst = 0;
		button = 0;

		#(3*CLK_PERIOD) // Roll while button is off
		solution = 3'b001;
		$display("Step6: Throw = %b",out);
		if (out != solution) begin
			err = 1;
			$display("***Error in Step6***");
		end			
			


		// Finish test, check for success
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
