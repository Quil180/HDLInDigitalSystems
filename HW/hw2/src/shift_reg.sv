`timescale 1ns / 10ps

module shift_reg #(
    parameter DATA_W = 8
) (
    input logic clk,
    reset,
    shift_en,
    input logic [DATA_W-1:0] data_in,
    output logic [DATA_W-1:0] data_out
);

  // Array of registers for internal stages as hinted
  logic [DATA_W-1:0] stages[3:0];

  always_ff @(posedge clk) begin
    if (reset) begin
      stages[0] <= '0;
      stages[1] <= '0;
      stages[2] <= '0;
      stages[3] <= '0;
    end else if (shift_en) begin
      stages[0] <= data_in;
      stages[1] <= stages[0];
      stages[2] <= stages[1];
      stages[3] <= stages[2];
    end
    // If shift_en == 0, state is naturally held in always_ff
  end

  // Continuous assignment to the output port
  assign data_out = stages[3];

endmodule
