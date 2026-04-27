`timescale 1ns/1ps

module dot_product_single #(
    parameter int DATA_WIDTH = 8,
    parameter int VECTOR_SIZE = 4,
    parameter int OUT_WIDTH = 16
)(
    input  logic                      clk,
    input  logic                      rst,
    input  logic signed [DATA_WIDTH-1:0] a [VECTOR_SIZE-1:0],
    input  logic signed [DATA_WIDTH-1:0] b [VECTOR_SIZE-1:0],
    output logic signed [OUT_WIDTH-1:0] y
);

    // Single-cycle combinational dot product with registered output
    always_ff @(posedge clk) begin
        if (rst) begin
            y <= '0;
        end else begin
            y <= (a[0] * b[0]) + (a[1] * b[1]) + (a[2] * b[2]) + (a[3] * b[3]);
        end
    end

endmodule
