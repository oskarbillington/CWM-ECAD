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
	output wire [5:0] result
	);

		
	// Intermediate wires for full 32-bit read-output
	wire [31:0] s_axi_rdata;
	assign result[5:0] = s_axi_rdata[5:0]; // Connect wires
	always @ (posedge clk) begin
		$display("Read data = %b. Address read-ready =  %b, read-valid = %b",s_axi_rdata,a5,a6);
	end

	wire a1,a2,a3,a4,a5,a6, a9;
	wire [1:0] a7, a8;
	
	// Instantiate BMEM with AXI4-lite interface
	BMEM_AXI4 b0 [31:0] (
  		.rsta_busy(a1),          // output wire rsta_busy
  		.rstb_busy(a2),          // output wire rstb_busy
  		.s_aclk(clk),                // input wire s_aclk
  		.s_aresetn(!rst),          // input wire s_aresetn
  		.s_axi_awaddr(32'b0),    // input wire [31 : 0] s_axi_awaddr
  		.s_axi_awvalid(1),  // input wire s_axi_awvalid
  		.s_axi_awready(a9),  // output wire s_axi_awready
  		.s_axi_wdata(32'b0),      // input wire [31 : 0] s_axi_wdata
  		.s_axi_wstrb(4'b0),      // input wire [3 : 0] s_axi_wstrb
  		.s_axi_wvalid(1),    // input wire s_axi_wvalid
  		.s_axi_wready(a3),    // output wire s_axi_wready
  		.s_axi_bresp(a7),      // output wire [1 : 0] s_axi_bresp
  		.s_axi_bvalid(a4),    // output wire s_axi_bvalid
  		.s_axi_bready(1),    // input wire s_axi_bready
  		.s_axi_araddr({24'b0, a, b, 2'b0}),    // input wire [31 : 0] s_axi_araddr
  		.s_axi_arvalid(1),  // input wire s_axi_arvalid
  		.s_axi_arready(a5),  // output wire s_axi_arready
  		.s_axi_rdata(s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
  		.s_axi_rresp(a8),      // output wire [1 : 0] s_axi_rresp
 		.s_axi_rvalid(a6),    // output wire s_axi_rvalid
  		.s_axi_rready(read)    // input wire s_axi_rready
		);


endmodule
