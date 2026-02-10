`timescale 1ns / 10ps

module full_adder (
    input  a,
    input  b,
    input  c_in,
    output c_out,
    output sum
);

  assign {c_out, sum} = a + b + c_in;

endmodule

