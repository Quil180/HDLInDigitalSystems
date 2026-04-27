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
        int sum = 0;
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
        
        // Synchronous Reset
        rst = 1;
        foreach (a[i]) a[i] = 0;
        foreach (b[i]) b[i] = 0;
        repeat (2) @(posedge clk);
        
        // Drive at negedge to avoid races
        @(negedge clk);
        rst = 0;
        $display("[Time %0t] Reset De-asserted", $time);

        // Run 20 randomized test cases
        $display("\nStarting Randomized Tests...");
        for (int i = 1; i <= 20; i++) begin
            if (!tr.randomize()) $fatal("Randomization failed");
            
            // Drive inputs on negedge
            @(negedge clk);
            foreach (a[j]) a[j] = tr.a[j];
            foreach (b[j]) b[j] = tr.b[j];
            
            // The DUT will sample these at the NEXT posedge
            $display("[Time %0t] Iteration %0d/20: Inputs Driven", $time, i);
        end

        // Wait for pipeline to drain
        repeat (5) @(posedge clk);
        
        $display("Done: 20 Randomized Tests Completed.");
        $finish;
    end

    // --- SystemVerilog Assertions (Extra Credit) ---
    // Capture expected value at posedge and check it 2 cycles later
    property p_check_result;
        logic signed [OUT_WIDTH-1:0] local_exp;
        @(posedge clk) disable iff (rst)
        (1, local_exp = get_expected(a, b)) ##2 (y == local_exp);
    endproperty

    assert_dot_product: assert property (p_check_result)
        else $error("Mismatch at time %0t! Y=%d, Expected=%d", $time, y, $past(get_expected(a, b), 2));

endmodule
