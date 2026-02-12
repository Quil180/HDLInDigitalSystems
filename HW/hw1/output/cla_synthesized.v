/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Wed Feb 11 22:45:36 2026
/////////////////////////////////////////////////////////////


module cla ( A, B, Cin, Cout, S );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76;

  IVI U27 ( .A(B[1]), .Z(n50) );
  B4IP U28 ( .A(B[2]), .Z(n42) );
  B4IP U29 ( .A(A[0]), .Z(n25) );
  IVI U30 ( .A(A[0]), .Z(n51) );
  B4IP U31 ( .A(B[0]), .Z(n26) );
  IVI U32 ( .A(B[0]), .Z(n52) );
  B4IP U33 ( .A(B[1]), .Z(n27) );
  B4IP U34 ( .A(A[1]), .Z(n28) );
  IVI U35 ( .A(Cin), .Z(n29) );
  ND2I U36 ( .A(A[0]), .B(B[0]), .Z(n30) );
  ND2I U37 ( .A(n55), .B(n30), .Z(n31) );
  ND2I U38 ( .A(n62), .B(n49), .Z(n32) );
  B4IP U39 ( .A(A[2]), .Z(n33) );
  IVI U40 ( .A(B[2]), .Z(n34) );
  ND2I U41 ( .A(A[1]), .B(B[1]), .Z(n35) );
  ND2I U42 ( .A(n52), .B(n51), .Z(n36) );
  ND2I U43 ( .A(n26), .B(n25), .Z(n37) );
  ND2I U44 ( .A(n53), .B(n37), .Z(n38) );
  IVI U45 ( .A(A[2]), .Z(n41) );
  IVI U46 ( .A(A[1]), .Z(n49) );
  IVI U47 ( .A(Cin), .Z(n55) );
  IVI U48 ( .A(B[1]), .Z(n62) );
  IVDAP U49 ( .A(B[3]), .Y(n40) );
  IVDAP U50 ( .A(A[3]), .Y(n39) );
  ND2I U51 ( .A(n40), .B(n39), .Z(n45) );
  AN2I U52 ( .A(n34), .B(n41), .Z(n43) );
  ND2I U53 ( .A(B[3]), .B(A[3]), .Z(n46) );
  ND2I U54 ( .A(n43), .B(n46), .Z(n44) );
  AN2I U55 ( .A(n45), .B(n44), .Z(n59) );
  IVDAP U56 ( .A(n46), .Y(n48) );
  ND2I U57 ( .A(B[2]), .B(A[2]), .Z(n47) );
  ND2I U58 ( .A(A[1]), .B(B[1]), .Z(n66) );
  ND2I U59 ( .A(n47), .B(n66), .Z(n70) );
  NR2I U60 ( .A(n48), .B(n70), .Z(n57) );
  ND2I U61 ( .A(n27), .B(n28), .Z(n53) );
  ND2I U62 ( .A(n32), .B(n36), .Z(n73) );
  IVI U63 ( .A(n73), .Z(n56) );
  ND2I U64 ( .A(A[0]), .B(B[0]), .Z(n54) );
  ND2I U65 ( .A(n29), .B(n54), .Z(n69) );
  ND2I U66 ( .A(n56), .B(n31), .Z(n65) );
  ND2I U67 ( .A(n57), .B(n65), .Z(n58) );
  ND2I U68 ( .A(n59), .B(n58), .Z(n60) );
  IVI U69 ( .A(n60), .Z(Cout) );
  ENI U70 ( .A(B[0]), .B(A[0]), .Z(n61) );
  ENI U71 ( .A(n61), .B(Cin), .Z(S[0]) );
  ND2I U72 ( .A(n37), .B(n31), .Z(n64) );
  ENI U73 ( .A(n50), .B(A[1]), .Z(n63) );
  ENI U74 ( .A(n64), .B(n63), .Z(S[1]) );
  ND2I U75 ( .A(n35), .B(n65), .Z(n68) );
  ENI U76 ( .A(B[2]), .B(A[2]), .Z(n67) );
  ENI U77 ( .A(n68), .B(n67), .Z(S[2]) );
  ND2I U78 ( .A(n42), .B(n33), .Z(n71) );
  ND2I U79 ( .A(n71), .B(n69), .Z(n74) );
  ND2I U80 ( .A(n71), .B(n70), .Z(n72) );
  AO7P U81 ( .A(n74), .B(n38), .C(n72), .Z(n76) );
  ENI U82 ( .A(B[3]), .B(A[3]), .Z(n75) );
  ENI U83 ( .A(n76), .B(n75), .Z(S[3]) );
endmodule

