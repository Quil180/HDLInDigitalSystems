module pipelined (
    input clk,
    input reset,
    input [7:0] x_in,
    output reg [7:0] x_out
);
  reg [7:0] stage1_reg, stage2_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      stage1_reg <= 8'd0;
      stage2_reg <= 8'd0;
      x_out      <= 8'd0;
    end else begin
      // Stage 1: x1 = 2*x_in + 1
      stage1_reg <= (x_in << 1) + 8'd1;
      // Stage 2: x2 = 2*stage1 + 1
      stage2_reg <= (stage1_reg << 1) + 8'd1;
      // Stage 3: x3 = 2*stage2 + 1
      x_out      <= (stage2_reg << 1) + 8'd1;
    end
  end
endmodule
