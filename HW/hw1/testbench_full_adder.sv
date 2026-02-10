`timescale 1ns / 10ps

module testbench_full_adder ();

  // Inputs
  reg [3:0] A, B;
  reg Cin;

  // Outputs
  wire [3:0] out_rca, out_cla, cout_rca, cout_cla;

  cla cla_adder (
      .A(A),
      .B(B),
      .Cin(Cin),
      .Cout(cout_cla),
      .S(out_cla)
  );
  rca rca_adder (
      .A(A),
      .B(B),
      .Cin(Cin),
      .Cout(cout_rca),
      .S(out_rca)
  );

  initial begin
    A   = 'b0;
    B   = 'b0;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin));
    assert ({cout_rca, out_rca} == (A + B + Cin));

    A   = 'b1111;
    B   = 'b0001;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin));
    assert ({cout_rca, out_rca} == (A + B + Cin));

    A   = 'b1010;
    B   = 'b0101;
    Cin = 'b1;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin));
    assert ({cout_rca, out_rca} == (A + B + Cin));

    A   = 'b1111;
    B   = 'b1111;
    Cin = 'b1;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin));
    assert ({cout_rca, out_rca} == (A + B + Cin));

    A   = 'b0111;
    B   = 'b0001;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin));
    assert ({cout_rca, out_rca} == (A + B + Cin));

    #50;

    $finish;
  end

endmodule
