//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Up/Down counter
// Student Name: Oskar Billington
// Date: June 2nd 2020
//
// Description: A testbench module to test Ex3 - counter
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;

//Todo: Registers and wires
reg clk;
reg rst;
reg enable;
reg direction;
wire [7:0] out;
reg [7:0] solution;
reg err;

//Todo: Clock generation
initial begin
	clk = 1'b0;
forever
	#(CLK_PERIOD/2) clk = ~clk;
end

//Todo: User logic      
initial begin
	err = 0;

	// Test sequence:	
	rst = 1; #1 // Reset to initialise, shouldn't have to be in sync with clk
	rst = 0; #1
	solution = 8'b0;
	$display("Step1: Counter = %b",out);
	if (out != solution) begin
		err = 1;
		$display("***Error in Step1***");
	end

	direction = 1;
	enable = 1; 
	#(5*CLK_PERIOD) // Count for 5 periods
	enable = 0;
	solution = 8'b00000101;
	$display("Step2: Counter = %b",out);
	if (out != solution) begin
		err = 1;
		$display("***Error in Step2***");
	end

	direction = 0;
	enable = 1;
	#(3*CLK_PERIOD) // Count down for 3 periods
	enable = 0;
	solution = 8'b00000010;
	$display("Step3: Counter = %b",out);
	if (out != solution) begin
		err = 1;
		$display("***Error in Step3***");
	end

	rst = 1; #1 // Reset
	solution = 8'b0;
	$display("Step4: Counter = %b",out);
	if (out != solution) begin
		err = 1;
		$display("***Error in Step4***");
	end


//Todo: Finish test, check for success
	if (err == 0) begin
		$display("***TEST PASSED***");
		$finish;
	end	
	else begin
		$display("***TEST FAILED***");
		$finish;
	end	
end

//Todo: Instantiate counter module
counter a0 [7:0] (.clk(clk), .rst(rst), .enable(enable), .direction(direction), .counter_out(out));
 
endmodule 
