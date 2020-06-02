//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Traffic Lights
// Student Name: Oskar Billington
// Date: June 2nd 2020
//
// Description: A testbench module to test Ex5 - Traffic Lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
);

// Parameters
parameter CLK_PERIOD = 10;

// Registers and wires
reg clk, err;
reg [2:0] solution;
wire [2:0] lights;

// Clock generation
initial begin clk = 1'b0;
forever #(CLK_PERIOD/2) clk = ~clk;
end

// Instantiate Traffic Lights module
trafficlight t0 [2:0] (.clk(clk), .red(lights[2]), .amber(lights[1]), .green(lights[0]));
 

// User logic
initial begin
err = 0;

// Test sequence:
#CLK_PERIOD // Turn on: should start at red
solution = 3'b100;
$display("Step1: Lights = %b",lights);
if (lights != solution) begin
err = 1;
$display("***Error in Step1***");
end

#CLK_PERIOD // Should go to red+amber
solution = 3'b110;
$display("Step2: Lights = %b",lights);
if (lights != solution) begin
err = 1;
$display("***Error in Step2***");
end

#CLK_PERIOD // Should go to green
solution = 3'b001;
$display("Step3: Lights = %b",lights);
if (lights != solution) begin
err = 1;
$display("***Error in Step3***");
end

#CLK_PERIOD // Should go to amber
solution = 3'b010;
$display("Step4: Lights = %b",lights);
if (lights != solution) begin
err = 1;
$display("***Error in Step4***");
end

#CLK_PERIOD // Should go to red again
solution = 3'b100;
$display("Step5: Lights = %b",lights);
if (lights != solution) begin
err = 1;
$display("***Error in Step5***");
end

#(6*CLK_PERIOD) // Let the lights roll for a bit: should now be green
solution = 3'b001;
$display("Step6: Lights = %b",lights);
if (lights != solution) begin
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