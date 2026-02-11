`timescale 1ns / 10ps

module full_adder (
    input  a,
    input  b,
    input  c_in,
    output c_out,
    output sum
);

  assign #1 sum   = a ^ b ^ c_in;
  assign #1 c_out = (a & b) | (b & c_in) | (a & c_in);

endmodule

