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
    parameter int OUT_WIDTH = 18;
    parameter int CLK_PERIOD = 10;

    logic                      clk;
    logic                      rst;
    logic                      vld_in;
    logic                      vld_out;
    logic signed [7:0] a [3:0];
    logic signed [7:0] b [3:0];
    logic signed [OUT_WIDTH-1:0] y;

    // Instantiate DUT
    dot_product #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_SIZE(VECTOR_SIZE),
        .OUT_WIDTH(OUT_WIDTH)
    ) dut (.*);

    // Clock generation - Guaranteed synchronous 10ns period
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Verdi Waveform Dumping
    initial begin
        $fsdbDumpfile("inter.fsdb");
        $fsdbDumpvars(0, dot_product_tb, "+all", "+mda");
    end

    // Reference model
    function automatic signed [OUT_WIDTH-1:0] get_expected(
        logic signed [7:0] va [3:0],
        logic signed [7:0] vb [3:0]
    );
        longint sum = 0;
        for (int i = 0; i < 4; i++) begin
            sum += longint'(va[i]) * longint'(vb[i]);
        end
        return signed'(sum[OUT_WIDTH-1:0]);
    endfunction

    initial begin
        dot_product_transaction tr;
        tr = new();

        $display("\n[Time %0t] Simulation Started", $time);
        
        // Synchronous Reset
        rst = 1;
        vld_in = 0;
        foreach (a[i]) a[i] = 0;
        foreach (b[i]) b[i] = 0;
        repeat (3) @(posedge clk);
        
        @(negedge clk);
        rst = 0;
        $display("[Time %0t] Reset De-asserted", $time);

        // Run 20 randomized test cases
        $display("\nStarting Randomized Tests...");
        for (int i = 1; i <= 20; i++) begin
            if (!tr.randomize()) $fatal("Randomization failed");
            
            @(negedge clk);
            vld_in = 1;
            foreach (a[j]) a[j] = tr.a[j];
            foreach (b[j]) b[j] = tr.b[j];
            
            $display("[Time %0t] Iteration %0d: Driving A={%d,%d,%d,%d} B={%d,%d,%d,%d} | Expected Y (at +2 cycles) = %d", 
                     $time, i, a[3], a[2], a[1], a[0], b[3], b[2], b[1], b[0], get_expected(a, b));
        end

        // Finish driving
        @(negedge clk);
        vld_in = 0;

        repeat (10) @(posedge clk);
        $display("Done: 20 Randomized Tests Completed.");
        $finish;
    end

    // --- SystemVerilog Assertions (Extra Credit) ---
    // Pipeline Latency = 2 cycles
    // T0: vld_in high, inputs sampled at posedge
    // T1: products_reg updated (Stage 1)
    // T2: y updated, vld_out goes high (Stage 2)
    property p_check_result;
        logic signed [OUT_WIDTH-1:0] local_exp;
        @(posedge clk) disable iff (rst)
        vld_in |-> (1, local_exp = get_expected(a, b)) ##2 (vld_out && (y == local_exp));
    endproperty

    assert_dot_product: assert property (p_check_result)
        else $error("Mismatch! Y=%d, Expected=%d", y, $past(get_expected(a, b), 2));

    // Monitor valid outputs
    always @(posedge clk) begin
        if (vld_out && !rst) begin
            $display("[Time %0t] VALID OUT: Y=%d", $time, y);
        end
    end

endmodule
