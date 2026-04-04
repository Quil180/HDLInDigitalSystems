`timescale 1ns / 1ps

module tb_top;
  reg clk;
  reg reset;
  reg [7:0] x_in;
  wire [7:0] x_out_un;
  wire [7:0] x_out_pipe;

  // Simulation reference function (C code logic)
  function [7:0] c_ref(input [7:0] val);
    integer i;
    reg [7:0] x;
    begin
      x = val;
      for (i = 0; i < 3; i++) begin
        x = 2 * x + 1;
      end
      c_ref = x;
    end
  endfunction

  // Clock generation: 100MHz (10ns period)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Instantiate Unpipelined DUT
  unpipelined dut_un (
      .clk  (clk),
      .reset(reset),
      .x_in (x_in),
      .x_out(x_out_un)
  );

  // Instantiate Pipelined DUT
  pipelined dut_pipe (
      .clk  (clk),
      .reset(reset),
      .x_in (x_in),
      .x_out(x_out_pipe)
  );

  // Input generation and checking
  reg [7:0] in_queue[$];
  reg [7:0] pipe_in_queue[$];
  integer pass_count = 0;
  integer fail_count = 0;

  initial begin
    // Initialize
    reset = 1;
    x_in  = 0;
    #25;
    reset = 0;

    // Test Case 1: Start with x = 0 (per C code)
    @(posedge clk);
    x_in = 8'd0;
    in_queue.push_back(x_in);
    pipe_in_queue.push_back(x_in);

    // Test Case 2-10: Random inputs
    repeat (10) begin
      @(posedge clk);
      x_in = $urandom_range(0, 30);  // Prevent overflow in 8-bit (x*8 + 7)
      in_queue.push_back(x_in);
      pipe_in_queue.push_back(x_in);
    end

    // Wait for pipeline to drain
    repeat (5) @(posedge clk);

    if (fail_count == 0) $display("TEST PASSED: All results match C reference.");
    else $display("TEST FAILED: %0d mismatches detected.", fail_count);

    $finish;
  end

  // Unpipelined checker (1-cycle latency)
  reg [7:0] check_in_un;
  always @(posedge clk) begin
    if (!reset && in_queue.size() > 0) begin
      check_in_un = in_queue.pop_front();
      @(posedge clk);  // Result available next cycle
      assert (x_out_un === c_ref(
          check_in_un
      )) begin
        pass_count++;
      end else begin
        fail_count++;
        $error("Unpipelined Mismatch! In: %0d, Out: %0d, Expected: %0d", check_in_un, x_out_un,
               c_ref(check_in_un));
      end
    end
  end

  // Pipelined checker (3-cycle latency)
  reg [7:0] check_in_pipe;
  always @(posedge clk) begin
    if (!reset && pipe_in_queue.size() > 0) begin
      check_in_pipe = pipe_in_queue.pop_front();
      repeat (3) @(posedge clk);  // Result available after 3 cycles
      assert (x_out_pipe === c_ref(
          check_in_pipe
      )) begin
        pass_count++;
      end else begin
        fail_count++;
        $error("Pipelined Mismatch! In: %0d, Out: %0d, Expected: %0d", check_in_pipe, x_out_pipe,
               c_ref(check_in_pipe));
      end
    end
  end

endmodule
