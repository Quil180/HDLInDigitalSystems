`timescale 1ns/1ps

// EEL4783: Final Project Part 2
// Project Title: "The 4-Element Dot Product Engine"
// Description: A pipelined 4-element dot product accelerator with handshake.
//              Stage 1: Multiplications (A_i * B_i)
//              Stage 2: Addition of products
// Latency: 2 clock cycles

module dot_product #(
    parameter int DATA_WIDTH = 8,
    parameter int VECTOR_SIZE = 4,
    parameter int OUT_WIDTH = 16
)(
    input  logic                      clk,
    input  logic                      rst,    // Active-high synchronous reset
    input  logic                      vld_in, // Input valid signal
    input  logic signed [DATA_WIDTH-1:0] a [VECTOR_SIZE-1:0],
    input  logic signed [DATA_WIDTH-1:0] b [VECTOR_SIZE-1:0],
    output logic                      vld_out,// Output valid signal
    output logic signed [OUT_WIDTH-1:0] y
);

    // Pipeline Registers
    logic signed [OUT_WIDTH-1:0] products_reg [VECTOR_SIZE-1:0];
    logic                      vld_pipe_reg;

    // Stage 1: Multiplication & Valid Propagation
    always_ff @(posedge clk) begin
        if (rst) begin
            vld_pipe_reg <= 1'b0;
            for (int i = 0; i < VECTOR_SIZE; i++) begin
                products_reg[i] <= '0;
            end
        end else begin
            vld_pipe_reg <= vld_in;
            for (int i = 0; i < VECTOR_SIZE; i++) begin
                products_reg[i] <= a[i] * b[i];
            end
        end
    end

    // Stage 2: Addition & Valid Propagation
    always_ff @(posedge clk) begin
        if (rst) begin
            vld_out <= 1'b0;
            y       <= '0;
        end else begin
            vld_out <= vld_pipe_reg;
            // Summing the registered products from Stage 1
            y <= products_reg[0] + products_reg[1] + products_reg[2] + products_reg[3];
        end
    end

endmodule
