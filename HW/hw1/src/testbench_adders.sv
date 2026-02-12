`timescale 1ns / 20ps

module testbench_adders ();

  // Inputs
  reg [3:0] A, B;
  reg Cin;

  // Outputs
  wire [3:0] out_rca, out_cla;
  wire cout_rca, cout_cla;

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
    $fsdbDumpfile("dump.fsdb");
    $fsdbDumpvars(0, testbench_adders);

    A   = 'b0;
    B   = 'b0;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin)) else $display("UHOH SPEGHATTI");
    assert ({cout_rca, out_rca} == (A + B + Cin)) else $display("UHOH SPEGHATTI");

    A   = 'b1111;
    B   = 'b0001;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin)) else $display("UHOH SPEGHATTI");
    assert ({cout_rca, out_rca} == (A + B + Cin)) else $display("UHOH SPEGHATTI");

    A   = 'b1010;
    B   = 'b0101;
    Cin = 'b1;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin)) else $display("UHOH SPEGHATTI");
    assert ({cout_rca, out_rca} == (A + B + Cin)) else $display("UHOH SPEGHATTI");

    A   = 'b1111;
    B   = 'b1111;
    Cin = 'b1;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin)) else $display("UHOH SPEGHATTI");
    assert ({cout_rca, out_rca} == (A + B + Cin)) else $display("UHOH SPEGHATTI");

    A   = 'b0111;
    B   = 'b0001;
    Cin = 'b0;
    #10;
    assert ({cout_cla, out_cla} == (A + B + Cin)) else $display("UHOH SPEGHATTI");
    assert ({cout_rca, out_rca} == (A + B + Cin)) else $display("UHOH SPEGHATTI");

    #50;

    $finish;
  end

endmodule
