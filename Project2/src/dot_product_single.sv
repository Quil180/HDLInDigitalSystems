`timescale 1ns/1ps

// EEL4783: Final Project Part 2
// Description: Single-cycle 4-element dot product engine with handshake.
//              Inputs and outputs are registered for timing.

module dot_product_single #(
    parameter int DATA_WIDTH = 8,
    parameter int VECTOR_SIZE = 4,
    parameter int OUT_WIDTH = 18
)(
    input  logic                      clk,
    input  logic                      rst,
    input  logic                      vld_in,
    input  logic signed [DATA_WIDTH-1:0] a [VECTOR_SIZE-1:0],
    input  logic signed [DATA_WIDTH-1:0] b [VECTOR_SIZE-1:0],
    output logic                      vld_out,
    output logic signed [OUT_WIDTH-1:0] y
);

    // Single cycle combinational logic with registered output
    always_ff @(posedge clk) begin
        if (rst) begin
            y       <= '0;
            vld_out <= 1'b0;
        end else begin
            vld_out <= vld_in;
            y <= (a[0] * b[0]) + (a[1] * b[1]) + (a[2] * b[2]) + (a[3] * b[3]);
        end
    end

endmodule
