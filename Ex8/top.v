//////////////////////////////////////////////////////////////////////////////////
// Exercise #8
// Student Name: Oskar Billington
// Date: June 4th 2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory and AXI-4-lite interface.
//
//  inputs:
//           clk, rst, a[2:0], b[2:0], read
//
//  outputs:
//           result[5:0]
//////////////////////////////////////////////////////////////////////////////////
module AXI_timestable (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input read, rst,
	output reg [5:0] result
	);

	wire [31:0] address_content;
	reg [31:0] address;
	reg master_ready, address_stable;
	wire data_available, slave_ready;

	// Logic
	always @(posedge clk) begin
		if (slave_ready && read) begin
			address = {26'b0, a, b};
			address_stable <= 1;
			master_ready <= 1;
			#1
			if (slave_ready && data_available) begin
				result <= address_content[5:0];
				$display("Address content = %b", address_content);
				#1 begin 
					address_stable <= 0;
					master_ready <= 0;
				end
			end
		end
	end
	
	// Instantiate BMEM with AXI4-lite interface
	BMEM_AXI4 b0 [31:0] (
  		.rsta_busy(),          // output wire rsta_busy
  		.rstb_busy(),          // output wire rstb_busy
  		.s_aclk(clk),                // input wire s_aclk
  		.s_aresetn(!rst),          // input wire s_aresetn
  		.s_axi_awaddr(32'b0),    // input wire [31 : 0] s_axi_awaddr
  		.s_axi_awvalid(0),  // input wire s_axi_awvalid
  		.s_axi_awready(),  // output wire s_axi_awready
  		.s_axi_wdata(32'b0),      // input wire [31 : 0] s_axi_wdata
  		.s_axi_wstrb(4'b0),      // input wire [3 : 0] s_axi_wstrb
  		.s_axi_wvalid(0),    // input wire s_axi_wvalid
  		.s_axi_wready(),    // output wire s_axi_wready
  		.s_axi_bresp(),      // output wire [1 : 0] s_axi_bresp
  		.s_axi_bvalid(),    // output wire s_axi_bvalid
  		.s_axi_bready(0),    // input wire s_axi_bready
  		.s_axi_araddr(address),    // input wire [31 : 0] s_axi_araddr
  		.s_axi_arvalid(address_stable),  // input wire s_axi_arvalid
  		.s_axi_arready(slave_ready),  // output wire s_axi_arready
  		.s_axi_rdata(address_content),      // output wire [31 : 0] s_axi_rdata
  		.s_axi_rresp(),      // output wire [1 : 0] s_axi_rresp
 		.s_axi_rvalid(data_available),    // output wire s_axi_rvalid
  		.s_axi_rready(master_ready)    // input wire s_axi_rready
		);


endmodule




