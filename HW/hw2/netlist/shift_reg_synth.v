/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : X-2025.06-SP4
// Date      : Mon Mar  2 14:41:31 2026
/////////////////////////////////////////////////////////////


module shift_reg ( clk, reset, shift_en, data_in, data_out );
  input [7:0] data_in;
  output [7:0] data_out;
  input clk, reset, shift_en;
  wire   N0, \stages[2][7] , \stages[2][6] , \stages[2][5] , \stages[2][4] ,
         \stages[2][3] , \stages[2][2] , \stages[2][1] , \stages[2][0] ,
         \stages[1][7] , \stages[1][6] , \stages[1][5] , \stages[1][4] ,
         \stages[1][3] , \stages[1][2] , \stages[1][1] , \stages[1][0] ,
         \stages[0][7] , \stages[0][6] , \stages[0][5] , \stages[0][4] ,
         \stages[0][3] , \stages[0][2] , \stages[0][1] , \stages[0][0] , N1,
         N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30,
         N31, N32, N33, N34, N35, N36, N37;

  \**SEQGEN**  \stages_reg[3][7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N35), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[7]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N34), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[6]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N33), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[5]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N32), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[4]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N31), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[3]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N30), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[2]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N29), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[1]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[3][0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N28), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(data_out[0]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N27), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][7] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N26), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][6] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N25), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][5] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N24), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][4] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N23), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][3] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N22), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][2] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N21), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][1] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[2][0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N20), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[2][0] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N19), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][7] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N18), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][6] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N17), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][5] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N16), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][4] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N15), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][3] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N14), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][2] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N13), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][1] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[1][0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N12), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[1][0] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N11), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][7] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N10), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][6] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N9), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][5] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N8), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][4] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N7), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][3] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N6), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][2] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N5), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][1] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  \**SEQGEN**  \stages_reg[0][0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        N4), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        \stages[0][0] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N3) );
  SELECT_OP C81 ( .DATA1(1'b1), .DATA2(1'b1), .DATA3(1'b0), .CONTROL1(N0), 
        .CONTROL2(N37), .CONTROL3(N2), .Z(N3) );
  GTECH_BUF B_0 ( .A(reset), .Z(N0) );
  SELECT_OP C82 ( .DATA1({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .DATA2({\stages[2][7] , \stages[2][6] , \stages[2][5] , \stages[2][4] , 
        \stages[2][3] , \stages[2][2] , \stages[2][1] , \stages[2][0] , 
        \stages[1][7] , \stages[1][6] , \stages[1][5] , \stages[1][4] , 
        \stages[1][3] , \stages[1][2] , \stages[1][1] , \stages[1][0] , 
        \stages[0][7] , \stages[0][6] , \stages[0][5] , \stages[0][4] , 
        \stages[0][3] , \stages[0][2] , \stages[0][1] , \stages[0][0] , 
        data_in}), .CONTROL1(N0), .CONTROL2(N37), .Z({N35, N34, N33, N32, N31, 
        N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, N20, N19, N18, N17, 
        N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, N5, N4}) );
  GTECH_OR2 C87 ( .A(shift_en), .B(reset), .Z(N1) );
  GTECH_NOT I_0 ( .A(N1), .Z(N2) );
  GTECH_NOT I_1 ( .A(reset), .Z(N36) );
  GTECH_AND2 C90 ( .A(shift_en), .B(N36), .Z(N37) );
endmodule

