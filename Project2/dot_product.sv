`timescale 1ns/1ps

// EEL4783: Final Project Part 2
// Project Title: "The 4-Element Dot Product Engine"
// Description: A pipelined 4-element dot product accelerator.
//              Stage 1: Multiplications (A_i * B_i)
//              Stage 2: Addition of products

module dot_product #(
    parameter int DATA_WIDTH = 8,
    parameter int VECTOR_SIZE = 4,
    parameter int OUT_WIDTH = 16
)(
    input  logic                      clk,
    input  logic                      rst, // Active-high synchronous reset
    input  logic signed [DATA_WIDTH-1:0] a [VECTOR_SIZE-1:0],
    input  logic signed [DATA_WIDTH-1:0] b [VECTOR_SIZE-1:0],
    output logic signed [OUT_WIDTH-1:0] y
);

    // Pipeline Registers
    // Stage 1 products: 8-bit * 8-bit = 16-bit
    logic signed [OUT_WIDTH-1:0] products_reg [VECTOR_SIZE-1:0];

    // Stage 1: Multiplication
    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < VECTOR_SIZE; i++) begin
                products_reg[i] <= '0;
            end
        end else begin
            for (int i = 0; i < VECTOR_SIZE; i++) begin
                products_reg[i] <= a[i] * b[i];
            end
        end
    end

    // Stage 2: Addition
    always_ff @(posedge clk) begin
        if (rst) begin
            y <= '0;
        end else begin
            // Summing the registered products
            y <= products_reg[0] + products_reg[1] + products_reg[2] + products_reg[3];
        end
    end

endmodule
