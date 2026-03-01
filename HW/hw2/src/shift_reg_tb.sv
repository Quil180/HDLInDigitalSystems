`timescale 1ns / 10ps

module shift_reg_tb;

  // Inputs to the DUT are declared as 'reg'
  reg clk;
  reg reset;
  reg shift_en;
  reg [7:0] data_in;

  // Outputs from the DUT are declared as 'wire'
  wire [7:0] data_out;  // Assumed 8-bit output, adjust if your module differs

  // match your actual Verilog design file.
  shift_reg dut (
      .clk(clk),
      .reset(reset),
      .shift_en(shift_en),
      .data_in(data_in),
      .data_out(data_out)
  );

  // Generates a clock with a 10ns period, matching the #10 step delays in your stimulus
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // 4. Your Stimulus Block
  initial begin
    // Dumpfile setup for "shift.vcd"
    $dumpfile("shift.vcd");
    // Adjusted to match the testbench module name 'shift_reg_tb'
    $dumpvars(0, shift_reg_tb);

    // Reset sequence
    reset = 1;
    shift_en = 0;
    data_in = 8'hAA;
    #15;
    reset = 0;

    // Cycles 1-4: shift_en = 1, incrementing data_in
    shift_en = 1;
    data_in = 8'h11;
    #10;
    data_in = 8'h22;
    #10;
    data_in = 8'h33;
    #10;
    data_in = 8'h44;
    #10;

    // Cycles 5-6: shift_en = 0 (hold state)
    shift_en = 0;
    #20;

    // Cycle 7: shift_en = 1, data_in = 8'hFF
    shift_en = 1;
    data_in  = 8'hFF;
    #10;

    // Wait remaining time to hit 100ns total simulation time
    // Time elapsed: 15 (reset) + 40 (c1-4) + 20 (c5-6) + 10 (c7) = 85ns
    #15;

    $finish;
  end

endmodule
