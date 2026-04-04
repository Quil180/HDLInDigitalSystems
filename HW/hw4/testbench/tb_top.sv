`timescale 1ns / 1ps

module tb_top;
  // Import C function via DPI-C
  import "DPI-C" function byte c_ref_c(input byte val);

  reg clk;
  reg reset;
  reg [7:0] x_in;
  wire [7:0] x_out_un;
  wire [7:0] x_out_pipe;

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

  // Scoreboard / Delay line
  reg [7:0] pipe_un [1:1];
  reg [7:0] pipe_p  [1:3];
  integer pass_count = 0;
  integer fail_count = 0;
  integer i;

  always @(posedge clk) begin
    if (reset) begin
      for (i = 1; i <= 1; i++) pipe_un[i] <= 0;
      for (i = 1; i <= 3; i++) pipe_p[i]  <= 0;
    end else begin
      pipe_un[1] <= x_in;
      pipe_p[1]  <= x_in;
      pipe_p[2]  <= pipe_p[1];
      pipe_p[3]  <= pipe_p[2];
    end
  end

  // Checking logic
  reg active_check = 0;
  always @(negedge clk) begin
    if (!reset && active_check) begin
      $display("Time: %0t | In(un): %0d -> Out(un): %0d [Exp: %0d] | In(pipe): %0d -> Out(pipe): %0d [Exp: %0d]", 
               $time, pipe_un[1], x_out_un, c_ref_c(pipe_un[1]), pipe_p[3], x_out_pipe, c_ref_c(pipe_p[3]));
      
      // Check Unpipelined (1 cycle latency) using C DPI
      if (x_out_un !== c_ref_c(pipe_un[1])) begin
        $error("Unpipelined Mismatch! In: %0d, Out: %0d, Expected(C): %0d", pipe_un[1], x_out_un, c_ref_c(pipe_un[1]));
        fail_count++;
      end else begin
        pass_count++;
      end

      // Check Pipelined (3 cycles latency) using C DPI
      if (x_out_pipe !== c_ref_c(pipe_p[3])) begin
        $error("Pipelined Mismatch! In: %0d, Out: %0d, Expected(C): %0d", pipe_p[3], x_out_pipe, c_ref_c(pipe_p[3]));
        fail_count++;
      end else begin
        pass_count++;
      end
    end
  end

  initial begin
    // Initialize
    reset = 1;
    x_in  = 0;
    active_check = 0;
    repeat (5) @(posedge clk);
    reset = 0;

    // Test Case 1: Start with x = 0 (per C code)
    @(posedge clk);
    x_in <= 8'd0;
    
    // Wait for first input to reach checkers
    repeat (1) @(posedge clk);
    active_check = 1;

    // Test Case 2-11: Random inputs
    repeat (10) begin
      @(posedge clk);
      x_in <= $urandom_range(0, 30);  // Prevent overflow in 8-bit (x*8 + 7)
    end

    // Wait for pipeline to drain
    repeat (5) @(posedge clk);
    active_check = 0;

    if (fail_count == 0 && pass_count > 0) 
      $display("TEST PASSED: %0d results match C reference via DPI-C.", pass_count);
    else 
      $display("TEST FAILED: %0d mismatches detected.", fail_count);

    $finish;
  end

endmodule
