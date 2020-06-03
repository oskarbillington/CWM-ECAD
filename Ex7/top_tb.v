//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Times Table
// Student Name: Oskar Billington
// Date: June 3rd 2020
//
// Description: A testbench module to test Ex7 - Times Table
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

	parameter CLK_PERIOD = 10;

	reg clk, read, err;
	reg [2:0] fac1;
	reg [2:0] fac2;
	wire [5:0] product;
	reg [5:0] solution;

	initial begin clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// Instantiate timestable module
	timestable p0 [5:0] (.clk(clk), .read(read), .a(fac1), .b(fac2), .result(product));

	// User logic
	initial begin
		err = 0;
		
		// Test sequence: 
		fac1 = 1;
		fac2 = 2;  
		read = 1;
		#(2*CLK_PERIOD) // ***Q: It needs 2 clock ticks to return a result (else returns 0) - because it takes 1 tick to concatenate the inputs to form the address, or because physical RAM needs to load the address and then enable the content requiring 2 ticks? ***
		solution = 6'b000010;
		$display("Step1: Factor1 = %b, Factor2 = %b, Output = %b", fac1, fac2, product);
		if (product !== solution) begin
			err = 1;
			$display("***Error in Step1***");
		end		

		fac1 = 7;
		fac2 = 6;  
		#(2*CLK_PERIOD)		
		solution = fac1*fac2;
		$display("Step2: Factor1 = %b, Factor2 = %b, Output = %b", fac1, fac2, product);
		if (product !== solution) begin
			err = 1;
			$display("***Error in Step2***");
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
