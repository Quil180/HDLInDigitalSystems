`timescale 1ns/1ps

// Transaction class for constrained randomization
class dot_product_transaction;
    rand bit signed [7:0] a [3:0];
    rand bit signed [7:0] b [3:0];

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

    parameter int DATA_WIDTH = 8;
    parameter int VECTOR_SIZE = 4;
    parameter int OUT_WIDTH = 16;
    parameter int CLK_PERIOD = 10;

    logic                      clk;
    logic                      rst;
    logic signed [7:0] a [3:0];
    logic signed [7:0] b [3:0];
    logic signed [15:0] y;

    // Instantiate DUT
    dot_product #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_SIZE(VECTOR_SIZE),
        .OUT_WIDTH(OUT_WIDTH)
    ) dut (.*);

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Reference model
    function signed [15:0] get_expected(
        logic signed [7:0] va [3:0],
        logic signed [7:0] vb [3:0]
    );
        int sum = 0;
        for (int i = 0; i < 4; i++) begin
            sum += va[i] * vb[i];
        end
        return signed'(sum[15:0]);
    endfunction

    initial begin
        dot_product_transaction tr;
        tr = new();

        $display("\n[Time %0t] Simulation Started", $time);
        
        // Synchronous Reset
        rst = 1;
        foreach (a[i]) a[i] = 0;
        foreach (b[i]) b[i] = 0;
        repeat (2) @(posedge clk);
        
        @(negedge clk);
        rst = 0;
        $display("[Time %0t] Reset De-asserted", $time);

        // Run 20 randomized test cases
        $display("\nStarting Randomized Tests...");
        for (int i = 1; i <= 20; i++) begin
            if (!tr.randomize()) $fatal("Randomization failed");
            
            @(negedge clk);
            foreach (a[j]) a[j] = tr.a[j];
            foreach (b[j]) b[j] = tr.b[j];
            
            $display("[Time %0t] Iteration %0d: Driven A={%d,%d,%d,%d} B={%d,%d,%d,%d} | Expected Y (at +3 cycles) = %d", 
                     $time, i, a[3], a[2], a[1], a[0], b[3], b[2], b[1], b[0], get_expected(a, b));
        end

        repeat (10) @(posedge clk);
        $display("Done: 20 Randomized Tests Completed.");
        $finish;
    end

    // --- SystemVerilog Assertions (Extra Credit) ---
    // In a 2-stage pipeline with registered output:
    // T0: Inputs sampled at posedge
    // T1: products_reg updated (Stage 1)
    // T2: y updated (Stage 2)
    // T3: SVA samples y (Preponed region at T3 edge sees y set at T2)
    property p_check_result;
        logic signed [15:0] local_exp;
        @(posedge clk) disable iff (rst)
        (1, local_exp = get_expected(a, b)) ##3 (y == local_exp);
    endproperty

    assert_dot_product: assert property (p_check_result)
        else $error("Mismatch! Y=%d, Expected=%d", y, $past(get_expected(a, b), 3));

endmodule
