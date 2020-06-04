//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8 - Times Table using AXI interface
// Student Name: Oskar Billington
// Date: June 4th 2020
//
// Description: A testbench module to test Ex8 - Times Table using AXI4-Lite
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

	parameter CLK_PERIOD = 10;

	reg clk, read, rst, err;
	reg [2:0] fac1;
	reg [2:0] fac2;
	wire [5:0] product;
	reg [5:0] solution;

	initial begin clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// Instantiate timestable module
	AXI_timestable p0 [5:0] (.clk(clk), .rst(rst), .read(read), .a(fac1), .b(fac2), .result(product));

	// User logic
	initial begin
		rst = 0; 
		err = 0;
		read = 1;		

		// Test sequence: 
		fac1 = 1;
		fac2 = 2;
		#(2*CLK_PERIOD) // Latency of 2 ticks
		solution = 6'b000010;
		$display("Step1: Factor1 = %b, Factor2 = %b, Output = %b", fac1, fac2, product);
		if (product !== solution) begin
			err = 1;
			$display("***Error in Step1***");
		end		

		fac1 = 7;
		fac2 = 6;  
		#(2*CLK_PERIOD)		
		solution = fac1*fac2; // b101010
		$display("Step2: Factor1 = %b, Factor2 = %b, Output = %b", fac1, fac2, product);
		if (product !== solution) begin
			err = 1;
			$display("***Error in Step2***");
		end	

		fac1 = 3;
		fac2 = 4;  
		#(2*CLK_PERIOD)		
		solution = fac1*fac2; // b001100
		$display("Step3: Factor1 = %b, Factor2 = %b, Output = %b", fac1, fac2, product);
		if (product !== solution) begin
			err = 1;
			$display("***Error in Step3***");
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
