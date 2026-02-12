`timescale 1ns / 10ps

module rca (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output Cout,
    output [3:0] S
);

  genvar i;
  wire [4:0] carry_temp;  // propogate

  // b0 is lsb, for context
  generate
    for (i = 0; i < 4; i = i + 1) begin : g_adder_loop
      full_adder adder (
          .a(A[i]),
          .b(B[i]),
          .c_in(carry_temp[i]),
          .c_out(carry_temp[i+1]),
          .sum(S[i])
      );
    end
  endgenerate

  assign Cout = carry_temp[4];  // the c_out is always the MSB of the temp_carry
  assign carry_temp[0] = Cin;

endmodule

