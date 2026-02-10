`timescale 1ns / 10ps

module cla (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output Cout,
    output [3:0] S
);

  // create the generate and propagate and buffers for carries
  wire [3:0] Generate;
  wire [3:0] Propogate;
  wire temp_carry[2:0];

  // define the logic for the generate and propagate
  assign Generate = A & B;
  assign Propogate = A ^ B;

  // define the logic for the buffer carries and output carry
  assign temp_carry[0] = Generate[0] | (Propogate[0] & Cin);
  assign temp_carry[1] = Generate[1] | (Propogate[1] & Generate[0]) | (Propogate[1] & Propogate[0] & Cin);
  assign temp_carry[2] = Generate[2] | (Propogate[2] & Generate[1]) | (Propogate[2] & Propogate[1] & Generate[0]) | (Propogate[2] & Propogate[1] & Propogate[0] & Cin);
  assign Cout = Generate[3] | (Propogate[3] & Generate[2]) | (Propogate[3] & Propogate[2] & Generate[1]) |
(Propogate[3] & Propogate[2] & Propogate[1] & Generate[0]) | (Propogate[3] & Propogate[2] & Propogate[1] & Propogate[0] & Cin);

  // defining the summation logic
  assign S[0] = Propogate[0] ^ Cin;
  assign S[1] = Propogate[1] ^ temp_carry[0];
  assign S[2] = Propogate[2] ^ temp_carry[1];
  assign S[3] = Propogate[3] ^ temp_carry[2];

endmodule

