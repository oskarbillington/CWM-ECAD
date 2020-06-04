//////////////////////////////////////////////////////////////////////////////////
// Exercise #9 
// Student Name: Oskar Billington
// Date: June 4th 2020
//
//  Description: In this exercise, you need to design a module that lights leds
//  at different frequencies
//
//  inputs:
//           rst_n, clk_n, clk_p, button
//
//  outputs:
//           led_0, led_1, led_2
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,
     //Todo: add all other ports besides clk_n and clk_p 
	input rst_n, button,
	output led_0, led_1, led_2
   );
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

//Add logic here
	reg [2:0] led;
	assign {led_2, led_1, led_0} = led;
	reg [31:0] count;

	always @ (posedge clk or posedge rst_n) begin
		if (rst_n || button) begin
			count <= 0;
			led <= 3'b0;
			end
		else if (count[20]) begin 
			led[0] <= ~led[0];
			count <= count + 1;
			end
		else if (count[21]) begin 
			led[1] <= ~led[1];
			count <= count + 1;
			end
		else if (count[22]) begin 
			led[2] <= ~led[2];
			count <= count + 1;
			end
		else if (count[31]) begin
			count <= 0;
			end
		else begin
			count <= count + 1;
			end
	end




endmodule



