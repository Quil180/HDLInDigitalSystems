module unpipelined (
    input clk,
    input reset,
    input [7:0] x_in,
    output reg [7:0] x_out
);
  wire [7:0] x1, x2, x3;

  // x = 2x + 1 is effectively (x << 1) + 1
  assign x1 = (x_in << 1) + 8'd1;
  assign x2 = (x1 << 1) + 8'd1;
  assign x3 = (x2 << 1) + 8'd1;

  always @(posedge clk or posedge reset) begin
    if (reset) x_out <= 8'd0;
    else x_out <= x3;
  end
endmodule
