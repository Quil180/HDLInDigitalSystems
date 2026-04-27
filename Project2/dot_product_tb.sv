`timescale 1ns/1ps

// Transaction class for constrained randomization
class dot_product_transaction;
    rand bit signed [7:0] a [4];
    rand bit signed [7:0] b [4];

    // Constraint to occasionally test boundary values
    constraint boundary_values {
        foreach (a[i]) {
            a[i] dist {8'h7F := 1, 8'h80 := 1, [-127:126] := 10};
        }
        foreach (b[i]) {
            b[i] dist {8'h7F := 1, 8'h80 := 1, [-127:126] := 10};
        }
    }
endclass

module dot_product_tb;

    // Parameters
    parameter int DATA_WIDTH = 8;
    parameter int VECTOR_SIZE = 4;
    parameter int OUT_WIDTH = 16;
    parameter int CLK_PERIOD = 10;

    // Signals
    logic                      clk;
    logic                      rst;
    logic signed [DATA_WIDTH-1:0] a [VECTOR_SIZE-1:0];
    logic signed [DATA_WIDTH-1:0] b [VECTOR_SIZE-1:0];
    logic signed [OUT_WIDTH-1:0] y;

    // Instantiate DUT
    dot_product #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_SIZE(VECTOR_SIZE),
        .OUT_WIDTH(OUT_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Reference model function
    function signed [OUT_WIDTH-1:0] get_expected(
        logic signed [DATA_WIDTH-1:0] va [4],
        logic signed [DATA_WIDTH-1:0] vb [4]
    );
        longint sum = 0;
        for (int i = 0; i < 4; i++) begin
            sum += va[i] * vb[i];
        end
        return signed'(sum[15:0]);
    endfunction

    // Test sequence
    initial begin
        dot_product_transaction tr;
        tr = new();

        $display("\n[Time %0t] Simulation Started", $time);
        // Initialize
        rst <= 1;
        foreach (a[i]) a[i] <= 0;
        foreach (b[i]) b[i] <= 0;
        
        repeat (2) @(posedge clk);
        rst <= 0;
        @(posedge clk);

        // Run 20 randomized test cases
        $display("\nStarting Randomized Tests...");
        for (int i = 1; i <= 20; i++) begin
            if (!tr.randomize()) $fatal("Randomization failed");
            
            // Driving inputs with non-blocking assignments
            foreach (a[j]) a[j] <= tr.a[j];
            foreach (b[j]) b[j] <= tr.b[j];
            
            @(posedge clk);
            $display("[Time %0t] Iteration %0d/20: Inputs Sampled by DUT", $time, i);
        end

        // Wait for pipeline to drain
        repeat (5) @(posedge clk);
        
        $display("Done: 20 Randomized Tests Completed.");
        $finish;
    end

    // --- SystemVerilog Assertions (Extra Credit) ---
    // Property: The output 'y' should match the expected value 2 cycles after inputs are sampled
    property p_check_result;
        logic signed [7:0] local_a [4];
        logic signed [7:0] local_b [4];
        logic signed [15:0] local_expected;
        (1, local_a = a, local_b = b, local_expected = get_expected(a, b)) ##2 (y == local_expected);
    endproperty

    assert_dot_product: assert property (@(posedge clk) disable iff (rst) p_check_result)
        else $error("Mismatch! Y=%d, Expected=%d", y, $past(get_expected(a, b), 2)); 
        // Note: $past is used here for the display message to match the 2-cycle latency

endmodule
