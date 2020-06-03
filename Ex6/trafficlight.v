//////////////////////////////////////////////////////////////////////////////////
// Exercise #5
// Student Name: Oskar Billington
// Date: June 2nd 2020
//
//  Description: In this exercise, you need to implement a UK traffic lights
//  sequencing system.
//
//  inputs:
//           clk
//
//  outputs:
//           red, amber, green
//////////////////////////////////////////////////////////////////////////////////

module trafficlight(
input clk,
output reg red, amber, green
);


always @ (posedge clk) begin // I'm just going to hard-code the 4 possible states...:
if (red && !amber && !green) begin
red <= 1; amber <= 1; green <= 0; end
else if (red && amber && !green) begin
red <= 0; amber <= 0; green <= 1; end
else if (!red && !amber && green) begin
red <= 0; amber <= 1; green <= 0; end
else if (!red && amber && !green) begin
red <= 1; amber <= 0; green <= 0; end
else begin // e.g. if in an unwanted state or not yet initialised
red <= 1; amber <= 0; green <= 0; end // Start at red to be safe

end



endmodule
